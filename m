Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVDBFNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDBFNR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 00:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVDBFNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 00:13:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49061 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261692AbVDBFNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 00:13:13 -0500
Date: Sat, 2 Apr 2005 07:12:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
Message-ID: <20050402051254.GA23786@elte.hu>
References: <20050325145908.GA7146@elte.hu> <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com> <200504011834.22600.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504011834.22600.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> Apr  1 18:05:20 coyote ieee1394.agent[6016]: ... no drivers for IEEE1394 product 0x/0x/0x
> Apr  1 18:05:24 coyote kernel:
> Apr  1 18:05:24 coyote kernel: ==========================================
> Apr  1 18:05:24 coyote kernel: [ BUG: lock recursion deadlock detected! |
> Apr  1 18:05:24 coyote kernel: ------------------------------------------
> Apr  1 18:05:24 coyote kernel: already locked:  [e4d17228] {(struct semaphore *)(&fi->complete_sem)}
> Apr  1 18:05:24 coyote kernel: .. held by:              kino: 6082 [e13ecbb0, 118]
> Apr  1 18:05:24 coyote kernel: ... acquired at:  raw1394_read+0x104/0x110 [raw1394]

hm - does the patch below help? (or -43-06 which has the same patch)

	Ingo

--- linux/drivers/ieee1394/raw1394-private.h.orig
+++ linux/drivers/ieee1394/raw1394-private.h
@@ -29,7 +29,7 @@ struct file_info {
 
         struct list_head req_pending;
         struct list_head req_complete;
-        struct semaphore complete_sem;
+        struct compat_semaphore complete_sem;
         spinlock_t reqlists_lock;
         wait_queue_head_t poll_wait_complete;
 

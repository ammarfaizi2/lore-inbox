Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUJLOW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUJLOW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJLOW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:22:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44521 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262406AbUJLOWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:22:24 -0400
Date: Tue, 12 Oct 2004 16:23:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Lee Revell <rlrevell@joe-job.com>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       mark_h_johnson@raytheon.com
Subject: Re: VP-2.6.9-rc4-mm1-T7
Message-ID: <20041012142338.GA7632@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <32080.195.245.190.93.1097589566.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32080.195.245.190.93.1097589566.squirrel@195.245.190.93>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK. 2.6.9-rc4-mm1-T7 builds and runs on my laptop (P4/UP), apparently
> fine. I know it's probably too early to complain, but I'm sending a
> couple of dmesg's that I took right after init, showing some badness
> going on.

does the patch below ontop of T7 fix these messages for you?

	Ingo

--- linux/sound/pci/ali5451/ali5451.c.orig
+++ linux/sound/pci/ali5451/ali5451.c
@@ -261,8 +261,8 @@ struct snd_stru_ali {
 	unsigned short	ac97_ext_id;
 	unsigned short	ac97_ext_status;
 
-	spinlock_t	reg_lock;
-	spinlock_t	voice_alloc;
+	raw_spinlock_t	reg_lock;
+	raw_spinlock_t	voice_alloc;
 
 #ifdef CONFIG_PM
 	ali_image_t *image;
--- linux/fs/fcntl.c.orig
+++ linux/fs/fcntl.c
@@ -541,7 +541,7 @@ int send_sigurg(struct fown_struct *fown
 	return ret;
 }
 
-static rwlock_t fasync_lock = RW_LOCK_UNLOCKED;
+static DECLARE_RAW_RWLOCK(fasync_lock);
 static kmem_cache_t *fasync_cache;
 
 /*

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUKNMgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUKNMgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUKNMgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:36:37 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40092 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261295AbUKNMgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:36:36 -0500
Date: Sun, 14 Nov 2004 13:38:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041114123818.GA10772@elte.hu>
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <41951380.2080801@spymac.com> <20041112201936.GA15133@elte.hu> <419694EC.7090701@spymac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419694EC.7090701@spymac.com>
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


* Gunther Persoons <gunther_persoons@spymac.com> wrote:

> this bug i got with .26
> wget:12388 BUG: lock held at task exit time!
> [c03ec764] {kernel_sem.lock}
> .. held by:              wget:12388 [c87d2680, 116]
> ... acquired at:  __lock_text_start+0x2c/0x63

i've uploaded .26-1 which has special BKL-debugging code added, which
will (hopefully) pinpoint where the BKL count leaked. (Karsten had
similar problems, with NFS.)

so, could you try .26-1 from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

and make sure you still have CONFIG_RT_DEADLOCK_DETECT enabled. When
this warning message hits next time around it should print some more
info about the place that last acquired the BKL.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUJLP0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUJLP0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJLP0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:26:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46554 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265978AbUJLPZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:25:54 -0400
Date: Tue, 12 Oct 2004 17:27:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
Message-ID: <20041012152713.GA16393@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <416BF44E.6080309@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416BF44E.6080309@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> OK. This one builds just fine here. Again I tried booting preempt
> realtime. We were going along fine and then all hell broke loose on
> the console. Pressed Ctrl-s to stop the scrolling and it then bit the
> dust.  It did manage to get into the logs this time and I am attaching
> that.  This is a different SMP system that I use as a workstation at a
> client site. Dual 2.6GHz Xeons (with HT) 512MB

does the patch below make your system bootable? It should fix the two
most common messages you got.

	Ingo

--- linux/kernel/profile.c.orig
+++ linux/kernel/profile.c
@@ -169,7 +169,7 @@ int profile_event_unregister(enum profil
 }
 
 static struct notifier_block * profile_listeners;
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
+static raw_rwlock_t profile_lock = RAW_RW_LOCK_UNLOCKED;
  
 int register_profile_notifier(struct notifier_block * nb)
 {
--- linux/drivers/net/3c59x.c.orig
+++ linux/drivers/net/3c59x.c
@@ -832,8 +832,8 @@ struct vortex_private {
 	u16 deferred;						/* Resend these interrupts when we
 										 * bale from the ISR */
 	u16 io_size;						/* Size of PCI region (for release_region) */
-	spinlock_t lock;					/* Serialise access to device & its vortex_private */
-	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
+	raw_spinlock_t lock;					/* Serialise access to device & its vortex_private */
+	raw_spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
 	struct mii_if_info mii;				/* MII lib hooks/info */
 };
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbUKDT55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUKDT55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUKDTzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:55:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22505 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262381AbUKDTwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:52:17 -0500
Date: Thu, 4 Nov 2004 20:52:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104195206.GB11672@elte.hu>
References: <OF88A40911.ECF57E25-ON86256F42.006C01DC-86256F42.006C0216@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF88A40911.ECF57E25-ON86256F42.006C01DC-86256F42.006C0216@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> 1) ksoftirqd/0/3 is trying to acquire this lock:
>  [dfb5c8a4] {r:0,a:-1,&n->lock}
> .. held by:       ksoftirqd/1/    6 [dff886f0,   0]
> ... acquired at:  arp_solicit+0x167/0x230
> ... trying at:   neigh_update+0x2a/0x390
> 
> 2) ksoftirqd/1/6 is blocked on this lock:
>  [c03c8900] {r:1,a:-1,ptype_lock}
> .. held by:       ksoftirqd/0/    3 [dffe8020,   0]
> ... acquired at:  net_rx_action+0x8e/0x200

this is a weird one. Note how ptype_lock is not shown to be owned by
ksoftirqd/0/3:

> ------------------------------
> | showing all locks held by: |  (ksoftirqd/0/3 [dffe8020,   0]):
> ------------------------------
> 
> #001:             [d9044c30] {r:0,a:-1,&tp->rx_lock}
> ... acquired at:  rtl8139_poll+0x48/0x180 [8139too]

neither does ptype_lock show up in the other logs you sent.

	Ingo

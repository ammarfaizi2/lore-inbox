Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUELUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUELUIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUELUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:08:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2541 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265212AbUELUIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:08:16 -0400
Date: Wed, 12 May 2004 22:03:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-ID: <20040512200305.GA16078@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Davide Libenzi <davidel@xmailserver.org> wrote:

> > why is it wrong?
> 
> For HZ == 1000 it's fine, even if it'd better to explicitly make it HZ
> dependent and let the compiler to discard them.

the compiler cannot discard the multiplication and the division from the
following:

	x * 1000 / 1000

due to overflows. But we know that HZ is 1000 in the arch-dependent
param.h, and in sched.c we use the HZ dependent variant:

 #ifndef JIFFIES_TO_MSEC
 # define JIFFIES_TO_MSEC(x) ((x) * 1000 / HZ)
 #endif
 #ifndef MSEC_TO_JIFFIES
 # define MSEC_TO_JIFFIES(x) ((x) * HZ / 1000)
 #endif

	Ingo

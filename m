Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUGUFid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUGUFid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 01:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUGUFid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 01:38:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13231 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266458AbUGUFib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 01:38:31 -0400
Date: Wed, 21 Jul 2004 07:30:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721053007.GA8376@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721000348.39dd3716.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> >  discovered I can reliably produce a large XRUN by toggling Caps Lock, 
> > Scroll Lock, or Num Lock.  This is with 2.6.8-rc1-mm1 + voluntary
> > preempt
> 
> That's odd.  I wonder if the hardware is sick.  What is the duration is the
> underrun?  The info you sent didn't include that.

no, it's the ps2 driver that is sick. The ps2 keyboard driver is one of
the few places that busy-polls for IRQ completion from within a tasklet
context for things like led switching (yuck) - this can cause many
millisecs delays on all boards i tried.

	Ingo

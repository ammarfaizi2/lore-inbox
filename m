Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUHJRfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUHJRfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHJRfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:35:37 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:11666 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267488AbUHJRfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:35:00 -0400
Date: Tue, 10 Aug 2004 18:33:02 +0100
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810173302.GA22928@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
	Florian Schmidt <mista.tapas@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <20040810085849.GC26081@elte.hu> <1092157841.3290.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092157841.3290.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 01:10:42PM -0400, Lee Revell wrote:
 > On Tue, 2004-08-10 at 04:58, Ingo Molnar wrote:
 > 
 > > another idea: you are running this on a C3, using CONFIG_MCYRIXIII,
 > > correct? That is one of the rare configs that triggers X86_USE_3DNOW and
 > > MMX ops. If 3dnow is in any way handicapped in that CPU then that could
 > > cause trouble. Could you compile for e.g. CONFIG_M586TSC? [that option
 > > should be fully compatible with a C3.] - this will exclude the MMX page
 > > clearing ops.
 > > 
 > 
 > OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few happened
 > during normal desktop use, and it locks up hard when starting jackd. 
 > Could this have anything to do with the ALSA drivers (which I am
 > compiling seperately from ALSA cvs) detecting my build system as i686? 

If you have an early C3  (ie, pre Nehemiah model), then you will lack
the cmov instruction that gcc assumes is in 686's.  If the ALSA scripts
aren't aware of this, they will generate code which your CPU cannot run.

 > I have read that the C3 is more like a 486 (with MMX & 3DNow) than a
 > 686.

It's 686, just lacking various extensions. The current models have
all the same optional features you could find on a Pentium Pro,
plus a bunch of extra exclusive bits.

		Dave


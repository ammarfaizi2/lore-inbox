Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267768AbUHESyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267768AbUHESyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267909AbUHESxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:53:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:49289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267903AbUHESwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:52:31 -0400
Date: Thu, 5 Aug 2004 11:50:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040805180634.GA26732@elte.hu>
Message-ID: <Pine.LNX.4.58.0408051144520.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
 <200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org> <20040805180634.GA26732@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2004, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Anyway, one other thing that makes me worry is the fact that Gene
> > apparently has a K7. One of the things AMD has gotten wrong several
> > times is prefetching, and it so happens that the dcache code is one of
> > the users of the prefetch instruction. prude_dcache() in particular.
> 
> hm, i too happen to have an Athlon64 box (running the x86 kernel) where
> i can reproduce dcache pruning crashes after a few hours of testing
> using a near-vanilla kernel.

Very interesthing.

The K8 core (aka Opteron or Athlon64) has exactly the same prefetch page
fault bugs that the K7 core has. This, coupled with your observation

> NOTE2: i tried hard but couldnt reproduce the problem using the very
> same kernel and the same workload on a PIII box. Once i ran it overnight
> to check. Only the Athlon64 box does it. It could also be a hardware
> problem - albeit the box withstood days of memtest86.

really makes me wonder..

NOTE! Almost every time we've wondered about a CPU bug, it really wasn't. 
It usually ends up being something really subtle with memory ordering, 
with TLB updates, or something. So I'm putting the prefetch issue up on 
the table as just a wild theory. It would be interestign to see if we can 
get a bigger set of boxes with this crash.

Andi, I think you were the contact for the AMD prefetch bug. Can you ask 
around the same people whether there might be other problems in this area? 
No point in putting a lot of effort into it, but just as one thing to 
check for..

		Linus

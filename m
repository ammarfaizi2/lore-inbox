Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUJaBnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUJaBnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUJaBnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:43:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261464AbUJaBn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:43:27 -0400
Date: Sat, 30 Oct 2004 18:43:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <20041031003934.GA19396@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0410301831300.28839@ppc970.osdl.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org.suse.lists.linux.kernel>
 <p73sm7xymvd.fsf@verdi.suse.de> <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org> <20041031003934.GA19396@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Oct 2004, Andi Kleen wrote:
> 
> Using the long stack setup code was found to be a significant
> win when enough registers were saved (several percent in real benchmarks) 
> on K8 gcc. 

For _what_?

Real applications, or SpecInt?

The fact is, SpecInt is not very interesting, because it has almost _zero_
icache footprint, and it has generally big repeat-rates, and to make
matters worse, you are allowed (and everybody does) warm up the caches by
running before you actually do the benchmark run.

_None_ of these are realistic for real life workloads. 

>  It speed up all function calls considerably because it 
> eliminates several stalls for each function entry/exit. 

.. it shaves off a few cycles in the cached case, yes.

> The popls will all depend on each other because of their implicied
> reference to esp.

Which is only true on moderately stupid CPU's. Two pop's don't _really_ 
depend on each other in any real sense, and there are CPU's that will 
happily dual-issue them, or at least not stall in between (ie the pop's 
will happily keep the memory unit 100% busy).

		Linus

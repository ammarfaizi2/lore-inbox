Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUAURQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUAURQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:16:53 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:7515 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265985AbUAURQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:16:52 -0500
Message-ID: <400EB3FA.80202@samwel.tk>
Date: Wed, 21 Jan 2004 18:16:42 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@denise.shiny.it>
CC: Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk> <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk> <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk> <Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk> <Pine.LNX.4.58.0401211748130.1567@denise.shiny.it>
In-Reply-To: <Pine.LNX.4.58.0401211748130.1567@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> On Mon, 19 Jan 2004, Bart Samwel wrote:
>>But we're not talking about the base kernel here. We're not talking
>>about migrating the kernel to C++, or even modules that are part of the
>>Linux kernel source. We're talking about *independent modules*. The
>>kernel exports a module interface, and any binary driver that correctly
>>hooks into the interface of the running kernel (using the correct
>>calling conventions of the running kernel) and behaves properly (e.g.,
>>doesn't do stack unwinds over chunks of kernel functions etc.) can hook
>>into it and do useful work. If somebody has decided that it would be
>>worth it for his project to use C++ (without exceptions, rtti and the
>>whole shebang) then so be it, why should you care? It's just binary code
>>that hooks into the module interface, using the correct calling
>>conventions. It doesn't do dirty stuff -- no exceptions, no RTTI,
>>etcetera. It compiles into plain, module-interface conforming assembler,
>>that can be compiled with -- you guessed it -- 'as', the AT&T syntax
>>assembler. Yes, they're taking a risk. Their risk is that C++ can't
>>import the kernel headers, or that C++ might someday need runtime
>>support that cannot be ported into the kernel.

[...]
> Maybe the right solution is writing a module that provides a fast data
> path between the kernel and the userspace router.

Hmmm, I think that would be problematic. The throughput would probably 
be relatively OK (it's perfectly feasible to stash a load of packets 
into an mmapped area with zero copies and to have them all routed in 
userspace) but the latency is a different story. A router should be able 
to pass on packets with the lowest possible latency. I don't think it's 
feasible to schedule a userspace router process for every packet that 
comes in (they can currently do 435,000 packets per second on a P3-700), 
so that would have to be done in bulk, and that's a killer for your latency.

AFAICS the right solution would be to do it in the kernel and not to use 
C++ for it. It's a bit late for that now though. :)

-- Bart

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTJRPsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTJRPsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:48:40 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:740 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261681AbTJRPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:48:38 -0400
Date: Sat, 18 Oct 2003 08:45:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <649730000.1066491920@[10.10.2.4]>
In-Reply-To: <20031018102127.GE12423@fs.tum.de>
References: <20031015225055.GS17986@fs.tum.de> <20031015161251.7de440ab.akpm@osdl.org> <20031015232440.GU17986@fs.tum.de> <20031015165205.0cc40606.akpm@osdl.org> <20031018102127.GE12423@fs.tum.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I really doubt it.  Kernel CPU footprint is dominated by dcache misses.  If
>> -Os reduces icache footprint it may even be a net win; people tend to
>> benchmark things in tight loops, which favours fast code over small code.
> 
> The main effect of -Os compared to -O2 (besides disabling some
> reordering of the code and prefetching) is the disabling of various
> alignments. I doubt that's a win on all CPUs.
> 
>> > - I've already seen a report for an ICE in gcc 2.95 of a user compiling
>> >   kernel 2.4 with -Os [1]
>> 
>> Well there's only one way to find out if we'll hit that.  How's about you
>> cook me a patch which switches to -Os unconditionally and we'll see how it
>> goes?
> 
> I still dislike it, but the patch is below.

Please don't - I benchmarked it a while ago, and it's definitely slower.
If you have a puny 128K L2 cache, it might help, but it definitely needs
to be optional.

M.


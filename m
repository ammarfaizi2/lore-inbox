Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTIELmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 07:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbTIELmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 07:42:23 -0400
Received: from [213.39.233.138] ([213.39.233.138]:59310 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261158AbTIELmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 07:42:22 -0400
Date: Fri, 5 Sep 2003 13:42:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Fruhwirth Clemens <clemens-dated-1063536166.2852@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030905114220.GB10415@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030904104245.GA1823@leto2.endorphin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 September 2003 12:42:45 +0200, Fruhwirth Clemens wrote:
> 
> I recently posted a module for twofish which implements the algorithm in
> assembler (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)
> 
> Unfortunately the assembler used is masm. I'd like to change that. Netwide
> Assembler (nasm) is the assembler of my choice since it focuses on
> portablity and has a more powerful macro facility (macros are heavily used
> by 2fish_86.asm). But as I'd like to make my work useful (aim for an
> inclusion in the kernel) I noticed that this would be the first module to
> depend on nasm. Everything else uses gas.

Orthogonally to the nasm/gas question, there are the problems or
performance and maintenance.

Do some benchmarks on lots of different machines and measure the
performance of the asm and c code.  If it's faster on PPro but not on
PIII or Athlon, forget about it.

How big is the .text of the asm and c variant?  If the text of yours
is much bigger, you just traded 2fish performance for general
performance.  Everything else will suffer from cache misses.  Forget
your microbenchmark, your variant will make the machine slower.

How many bugs are in your code?  Are there any buffer overflows or
other security holes?  How can you be sure about it?  (Most people
aren't sure about c either, but it is much easier to check.)

If your code fails on any one of these questions, forget about it.  If
it survives them, post your results and have someone else verify them.


As to nasm/gas, you will have a hard time to explain, why joe user
needs yet another tool to compile his own kernel.  There may be good
arguments in favor, but they better be good, else translate to gas.

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown

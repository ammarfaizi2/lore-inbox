Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSJJQrL>; Thu, 10 Oct 2002 12:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJJQrL>; Thu, 10 Oct 2002 12:47:11 -0400
Received: from host194.steeleye.com ([66.206.164.34]:62982 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261688AbSJJQrK>; Thu, 10 Oct 2002 12:47:10 -0400
Message-Id: <200210101652.g9AGqrB02791@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: William Lee Irwin III <wli@holomorphy.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, mingo@redhat.com,
       johnstul@us.ibm.com, James.Bottomley@HansenPartnership.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.41 multiprocessor vs. CONFIG_X86_TSC 
In-Reply-To: Message from William Lee Irwin III <wli@holomorphy.com> 
   of "Thu, 10 Oct 2002 05:17:57 PDT." <20021010121757.GY12432@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Oct 2002 09:52:53 -0700
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 05:02:12AM -0700, Adam J. Richter wrote:
> 	2. Are there x86 multiprocessors that Linux runs on that lack the
> 	   Time Stamp Counter feature?  If so, I would welcome any
> 	   suggestions or requests on how best to fix arch/i386/smpboot.c.

> It's useless on NUMA-Q. The assumption is that they're synchronized
> and it's infeasible to synchronize them without elaborate fixup
> machinery on the things, which can at best fake it.

> wrt. Voyager et al. James Bottomley is the right person to ask.

> As far as active development on NUMA-Q and x440 in the timer arena
> goes, John Stultz knows best. 

Voyager is in the same boat as NUMA-Q.  The machines can have up to eight CPU 
card slots and each slot can take up to a quad CPU card (with the clock 
generator on the CPU card) so TSCs cannot synchronise accross the quads.  
Worse, for voyager, the CPUs and clocks can be radically different frequencies 
(I run a dual quad system here with one quad at 100MHz and one at 166MHz)

Voyager can also run with ancient dyad 486 CPU cards (I still have some) which 
do lack the TSC feature entirely.  However, I don't use the smpboot.c file to 
boot with, so if you want changes in there that's fine by me, I'll just hook 
the voyager boot sequence into them.

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbTIDS0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTIDS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:26:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:56028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265466AbTIDSZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:25:53 -0400
Date: Thu, 4 Sep 2003 11:24:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [UPDATED PATCH] EFI support for ia32 kernels
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB003D42A54@fmsmsx406.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0309041112530.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Tolentino, Matthew E wrote:
> 
> It would be nice.  It is especially nice for vendors because they can
> reuse a single driver image for multiple architectures assuming there is
> an interpreter and EFI support.

No. It would be a total nightmare.

Vendor-supplied drivers without source are going to be BUGGY.

They are going to be doubly buggy if they are run with a compiler that 
has a buggy back-end.

And that back-end is going to be buggy if it's for some random bytecode 
that isn't widely used except for some silly EFI thing and is tested 
exclusively with just a few versions of Windows and _maybe_ occasionally 
on Linux.

Face it: firmware bytecode is a total braindamage. The only thing that 
works is _source_code_ that can be fixed, and lacking that, we're better 
off with a well-defined ISA that people are used to and that has stable 
simple compilers.

In other words: x86 object code is a better choice than some random new
bytecode. It's a "bytecode" too, after all. And it's one that is stable
and runs fast on most hardware. But as long as it's some kind of binary
(and byte code is binary, don't make any mistake about it), it's going to
always be broken.

EFI is doing all the wrong things. Trying to fix BIOSes by being "more 
generic". It's going to be a total nightmare if you go down that path.

What will work is:

 - standard hardware interfaces. Instead of working on bytecode 
   interpreters, make the f*cking hardware definition instead, and make it
   SANE and PUBLIC! So that we can write drivers that work, and that come 
   with source so that we can fix them when somebody has buggy hardware.

   DO NOT MAKE ANOTHER FRIGGING BYTECODE INTERPRETER!

   Didn't Intel learn anything from past mistakes? ACPI was supposed to be 
   "simple". Codswallop.

   PCI works, because it had standard, and documented, hardware 
   interfaces. The interfaces aren't well specified enough to write a PCI
   disk driver, of course, but they _are_ good enough to do discovery and 
   a lot of things.

   Intel _could_ make a "PCI disk controller interface definition", and it 
   will work. The way USB does actually work, and UHCI was actually a fair 
   standard, even if it left _way_ too much to software.

 - Source code. LinuxBIOS works today, and is a lot more flexible than EFI 
   will _ever_ be.

 - Compatibility. Make hardware that works with old drivers and old 
   BIOSes. This works. The fact that Intel forgot about that with ia-64 is 
   not an excuse to make _more_ mistakes.

Don't screw this up. EFI is not going in the right direction.

		Linus


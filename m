Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbREOEUh>; Tue, 15 May 2001 00:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbREOEU0>; Tue, 15 May 2001 00:20:26 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:38321 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S262618AbREOEUP>; Tue, 15 May 2001 00:20:15 -0400
Date: Mon, 14 May 2001 21:19:48 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Jeff Golds <jgolds@resilience.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4 kernel reports wrong amount of physical memory 
In-Reply-To: <Pine.LNX.4.21.0105142331010.4671-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0105142116030.9796-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Rik van Riel wrote:

> It would be cool if one of you two could update the docs ;)

OK, here is my attempt, as a patch to Configure.help in 2.4.5-pre1.  I
hope it is clear, accurate, and not too long-winded, and that my mailer
does not munge patches.

Cheers,
Wayne

--- linux-2.4.5-pre1-lcd-via-3.23/Documentation/Configure.help.orig	Sat Apr 28 00:27:57 2001
+++ linux-2.4.5-pre1-lcd-via-3.23/Documentation/Configure.help	Mon May 14 21:10:30 2001
@@ -198,38 +198,39 @@

 High Memory support
 CONFIG_NOHIGHMEM
-  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
-  However, the address space of 32-bit x86 processors is only 4
-  Gigabytes large. That means that, if you have a large amount of
-  physical memory, not all of it can be "permanently mapped" by the
-  kernel. The physical memory that's not permanently mapped is called
-  "high memory".
+  Linux can use up to 64GB (64 Gigabytes) of physical memory on x86
+  systems. However, the address space of 32-bit x86 processors is only
+  4GB large. As Linux allocates 3GB of this address space to user
+  space, and the kernel reserves 128MB of address space for its needs,
+  only 896MB of address space is available for mapping physical
+  memory. This Configure option controls how the kernel uses this
+  896MB window to access physical memory.

-  If you are compiling a kernel which will never run on a machine with
-  more than 1 Gigabyte total physical RAM, answer "off" here (default
-  choice and suitable for most users). This will result in a "3GB/1GB"
-  split: 3GB are mapped so that each process sees a 3GB virtual memory
-  space and the remaining part of the 4GB virtual memory space is used
-  by the kernel to permanently map as much physical memory as
-  possible.
+  The default choice, "off", causes the kernel to permanently map
+  physical memory into this 896MB window. The kernel will be able
+  to use at most 896MB of physical memory, but this is fine for most
+  users.

-  If the machine has between 1 and 4 Gigabytes physical RAM, then
-  answer "4GB" here.
+  The "4GB" option allows the kernel to access up to 4GB of physical
+  memory.  This is done by dynamically mapping the physical memory
+  into the 896MB window as necessary; such dynamically mapped memory
+  is known as "high memory".

-  If more than 4 Gigabytes is used then answer "64GB" here. This
-  selection turns Intel PAE (Physical Address Extension) mode on.
-  PAE implements 3-level paging on IA32 processors. PAE is fully
-  supported by Linux, PAE mode is implemented on all recent Intel
-  processors (Pentium Pro and better). NOTE: If you say "64GB" here,
-  then the kernel will not boot on CPUs that don't support PAE!
+  The "64GB" option is necessary to support more than 4GB of physical
+  memory.  This selection turns Intel PAE (Physical Address Extension)
+  mode on.  PAE implements 3-level paging on IA32 processors. PAE is
+  fully supported by Linux and PAE mode is implemented on all recent
+  Intel processors (Pentium Pro and better). NOTE: If you say "64GB"
+  here, then the kernel will not boot on CPUs that don't support PAE!

-  The actual amount of total physical memory will either be
-  auto detected or can be forced by using a kernel command line option
+  The actual amount of total physical memory will either be auto
+  detected or can be forced by using a kernel command line option
   such as "mem=256M". (Try "man bootparam" or see the documentation of
   your boot loader (lilo or loadlin) about how to pass options to the
   kernel at boot time.)

-  If unsure, say "off".
+  If unsure, say "off" if you have 896MB or less of physical memory;
+  say "4GB" otherwise.

 Normal PC floppy disk support
 CONFIG_BLK_DEV_FD


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTLOSYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTLOSYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:24:23 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:32424 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263921AbTLOSYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:24:15 -0500
Date: Mon, 15 Dec 2003 19:23:10 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215182310.GE11260@louise.pinerecords.com>
References: <20031215173816.GC10857@louise.pinerecords.com> <6230.1071512197@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6230.1071512197@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-16 2003, Tue, 05:16 +1100
Keith Owens <kaos@ocs.com.au> wrote:

> Does gcc 3.3.2 handle sections correctly when it optimizes zero
> assignments to use bss?  With just this line in x.c
> 
> static int __attribute__ ((__section__ (".init.data"))) a1 = 0;
> 
> what does objdump -h report?  If bss is 4 bytes then gcc 3.3.2 is
> breaking the kernel's use of init data.  If bss is 0 and .init.data is
> 4 then we are OK.

$ gcc --version| grep GCC
gcc (GCC) 3.3.2
$ cat x.c
static int __attribute__ ((__section__ (".init.data"))) a1 = 0;
$ gcc -c -o x.o x.c
$ objdump -h x.o

x.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000000  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .data         00000000  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00000000  00000000  00000000  00000034  2**2
                  ALLOC
  3 .init.data    00000004  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  4 .comment      00000012  00000000  00000000  00000038  2**0
                  CONTENTS, READONLY

Good.

-- 
Tomas Szepe <szepe@pinerecords.com>

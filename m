Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSKRR76>; Mon, 18 Nov 2002 12:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSKRR76>; Mon, 18 Nov 2002 12:59:58 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:4480 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S263333AbSKRR75>;
	Mon, 18 Nov 2002 12:59:57 -0500
Date: Mon, 18 Nov 2002 19:06:56 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.48: BUG() at kernel/module.c:1000
Message-ID: <20021118180656.GA2663@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,
  I'm trying to get VMware working, and unfortunately new insmod
is not able to load generated module. It died at line 1000 of 
kernel/module.c, because of used.core_size > mod->core_size:
     INIT=0/0  CORE=34252/34228

  Do you have any idea what's wrong with generated vmmon.o?
After I did "strip -R .note vmmon.o", module was insmod-dable.
Unfortunately lsmod now says 
"KBUILD_MODNAME         34220  0 [permanent]", although there is
no explanation in dmesg why it was marked [permanent] :-(

  If you are interested, generated vmmon.o is available at
http://vana.vc.cvut.cz/vmmon.o (if vana.vc.cvut.cz is alive)
(and yes, I fixed KBUILD_MODNAME module name here already...
but with vmmon in .modulename it does not die so spectacullary).

  And if we are talking about module names, I'm using
"insmod -o dummy0 dummy.o" & "insmod -o dummy1 dummy.o" to create
two dummy interfaces. What should I do now? Compile two dummy.o,
each with different module name?
						Thanks,
							Petr Vandrovec



/tmp/vmware-config0/vmmon.o:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00006520  00000000  00000000  00000034  2**2
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .rodata       00001b3f  00000000  00000000  00006560  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  2 __ksymtab     00000040  00000000  00000000  000080a0  2**5
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  3 .data         00000010  00000000  00000000  000080e0  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  4 .modulename   0000000f  00000000  00000000  000080f0  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  5 .bss          000004ec  00000000  00000000  00008100  2**5
                  ALLOC
  6 .comment      00000150  00000000  00000000  00008100  2**0
                  CONTENTS, READONLY
  7 .note         0000008c  00000000  00000000  00008250  2**0
                  CONTENTS, READONLY


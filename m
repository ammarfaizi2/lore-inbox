Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTLWFeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 00:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTLWFeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 00:34:06 -0500
Received: from gizmo12bw.bigpond.com ([144.140.70.22]:38791 "HELO
	gizmo12bw.bigpond.com") by vger.kernel.org with SMTP
	id S264949AbTLWFd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 00:33:58 -0500
Message-ID: <3FE7D3AC.6B88A1D1@eyal.emu.id.au>
Date: Tue, 23 Dec 2003 16:33:32 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.24-pre2 - build problems
References: <Pine.LNX.4.58L.0312221753140.1384@logos.cnet>
Content-Type: multipart/mixed;
 boundary="------------F0D56FAEEA9E699B548F6CC2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F0D56FAEEA9E699B548F6CC2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes 2.4.24-pre2.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=cciss  -c -o
cciss.o cciss.
c
cciss.c: In function `cciss_pci_init':
cciss.c:2681: parse error before `prefetch'
cciss.c:2682: invalid lvalue in assignment
cciss.c:2683: invalid operands to binary |
cciss.c:2683: invalid lvalue in assignment
cciss.c:2684: warning: assignment makes integer from pointer without a
cast
make[2]: *** [cciss.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/block'

See attached patch.



gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
 -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
-DMODULE -DM
ODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions
.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=qlogicfas -DPCMCIA
-D__NO_V
ERSION__ -c -o qlogicfas.o ../qlogicfas.c
../qlogicfas.c: In function `qlogicfas_detect':
../qlogicfas.c:650: warning: passing arg 1 of
`scsi_unregister_Rae128733' from i
ncompatible pointer type
ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
qlogicfas.o: In function `init_module':
qlogicfas.o(.text+0xe40): multiple definition of `init_module'
qlogic_stub.o(.text+0x770): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
qlogicfas.o
qlogicfas.o: In function `cleanup_module':
qlogicfas.o(.text+0xe80): multiple definition of `cleanup_module'
qlogic_stub.o(.text+0x7c0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
qlogicfas.
o
make[3]: *** [qlogic_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/scsi/pcmc
ia'
make[2]: *** [_modsubdir_pcmcia] Error 2
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/scsi'

Same old problem, did not see a solution yet.
Deselecting CONFIG_SCSI_PCMCIA...

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------F0D56FAEEA9E699B548F6CC2
Content-Type: text/plain; charset=us-ascii;
 name="2.4.24-pre2-cciss.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.24-pre2-cciss.patch"

--- linux-2.4-pre/drivers/block/cciss.c.orig	Tue Dec 23 16:12:40 2003
+++ linux-2.4-pre/drivers/block/cciss.c	Tue Dec 23 16:12:53 2003
@@ -2677,11 +2677,13 @@
 	}
 
 #ifdef CONFIG_X86
+{
 	/* Need to enable prefetch in the SCSI core for 6400 in x86 */
 	__u32 prefetch;
 	prefetch = readl(&(c->cfgtable->SCSI_Prefetch));
 	prefetch |= 0x100;
 	writel(prefetch, &(c->cfgtable->SCSI_Prefetch));
+}
 #endif
 
 #ifdef CCISS_DEBUG

--------------F0D56FAEEA9E699B548F6CC2--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265013AbSJaAMk>; Wed, 30 Oct 2002 19:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265014AbSJaAMj>; Wed, 30 Oct 2002 19:12:39 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57984 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265013AbSJaAMh>;
	Wed, 30 Oct 2002 19:12:37 -0500
Message-ID: <3DC075F2.6070107@us.ibm.com>
Date: Wed, 30 Oct 2002 16:14:42 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch] Remove sole CONFIG_MULIQUAD in kernel source
Content-Type: multipart/mixed;
 boundary="------------020104070307050603080204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020104070307050603080204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	There is one remaining instance of CONFIG_MULTIQUAD in the kernel source. 
  This hanger-on must go!  It means that (since CONFIG_MULTIQUAD is no 
longer defined) the NUMA-Q specific PCI code is no longer compiled in. 
This is bad...

[mcd@arrakis linux-2.5.44-vanilla]$ grep -r CONFIG_MULTIQUAD *
arch/i386/pci/Makefile:ifdef 
CONFIG_MULTIQUAD
arch/i386/pci/Makefile:endif 
	# CONFIG_MULTIQUAD

[mcd@arrakis patches]$ diffstat multiquad_fix/multiquad_pci_fix-2.5.44.patch
  Makefile |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

Please apply...

Cheers!

-Matt

--------------020104070307050603080204
Content-Type: text/plain;
 name="multiquad_pci_fix-2.5.44.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="multiquad_pci_fix-2.5.44.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-multiquad/arch/i386/pci/Makefile linux-2.5.39-multiquad+numa_rename/arch/i386/pci/Makefile
--- linux-2.5.39-multiquad/arch/i386/pci/Makefile	Fri Sep 27 14:50:18 2002
+++ linux-2.5.39-multiquad+numa_rename/arch/i386/pci/Makefile	Mon Sep 30 11:21:09 2002
@@ -3,7 +3,7 @@
 obj-$(CONFIG_PCI_BIOS)		+= pcbios.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
-ifdef	CONFIG_MULTIQUAD
+ifdef	CONFIG_X86_NUMAQ
 obj-y		+= numa.o
 else
 obj-y		+= fixup.o
@@ -14,7 +14,7 @@
 obj-y		+= legacy.o
 
 
-endif		# CONFIG_MULTIQUAD
+endif		# CONFIG_X86_NUMAQ
 obj-y		+= irq.o common.o
 
 include $(TOPDIR)/Rules.make

--------------020104070307050603080204--


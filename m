Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTENOU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTENOU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:20:56 -0400
Received: from mbi-00.mbi.ufl.edu ([159.178.51.20]:48525 "EHLO mbi.ufl.edu")
	by vger.kernel.org with ESMTP id S262312AbTENOUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:20:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: 2.5.69-mm5
Date: Wed, 14 May 2003 10:33:43 -0400
Message-ID: <CDD2FA891602624BB024E1662BC678ED843F91@mbi-00.mbi.ufl.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.69-mm5
Thread-Index: AcMaFQHK3LjdCIHFQb6PxqDJ/ybpAgAAXDSw
From: "Jon K. Akers" <jka@mbi.ufl.edu>
To: "Andrew Morton" <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like to at least build the new stuff that comes out with Andrew's
patches, and building the new gadget code that came out in -mm4 I got
this when building as a module:

make -f scripts/Makefile.build obj=drivers/serial
make -f scripts/Makefile.build obj=drivers/usb/gadget
  gcc -Wp,-MD,drivers/usb/gadget/.net2280.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include -DMODULE   -DKBUILD_BASENAME=net2280
-DKBUILD_MODNAME=net2280 -c -o drivers/usb/gadget/net2280.o
drivers/usb/gadget/net2280.c
drivers/usb/gadget/net2280.c:2623: pci_ids causes a section type
conflict
make[2]: *** [drivers/usb/gadget/net2280.o] Error 1
make[1]: *** [drivers/usb/gadget] Error 2
make: *** [drivers] Error 2

I was not able to test this particular part of the code with -mm4, as I
use a single processor system and could not get to the module building
process then.

I have also tested this by compiling it into the kernel, with the same
results:

  gcc -Wp,-MD,drivers/usb/gadget/.net2280.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=net2280
-DKBUILD_MODNAME=net2280 -c -o drivers/usb/gadget/net2280.o
drivers/usb/gadget/net2280.c
drivers/usb/gadget/net2280.c:2623: pci_ids causes a section type
conflict
make[2]: *** [drivers/usb/gadget/net2280.o] Error 1
make[1]: *** [drivers/usb/gadget] Error 2
make: *** [drivers] Error 2


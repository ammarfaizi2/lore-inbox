Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSGQXVr>; Wed, 17 Jul 2002 19:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSGQXVr>; Wed, 17 Jul 2002 19:21:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53931 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316833AbSGQXVq>;
	Wed, 17 Jul 2002 19:21:46 -0400
Message-ID: <3D35FC8F.6010002@us.ibm.com>
Date: Wed, 17 Jul 2002 16:23:59 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: ipslinux@us.ibm.com, linux-kernel@vger.kernel.org,
       Mike Anderson <andmike@us.ibm.com>
Subject: [PATCH] ServeRAID driver doesn't compile
Content-Type: multipart/mixed;
 boundary="------------010405030806090902050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010405030806090902050809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

In 2.5.26, the ServeRAID driver still doesn't compile correctly, you 
get these from the vmlinux link operation:

drivers/built-in.o(.data+0xc4f4): undefined reference to `local 
symbols in discarded section .text.exit'
drivers/built-in.o(.data+0xc574): undefined reference to `local 
symbols in discarded section .text.exit'
drivers/built-in.o(.data+0xc5f4): undefined reference to `local 
symbols in discarded section .text.exit'

This patch makes them go away and appears to be the correct fix.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010405030806090902050809
Content-Type: text/plain;
 name="ips-compile-fix-2.5.26-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ips-compile-fix-2.5.26-1.patch"

diff -ur linux-2.5.26-clean/drivers/scsi/ips.c linux-2.5.26/drivers/scsi/ips.c
--- linux-2.5.26-clean/drivers/scsi/ips.c	Tue Jul 16 16:49:22 2002
+++ linux-2.5.26/drivers/scsi/ips.c	Wed Jul 17 16:21:49 2002
@@ -326,21 +326,21 @@
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    }; 
            
    struct pci_driver ips_pci_driver_5i = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_5i,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 
    struct pci_driver ips_pci_driver_i960 = {
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table_i960,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 
 #endif

--------------010405030806090902050809--


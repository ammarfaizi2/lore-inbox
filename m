Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbSJKCpY>; Thu, 10 Oct 2002 22:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbSJKCpY>; Thu, 10 Oct 2002 22:45:24 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:6895 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S262006AbSJKCpX>; Thu, 10 Oct 2002 22:45:23 -0400
Message-ID: <3DA63C98.3C494DFF@eyal.emu.id.au>
Date: Fri, 11 Oct 2002 12:51:04 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre10aa1- build problems
References: <20021010230945.GB1251@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------83C31BC5FA0198849440E38C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------83C31BC5FA0198849440E38C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

1)
gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre-aa/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre-aa/include/linux/modversions.h -I../
-DISP2200 -c qla2200.c -o qla2200.o
qla2200.c:24: warning: `ISP2200' redefined
*Initialization*:1: warning: this is the location of the previous
definition
In file included from qla2200.c:43:
qla2x00.c:14897: unknown field `varyio' specified in initializer
qla2x00.c:3402: warning: `qla2x00_biosparam' defined but not used
qla2x00.c:14948: warning: `qla2x00_print_scsi_cmd' defined but not used
qla2x00.c:15149: warning: `qla2x00_dump_requests' defined but not used
qla2x00.c:14355: warning: `qla2x00_add_link_b' defined but not used
qla2x00.c:14380: warning: `qla2x00_add_link_t' defined but not used
qla2x00.c:14405: warning: `qla2x00_remove_link' defined but not used
qla2x00.c:15002: warning: `qla2x00_print_q_info' defined but not used
qla2x00.c:535: warning: `debug_buff' defined but not used
qla_fo.cfg:24: warning: `MaxPathsPerDevice' defined but not used
qla_fo.cfg:25: warning: `MaxRetriesPerPath' defined but not used
qla_fo.cfg:26: warning: `MaxRetriesPerIo' defined but not used
make[3]: *** [qla2200.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre-aa/drivers/scsi/qla2xxx'

A misspelt 'vary_io'.

But also note that ISP2200 is defined on the command line as well
as in qla2200.c:24. While this is only a warning, it should
probably be cleaned.

2)
drivers/usb/brlvger.c does not compile, since -pre5, on older gcc.

3)
net/bluetooth/bnep/core.c line 461 refers to 'current->nice' which
does not exist. Should be some priority field?

4)
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre10-aa1/kernel/fs/xfs/xfs.o
depmod:         do_generic_file_write

with:
	CONFIG_XFS_FS=m
	# CONFIG_XFS_RT is not set
	# CONFIG_XFS_QUOTA is not set
	# CONFIG_XFS_DMAPI is not set
	# CONFIG_XFS_DEBUG is not set
	# CONFIG_PAGEBUF_DEBUG is not set

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------83C31BC5FA0198849440E38C
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre10-aa1-qla2x00.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre10-aa1-qla2x00.patch"

--- linux/drivers/scsi/qla2xxx/qla2x00.h.orig	Fri Oct 11 11:59:01 2002
+++ linux/drivers/scsi/qla2xxx/qla2x00.h	Fri Oct 11 11:59:13 2002
@@ -2731,7 +2731,7 @@
 TEMPLATE_USE_NEW_EH_CODE 	 	 	 	 	\
 TEMPLATE_MAX_SECTORS						\
 	highmem_io: 1,						\
-	varyio: 1,						\
+	vary_io: 1,						\
 	emulated: 0					        \
 }
 

--------------83C31BC5FA0198849440E38C
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre10-aa1-brlvger.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre10-aa1-brlvger.patch"

--- linux/drivers/usb/brlvger.c.orig	Thu Aug 29 10:30:50 2002
+++ linux/drivers/usb/brlvger.c	Thu Aug 29 10:31:02 2002
@@ -209,7 +209,7 @@
     ({ printk(KERN_ERR "Voyager: " args); \
        printk("\n"); })
 #define dbgprint(fmt, args...) \
-    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__, ##args); \
+    ({ printk(KERN_DEBUG "Voyager: %s: " fmt, __FUNCTION__ , ##args); \
        printk("\n"); })
 #define dbg(args...) \
     ({ if(debug >= 1) dbgprint(args); })

--------------83C31BC5FA0198849440E38C--


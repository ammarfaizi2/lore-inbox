Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbSKWSZk>; Sat, 23 Nov 2002 13:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSKWSZk>; Sat, 23 Nov 2002 13:25:40 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:64815
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267036AbSKWSZj>; Sat, 23 Nov 2002 13:25:39 -0500
Date: Sat, 23 Nov 2002 13:36:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] SCSI hosts.c missing device_register
Message-ID: <Pine.LNX.4.50.0211231336020.1462-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this patch look correct? Please CC as i am not subscribed.

SCSI subsystem driver Revision: 1.00
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0256725
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c0256725>]    Not tainted
EFLAGS: 00010246
EIP is at device_del+0x35/0xa0
eax: c0662cac   ebx: c0514230   ecx: 00000000   edx: 00000000
esi: c0662ca4   edi: 00000000   ebp: 00000000   esp: c15b9f1c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=c15b8000 task=cff86040)
Stack: c0662ca4 c0662c00 c0662c00 c025679b c0662ca4 c15b9f40 c02cfbbf c0662ca4
       c0662c00 00000000 00000000 00000001 dead4ead c15b9f50 c15b9f50 c0144ed1
       cffeb080 00000286 00000000 00000000 00000330 c05edbc6 c0662c00 cfd58424
Call Trace:
 [<c025679b>] device_unregister+0xb/0x16
 [<c02cfbbf>] scsi_unregister+0xbf/0x140
 [<c0144ed1>] kfree+0x61/0xe0
 [<c02cffd8>] scsi_register_host+0x28/0xb0
 [<c01050b0>] init+0x80/0x1a0
 [<c0105030>] init+0x0/0x1a0
 [<c0105030>] init+0x0/0x1a0
 [<c0105030>] init+0x0/0x1a0
 [<c0108e05>] kernel_thread_helper+0x5/0x10

Code: 89 4a 04 89 40 04 89 11 89 d9 8b 56 04 89 46 08 8b 06 89 02

Index: linux-2.5.49/drivers/scsi/hosts.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.49/drivers/scsi/hosts.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 hosts.c
--- linux-2.5.49/drivers/scsi/hosts.c	23 Nov 2002 02:56:36 -0000	1.1.1.1
+++ linux-2.5.49/drivers/scsi/hosts.c	23 Nov 2002 08:50:22 -0000
@@ -467,6 +467,7 @@
 		DEVICE_NAME_SIZE-1);
 	sprintf(shost->host_driverfs_dev.bus_id, "scsi%d",
 		shost->host_no);
+	device_register(&shost->host_driverfs_dev);

 	shost->eh_notify = &sem;
 	kernel_thread((int (*)(void *)) scsi_error_handler, (void *) shost, 0);
-- 
function.linuxpower.ca

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSHaK2M>; Sat, 31 Aug 2002 06:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSHaK2M>; Sat, 31 Aug 2002 06:28:12 -0400
Received: from gtisr.ist.utl.pt ([193.136.138.253]:33426 "EHLO pixie.local")
	by vger.kernel.org with ESMTP id <S317030AbSHaK2L>;
	Sat, 31 Aug 2002 06:28:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Problems compiling 2.5.32
Content-Type: text/plain; charset=US-ASCII
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Date: 31 Aug 2002 11:32:35 +0100
Message-ID: <lxofbj8gjg.fsf@pixie.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        I don't know whether these issues are new to you all, but
anyway, here they go:


Version: 2.5.32 (patched from 2.5.31)

1. Module 8250.o does not compile due to syntax errors, but a little
   kludge made it work:

--- linux-2.5.31-orig/include/linux/serialP.h   Sat Aug 31 10:56:03 2002
+++ linux-2.5.31/include/linux/serialP.h        Fri Aug 30 18:12:07 2002
@@ -24,7 +24,7 @@
 #include <linux/tqueue.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
-#if (LINUX_VERSION_CODE < 0x020300)
+#if 1 /*(LINUX_VERSION_CODE < 0x020300)*/
 /* Unfortunate, but Linux 2.2 needs async_icount defined here and
  * it got moved in 2.3 */
 #include <linux/serial.h>


2. loop.o cannot be compiled as a module, because it results in:

	  loop.o: unresolved symbol balance_dirty_pages

   when trying to insmod it.


3. Strange errors (no such errors with 2.4.x, same config)

PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 91080D5, ATA DISK drive
hdb: MATSHITA CR-587, ATAPI CD/DVD-ROM drive
hdc: CR-2801TE, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03520a4, I/O limit 4095Mb (mask 0xffffffff)
hda: host protected area => 1
hda: 21095424 sectors (10801 MB) w/512KiB Cache, CHS=1313/255/63, (U)DMA
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdb:ide-scsi: unsup command: dev 03:40: REQ_CMD REQ_STARTED sector 0, nr/cnr 8/1

end_request: I/O error, dev 03:40, sector 0
Buffer I/O error on device ide0(3,64), logical block 0
ide-scsi: unsup command: dev 03:40: REQ_CMD REQ_STARTED sector 1, nr/cnr 7/1

end_request: I/O error, dev 03:40, sector 1
Buffer I/O error on device ide0(3,64), logical block 1
ide-scsi: unsup command: dev 03:40: REQ_CMD REQ_STARTED sector 2, nr/cnr 6/1

end_request: I/O error, dev 03:40, sector 2
Buffer I/O error on device ide0(3,64), logical block 2
ide-scsi: unsup command: dev 03:40: REQ_CMD REQ_STARTED sector 3, nr/cnr 5/1

[etc, etc, etc]



        *NOTE* When replying, please CC to me (I'm not subscribed to
this list). Thank you.

        Cheers,

        Rodrigo Ventura

-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585

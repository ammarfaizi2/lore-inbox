Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWILVx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWILVx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWILVx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:53:59 -0400
Received: from orfeus.profiwh.com ([85.93.165.27]:21252 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751462AbWILVx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:53:58 -0400
Message-ID: <4506DAD7.8030307.reply@wsc.cz>
In-reply-to: <4506DAD7.8030307@carlislefsp.com>
From: Jiri Slaby <jirislaby@gmail.com>
To: Steve Roemen <stever@carlislefsp.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: isicom module oops 2.6.17.13
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Date: Tue, 12 Sep 2006 17:53:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Roemen wrote:
>kernel version 2.6.17.13
>running debian version 3.1
>
>lspci -vvv info for the device:
>0000:00:10.0 Communication controller: PLX Technology, Inc.: Unknown 
>device 2028 (rev 01)
>        Subsystem: Unknown device 2028:1000
>        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
>ParErr+ Stepping- SERR+ FastB2B-
>        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
><TAbort- <MAbort- >SERR- <PERR-
>        Interrupt: pin A routed to IRQ 5
>        Region 0: Memory at c6efee80 (32-bit, non-prefetchable) [size=128]
>        Region 1: I/O ports at 2000 [size=128]
>        Region 3: I/O ports at 2080 [size=16]
>
>When loading the module isicom for an ISI4608 pci card, with the 
>firmware in /usr/lib/hotplug/firmware/ It dumps this crash log:
>
>isicom 0000:00:10.0: ISI PCI Card(Device ID 0x2028)
>isicom 0000:00:10.0: -Done
>BUG: unable to handle kernel paging request at virtual address e09cf000
> printing eip:
>e0a42e0b
>*pde = 1ff9a067
>*pte = 00000000
>Oops: 0000 [#1]
>Modules linked in: isicom firmware_class shpchp ide_scsi reiserfs ext3 
>jbd epca st ohci_hcd ehci_hcd pci_hotplug mousedev evdev tsdev psmouse 
>rtc raid5 xor raid0 tlan sd_mod ide_cd cdrom ide_disk ide_generic 
>pdc202xx_new aec62xx alim15x3 amd74xx atiixp cmd64x cs5520 cs5530 
>cy82c693 generic hpt34x ns87415 opti621 pdc202xx_old rz1000 sc1200 
>serverworks siimage sis5513 slc90e66 triflex trm290 via82cxxx floppy 
>usb_storage piix ide_core fbcon tileblit font bitblit softcursor vga16fb 
>cfbcopyarea vgastate cfbimgblt cfbfillrect usbserial usbhid usbkbd 
>uhci_hcd usbcore sym53c8xx scsi_transport_spi scsi_mod raid1 md_mod unix
>CPU:    0
>EIP:    0060:[<e0a42e0b>]    Not tainted VLI
>EFLAGS: 00010286   (2.6.17.13 #2)
>EIP is at isicom_probe+0x4a4/0x83b [isicom]
>eax: 00000000   ebx: 00002080   ecx: 00004c72   edx: 00002080
>esi: e09cf000   edi: 0000208e   ebp: 00005c6c   esp: de4e9df8
>ds: 007b   es: 007b   ss: 0068
>Process modprobe (pid: 2044, threadinfo=de4e8000 task=df4385b0)
>Stack: de4e9e54 de4e9e38 ded99f70 00002084 dffcc4ec 00000000 e0a490c0 
>dffcc448
>       004e9e38 e0a490c0 00000000 0000208c 00002084 00000000 dffcc4b0 
>dffcc448
>       e09cd008 deb8ed20 dffcc400 dffcc400 e0a463c0 e0a463ec c019e28e 
>dffcc400
>Call Trace:
> <c019e28e> pci_device_probe+0x38/0x59  <c01e068c> 
>driver_probe_device+0x45/0x8f
> <c01e072d> __driver_attach+0x0/0x5c  <c01e0764> __driver_attach+0x37/0x5c
> <c01dfd7f> bus_for_each_dev+0x46/0x6c  <c01e057c> driver_attach+0x14/0x18
> <c01e072d> __driver_attach+0x0/0x5c  <c01e0038> bus_add_driver+0x5b/0xe6
> <c019df4a> __pci_register_driver+0x3b/0x5d  <e0a424b8> 
>isicom_setup+0x1df/0x24b [isicom]
> <c0126c44> sys_init_module+0x11d7/0x12a6  <c0102923> syscall_call+0x7/0xb
>Code: 85 d2 74 02 8b 3a 50 51 53 56 31 f6 ff 74 24 20 57 68 63 42 a4 e0 
>e8 69 18 6d df e9 ec 01 00 00 8b 74 24 40 89 e9 89 da 83 c6 04 <f3> 66 
>6f 31 c0 8b 54 24 2c 66 ef 68 de 46 03 00 31 f6 e8 98 47
>EIP: [<e0a42e0b>] isicom_probe+0x4a4/0x83b [isicom] SS:ESP 0068:de4e9df8
>
>
>
>here's the list of firmware in /usr/lib/hotplug/firmware/
>-r-xr-xr-x  1 root root  7325 2006-09-11 14:23 isi4608.bin
>-r-xr-xr-x  1 root root  7497 2006-09-11 14:23 isi4616.bin
>-r-xr-xr-x  1 root root  6213 2006-09-11 14:23 isi608.bin
>-r-xr-xr-x  1 root root  6513 2006-09-11 14:23 isi608em.bin
>-r-xr-xr-x  1 root root  6533 2006-09-11 14:23 isi616em.bin

Hi,

could you, please test this patch and send the results appeared in dmesg?

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 6cca4b2..510c3cc 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1758,7 +1758,8 @@ static int __devinit load_firmware(struc
 
 	for (frame = (struct stframe *)fw->data;
 			frame < (struct stframe *)(fw->data + fw->size);
-			frame++) {
+			frame = (struct stframe *)((u8 *)frame + 4 +
+				frame->count)) {
 		if (WaitTillCardIsFree(base))
 			goto errrelfw;
 
@@ -1768,6 +1769,8 @@ static int __devinit load_firmware(struc
 
 		word_count = frame->count / 2 + frame->count % 2;
 		outw(word_count, base);
+		dev_info(&pdev->dev, "WC: %u, FC: %u, FD: %p, FP: %p\n",
+				word_count, frame->count, fw->data, frame);
 		InterruptTheCard(base);
 
 		udelay(100); /* 0x2f */

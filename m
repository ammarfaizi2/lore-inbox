Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbULNP6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbULNP6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbULNP6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:58:24 -0500
Received: from ottawa-hs-64-26-171-227.s-ip.magma.ca ([64.26.171.227]:23459
	"HELO edgewater.ca") by vger.kernel.org with SMTP id S261532AbULNP6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:58:18 -0500
Message-ID: <002d01c4e1f5$a3491790$8500a8c0@WS055>
From: "Yihan Li" <Yihan.Li@Edgewater.CA>
To: <linux-kernel@vger.kernel.org>
Subject: patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3
Date: Tue, 14 Dec 2004 10:57:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need help again!
I am trying to patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3.
The following steps are what I was following:

I download a varnilla version of linux-2.6.9 from www.kernel.org,
Unpack the kernel source:
# cd /usr/src
# tar xvjf linux-2.6.9.tar.bz2
# ln -s linux-2.6.9 linux

Unpack or copy RTAI to  /usr/src/fusion-0.6.4.tar.bz2
# ln -s fusion-0.6.4  rtai

Patch the kernel:
I download patch 2.6.9-ac15 and patch to kernel 2.6.9
Then I patched RTAI to kernel:
# cd /usr/src/linux
# patch -p1 < ../rtai/arch/i386/patches/adeos-linux-2.6.9-i386-r8.patch

Copy the existing (Fedora) kernel config file to /usr/src/linux
# cp /boot/config-2.6.xxxx /usr/src/linux/.configConfigure the kernel:
# make menuconfig
# make

After 8 mins, I get error messages as following:
drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
call to 'qla2x00_callback': function not considered for inlining
drivers/scsi/qla2xxx/qla_os.c:269: sorry, unimplemented: called from here
make[3]: *** [drivers/scsi/qla2xxx/qla_os.o] Error 1
make[2]: *** [drivers/scsi/qla2xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

I looked at the source code of qla_os.c, which belong to Qlogic ISP2x00 
device driver.
So I redo my configuration. I didn't choose Qlogic ISP2x00 and Qlogic PCMCIA 
device driver.
After that, the make finished without error.
Then I install the kernel:
# make modules_install install

The following warning is what I got:

  INSTALL sound/usb/snd-usb-lib.ko
  INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.9-ac15; fi
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
Kernel: arch/i386/boot/bzImage is ready
sh /usr/src/linux-2.6.9/arch/i386/boot/install.sh 2.6.9-ac15 
arch/i386/boot/bzImage System.map "/boot"
WARNING: No module sata_via found for kernel 2.6.9-ac15, continuing anyway

Module sata_via is mainly for what? What can I do now? I need a hand ...

I wish to be personally CC'ed the answers/comments in response to my
posting.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267793AbTBKNDr>; Tue, 11 Feb 2003 08:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTBKNDq>; Tue, 11 Feb 2003 08:03:46 -0500
Received: from [198.73.180.252] ([198.73.180.252]:40648 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267793AbTBKNDo>;
	Tue, 11 Feb 2003 08:03:44 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] link error in usbserial with gcc3.2
Date: Tue, 11 Feb 2003 08:13:18 -0500
User-Agent: KMail/1.5.9
References: <3DF453C8.18B24E66@digeo.com> <200212092059.06287.tomlins@cam.org> <3DF54BD7.726993D@digeo.com>
In-Reply-To: <3DF54BD7.726993D@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Cc: greg@kroah.com
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302110813.18360.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been around for a while...  Its becoming a bit
if a pain since debian unstable flipped to gcc3.2 as its 
default compiler.  This works with gcc2.95.  Is gcc3.2 
detecting an error 2.95 misses?

  ld -m elf_i386  -r -o drivers/usb/input/hid.o drivers/usb/input/hid-core.o drivers/usb/input/hid-input.o
  ld -m elf_i386  -r -o drivers/usb/input/hid.ko drivers/usb/input/hid.o init/vermagic.o
make -f scripts/Makefile.build obj=drivers/usb/serial
   rm -f drivers/usb/serial/built-in.o; ar rcs drivers/usb/serial/built-in.o
  gcc -Wp,-MD,drivers/usb/serial/.usb-serial.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=usb_serial -DKBUILD_MODNAME=usbserial -c -o drivers/usb/serial/usb-serial.o drivers/usb/serial/usb-serial.c
{standard input}: Assembler messages:
{standard input}:2603: Error: value of -129 too large for field of 1 bytes at 5959
make[3]: *** [drivers/usb/serial/usb-serial.o] Error 1
make[2]: *** [drivers/usb/serial] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

I have a pl2303 based device.

Ed Tomlinson

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133085AbRDLJGH>; Thu, 12 Apr 2001 05:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133078AbRDLJF6>; Thu, 12 Apr 2001 05:05:58 -0400
Received: from mx5.port.ru ([194.67.23.40]:47879 "EHLO smtp5.port.ru")
	by vger.kernel.org with ESMTP id <S133079AbRDLJFp>;
	Thu, 12 Apr 2001 05:05:45 -0400
From: info <css@sniip.ru>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Repeating 2.4.3 compile error with ipx makefile patch
Date: Thu, 12 Apr 2001 12:49:20 +0400
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
In-Reply-To: <4AB83BD5FB4@vcnet.vc.cvut.cz> <20010411180235.A29195@vana.vc.cvut.cz>
In-Reply-To: <20010411180235.A29195@vana.vc.cvut.cz>
MIME-Version: 1.0
Message-Id: <01041212543100.09115@sh.lc>
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Срд, 11 Апр 2001 в сообщении на тему "Re: 2.4.3 compile error No 3" Вы написали:
> diff -urdN linux/net/ipx/Makefile linux/net/ipx/Makefile
................

Petr, first of all I save text of patch you sent me to file
"ipx-makefile.patch" in /usr/src and try to patch.
Result:
-------------------------------------------------------------------
[root@sh src]# patch -p0 < ipx-makefile.patch
patching file linux/net/ipx/Makefile
patch: **** malformed patch at line 6: export-objs = af_ipx.o af_spx.o
        
[root@sh src]#   
--------------------------------------------

So I  try to patched linux/net/ipx/Makefile manually with you text.
Resulting Makefile:

_______________________________________________________
#
# Makefile for the Linux IPX layer.
#
# Note! Dependencies are done automagically by 'make dep', which also
# removes any old dependencies. DON'T put your own dependencies here
# unless it's something special (ie not a .c file).
#
# Note 2! The CFLAGS definition is now in the main makefile...

# We only get in/to here if CONFIG_IPX = 'y' or 'm'

O_TARGET := ipx.o

export-objs = af_ipx.o af_spx.o

obj-y	:= af_ipx.o sysctl_net_ipx.o

ifeq ($(CONFIG_IPX),m)
  obj-m += $(O_TARGET)
endif

obj-$(CONFIG_SPX) += af_spx.o

include $(TOPDIR)/Rules.make

tar:
		tar -cvf /dev/f1 .
________________________________
Then try to compile
Result - the same error.

_______________________________________________________________________
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o drivers/ide/idedriver.o
drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.data+0x2c84): undefined reference to `sysctl_ipx_pprop_broadcasting' 
_________________________________________________

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSKRWTG>; Mon, 18 Nov 2002 17:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSKRWRd>; Mon, 18 Nov 2002 17:17:33 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:18140 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265102AbSKRWP6> convert rfc822-to-8bit; Mon, 18 Nov 2002 17:15:58 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: e100 2.1.6 driver from Intel including into the kernel tree 2.2.22
Date: Mon, 18 Nov 2002 23:22:29 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182320.15546.m.c.p@gmx.net>
Organization: WOLK - Working Overloaded Linux Kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

doing this for the next 5 minutes will make me think I am silly because I 
cannot compile (neither static or module) the $subject.

Can anyone assist me in compiling this successfully with a 2.2.22 kernel tree?
Do not ask me why I don't use 2.4 for that (I have to use 2.2 for that reason) 
and I also have to use a static build (otherwise I can just use 'make' in the 
sources from Intel.) The module build below was just a test.


I've created a Makefile in drivers/net/e100/ looking like this:
---------------------------------------------------------------

# File: drivers/net/e100/Makefile
#
# Makefile for the Intel e100 device driver.
#

ifeq ($(CONFIG_INTEL_E100),y)
    O_TARGET := e100.o
    O_OBJS = e100_main.o e100_eeprom.o e100_config.o e100_phy.o e100_kcompat.o 
e100_test.o
else
  ifeq ($(CONFIG_INTEL_E100),m)
    MOD_LIST_NAME := INTEL_E100_MODULES
    M_OBJS := e100.o
    O_TARGET := e100.o
    O_OBJS = e100_main.o e100_eeprom.o e100_config.o e100_phy.o e100_kcompat.o 
e100_test.o
  endif
endif

include $(TOPDIR)/Rules.make

clean:  
        rm -f core *.o *.a *.s


the part from drivers/net/Makefile is this:
-------------------------------------------

ALL_SUB_DIRS := $(SUB_DIRS) ....$bla... e100

ifeq ($(CONFIG_INTEL_E100),y)
  SUB_DIRS += e100
  MOD_IN_SUB_DIRS += e100
  L_OBJS += e100/e100.o  
else
  ifeq ($(CONFIG_INTEL_E100),m)
    MOD_IN_SUB_DIRS += e100
  endif
endif


Static compile succeed but the linker does not link it to the kernel image.


Module compile looks like this:
-------------------------------

make[3]: Entering directory `/usr/src/linux-2.2.22/drivers/net/e100'
make[3]: Circular ans_driver.h <- e100.h dependency dropped.
rm -f e100.o
ld -m elf_i386  -r -o e100.o e100_main.o e100_eeprom.o e100_config.o 
e100_phy.o e100_kcompat.o e100_test.o
e100_eeprom.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
e100_main.o(.modinfo+0x0): first defined here
e100_config.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
e100_main.o(.modinfo+0x0): first defined here
e100_phy.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
e100_main.o(.modinfo+0x0): first defined here
e100_test.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
e100_main.o(.modinfo+0x0): first defined here
make[3]: *** [e100.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.2.22/drivers/net/e100'
make[2]: *** [_modinsubdir_e100] Error 2
make[2]: Leaving directory `/usr/src/linux-2.2.22/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.2.22/drivers'
make: *** [_mod_drivers] Error 2


I really appreciate any kind of help!!

Thnx alot!

ciao, Marc



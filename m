Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267342AbTBUK20>; Fri, 21 Feb 2003 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbTBUK2Z>; Fri, 21 Feb 2003 05:28:25 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.252]:37064 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267342AbTBUK2Y>; Fri, 21 Feb 2003 05:28:24 -0500
From: Thomas Stuefe <thomas.stuefe@online.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.62 hisax compile broke. isac_setup double defined (hisax.o & hisax_isac.o)
Date: Fri, 21 Feb 2003 11:38:19 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302211138.19592.thomas.stuefe@online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

tried to compile 2.5.62. 

when linking hisax/built-in.o, the linker complains about the function 
isac_setup being defined twice, once in hisax.o and once in hisax_isac.o.


make -f scripts/Makefile.build obj=drivers/isdn/hisax
   ld -m elf_i386  -r -o drivers/isdn/hisax/built-in.o 
drivers/isdn/hisax/hisax.o drivers/isdn/hisax/hisax_isac.o 
drivers/isdn/hisax/hisax_fcpcipnp.o drivers/isdn/hisax/hisax_hfcpci.o
drivers/isdn/hisax/hisax_isac.o: In function `isac_setup':
drivers/isdn/hisax/hisax_isac.o(.text+0x77e): multiple definition of 
`isac_setup'
drivers/isdn/hisax/hisax.o(.text+0x1a732): first defined here
ld: Warning: size of symbol `isac_setup' changed from 39 to 587 in 
drivers/isdn/hisax/hisax_isac.o


These are the relevant .config ISDN settings:

#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# CAPI subsystem
#
# CONFIG_ISDN_CAPI is not set

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=y

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
CONFIG_DE_AOC=y
CONFIG_HISAX_1TR6=y
CONFIG_HISAX_MAX_CARDS=1

#
# HiSax supported cards
#
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_FRITZ_PCIPNP=y


bye thomas

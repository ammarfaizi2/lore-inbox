Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVLCTwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVLCTwz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVLCTwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:52:55 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:54544 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750862AbVLCTwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:52:55 -0500
Date: Sat, 3 Dec 2005 20:52:54 +0100
From: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Some kconfig issues
Message-ID: <20051203195254.GG72294@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some issues regarding undefined config options in linux-2.6.15-rc4.
Most of these are obviously not yet defined config options, but as some are mispelled configs
I thought it would be better to send the whole list.

Regards,

        JL

---------------------------------------
FVR 
from kernel/power/Kconfig:
config SOFTWARE_SUSPEND
        bool "Software Suspend"
        depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)

440GR
from drivers/net/Kconfig:
config IBM_EMAC_PHY_RX_CLK_FIX
        bool "PHY Rx clock workaround"
        depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
-> maybe this is 440GP ?

IRTTY_OLD
from drivers/net/irda/Kconfig:
config DONGLE_OLD
        bool "Old Serial dongle support"
        depends on (IRTTY_OLD || IRPORT_SIR) && BROKEN_ON_SMP

NP405L
from drivers/net/Kconfig:
config IBM_EMAC_ZMII
        bool
        depends on IBM_EMAC && (NP405H || NP405L || 44x)
        default y

PALT_USRV 
from drivers/serial/Kconfig:
config SERIAL_M32R_PLDSIO
        bool "M32R SIO I/F on a PLD"
        depends on SERIAL_M32R_SIO=y && (PLAT_OPSPUT || PALT_USRV || PLAT_M32700UT)
        default n
-> this is obviously PLAT_USRV

SPARC
from drivers/isdn/hisax/Kconfig
config HISAX_TELESPCI
        bool "Teles PCI"
        depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K))
-> is it SPARC32 || SPARC64 ?

NINO
from drivers/video/Kconfig
config FB_TX3912
        bool "TMPTX3912/PR31700 frame buffer support"
        depends on (FB = y) && NINO

VISWS
from drivers/video/Kconfig
config BUS_I2C
        bool
        depends on (FB = y) && VISWS
        default y
-> probably X86_VISWS

S390
from arch/h8300/Kconfig
config HW_CONSOLE
        bool
        depends on VT && !S390 && !UM
-> obviously useless in this file. UM too seems useless (or should be UML) 
from drivers/char/Kconfig
config HW_CONSOLE
        bool
        depends on VT && !S390 && !UML
from net/bluetooth/hidp/Kconfig
config BT_HIDP
        tristate "HIDP protocol support"
        depends on BT && BT_L2CAP && (BROKEN || !S390)
-> probably ARCH_S390



And then, there are some from arch Kconfig files :

ARCH_NEXUSPCI in arch/arm/mm/Kconfig
ARCH_TBOX in arch/arm/mm/Kconfig
CPU_32v7 in arch/arm/mm/Kconfig
SA1100_PT_SYSTEM3 in arch/arm/Kconfig

H8002 in arch/h8300/Kconfig.cpu

GG2 in arch/m68k/Kconfig
PILOT5 in arch/m68knommu/Kconfig

ASH in arch/ppc/platforms/4xx/Kconfig and arch/powerpc/platforms/4xx/Kconfig
CONFIG_PPC32 (should be PPC32) in arch/powerpc/Kconfig
CONFIG_SMP (should be SMP) in arch/powerpc/Kconfig
VETH (is it ISERIES_VETH ?) in arch/powerpc/platforms/iseries/Kconfig

MPC1211 (is it SH_MPC1211 ?) in arch/sh/Kconfig

SPARC64_PAGE_SIZE_512K (should be SPARC64_PAGE_SIZE_512KB) in arch/sparc64/Kconfig


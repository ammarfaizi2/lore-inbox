Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268051AbTCFNHc>; Thu, 6 Mar 2003 08:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268057AbTCFNHc>; Thu, 6 Mar 2003 08:07:32 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:19402 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S268051AbTCFNH2>; Thu, 6 Mar 2003 08:07:28 -0500
Date: Fri, 7 Mar 2003 00:16:13 +1100
From: CaT <cat@zip.com.au>
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: 2.5.x - acpi doesn't like my power status
Message-ID: <20030306131613.GA464@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI works on my laptop except for one major thing. The AC and battery
status never gets reported. On bootup the kernel spits out the
following:

ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6a90
ACPI: RSDT (v001 PTLTD    RSDT   01540.00001) @ 0x0fff9b81
ACPI: FADT (v001 GATEWA SOLO5300 01540.00001) @ 0x0ffffb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00001) @ 0x0ffffbd9
ACPI: DSDT (v001 GATEWA SOLO5300 01540.00001) @ 0x00000000
ACPI: BIOS passes blacklist
...
ACPI: Subsystem revision 20030228
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control
Methods:...................................................................................................................
Table [DSDT] - 578 Objects with 50 Devices 115 Methods 29 Regions
ACPI Namespace successfully loaded at root c062a5bc
evxfevnt-0092 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0416 [06] ev_create_gpe_block   : GPE Block: 2 registers at 000000000000800C
   evgpe-0421 [06] ev_create_gpe_block   : GPE Block defined as GPE0 to GPE15
Executing all Device _STA and_INI methods:....[ACPI Debug] String:
ISA_INI
[ACPI Debug] String: LPT Decode Enabled At Boot
[ACPI Debug] Integer: 0000000000000378
[ACPI Debug] String: COM1 Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F8
[ACPI Debug] String: FDC Decode Enabled At Boot
[ACPI Debug] Integer: 00000000000003F0
[ACPI Debug] String: General-Purpose Decode #12 Enabled At Boot
[ACPI Debug] Integer: 000000000000FE00
[ACPI Debug] String: General-Purpose Decode #13 Enabled At Boot
[ACPI Debug] Integer: 0000000000000398
...................................[ACPI Debug] String: MOON_2 Status
......
45 Devices found containing: 45 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................................................
Initialized 22/29 Regions 4/4 Fields 31/31 Buffers 30/34 Packages (578 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[ACPI Debug] Buffer: Length 06
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *11)
ACPI: Embedded Controller [EC0] (gpe 9)
[ACPI Debug] String: MOON_2 Status
[ACPI Debug] String: MOON_2 Status
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.AC0_._STA] (Node cff7ee
54), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETE
R
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT0._STA] (Node cff7d2
8c), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETE
R
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node cff7d7
6c), AE_BAD_PARAMETER

And on unplugging and plugging in the power I get the following:

evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [22] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.ISA_.EC0_._Q03] (Node c12ca154), AE_BAD_PARAMETER
evregion-0341: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0421 [25] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.ISA_.EC0_._Q03] (Node c12ca154), AE_BAD_PARAMETER

Would it be possible to get power status support in? :)

Oh yeah. Relevant .config options:

# ACPI Support
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_ACPI_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set

Thanks. (not on the acpi-devel list btw... 1000 msgs/day is enough for
me :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)


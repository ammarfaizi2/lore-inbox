Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbUDRA7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbUDRA7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:59:18 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:54703 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S263628AbUDRA7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:59:06 -0400
Date: Sun, 18 Apr 2004 03:00:00 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.6/2.4, ACPI, Compaq Armada 110, freeze while booting
Message-ID: <20040418005959.GA15475@finwe.eu.org>
Mail-Followup-To: acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(I'm not subscribed to acpi-devel@ so CC me)

I've got problem with making Linux with ACPI enabled 
work with Compaq Armada 110. 

o 2.6.6-rc1 log (written down):
-------------------------------
ACPI: Subsystem revision 20040326
 tbxface-0117 [03] acpi_load_tables	: ACPI Tables successfully acquired
 Parsing all Control Methods:.................................................... ...
 Table [DSDT](id F004) - 398 Objects with 38 Devices 122 Methods 13 Regions
 ACPI Namespace successfully loaded at root c03851bc
 ACPI: IRQ10 SCI: Edge set to Level Trigger.
 evxfevnt-0093 [04] acpi_enable		: Transition to ACPI mode successful
 evgpeblk-0867 [06] ev_create_gpe_block	: GPE 00 to 15 [_GPE] 2 regs at 0000000000008020 on int 10
 evgpeblk-0925 [06] ev_create_gpe_block	: Found 0 Wake, Enabled 5 Runtime GPEs in this block
 Completing Region/Field/Buffer/Package initialization:................................ ...
 Initialized 13/13 Regions 1/1 Fields 22/22 Buffers 19/19 Packages (407 nodes)
 Executing all Device _STA and_INI methods: ..........[ACPI Debug] String: Length 0x30, "--------- VIA SOFTWARE SMI PMIO 2Fh ------------"
 
And then OS freezes. pci=noacpi or/and noacpi are not enough and only 
acpi=off 'solves' problem.

o tested versions
-----------------
I tested 2.6.6-rc1, 2.6.5-mm6, 2.6.4, 2.6.1 and symptoms are similar 
(when debug is disabled last visible line is 'ACPI: IRQ10 SCI: Edge set 
to Level Trigger') With 2.4.24 and 2.4.25 and ACPI enabled I got blank 
screen instead of text, but I guess it's the same problem (without ACPI
2.4.2[45] boot fine).

Custom DSDT does not help. I patched osl.c and according to logs new table
(found here: http://acpi.sourceforge.net/dsdt/view.php?id=77) was loaded 
correctly, but system froze after 'Executing all Device _STA and_INI methods' 
as before.

o references
------------
I found one similar description of problem, with Compaq Presario 2158 EA,
but no solution 
(http://linux.derkeiler.com/Newsgroups/comp.os.linux.portable/2003-09/0017.html).

It's bit strange to me, and maybe I should test some older ACPI versions,
as there are many pages with information, that ACPI with modified DSDT is 
almost fully functional... 

o system details
----------------

2.6.6-rc1 config: 
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/config-2.6.6-rc1
2.4.25 config:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/config-2.4.25

acpidmp output:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/acpidmp

cpuinfo:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/cpuinfo
lspci:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci-v
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci-v-v
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/lspci-v-v-v
/proc/dma:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/dma
/proc/interrupts:
 http://zeus.polsl.gliwice.pl/~jfk/kernel/acpi/interrupts

(all collected with acpi=off)

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
jfsutils               1.1.4
xfsprogs               2.6.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91

Suggestions are welcome.

bye!

-- 
Jacek Kawa

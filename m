Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270092AbTGZVDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270151AbTGZVDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:03:22 -0400
Received: from icemserv.folkwang-hochschule.de ([193.175.156.129]:15376 "EHLO
	icemserv.folkwang-hochschule.de") by vger.kernel.org with ESMTP
	id S270092AbTGZVDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:03:09 -0400
Date: Sat, 26 Jul 2003 23:18:18 +0200
From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-pre8 make dep bug?
Message-ID: <20030726211818.GB2835@finnendahl.de>
References: <20030726171527.GA1173@finnendahl.de> <200307261342.17010.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200307261342.17010.gene.heskett@verizon.net>
Organization: Folkwang-Hochschule, Essen, Germany
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to make a 2.4.22-pre8 kernel fails. After patching a vanilla
2.4.21, copying my old menuconfig to the source and 'make oldconfig',
all working fine, make dep dies:

grisey:/usr/src/linux# make dep
make[1]: Entering directory `/usr/src/linux-2.4.22-pre8/arch/i386/boot'
make[1]: Für das Ziel »dep« ist nichts zu tun.
make[1]: Leaving directory `/usr/src/linux-2.4.22-pre8/arch/i386/boot'
rm -f .depend .hdepend
make _sfdep_kernel _sfdep_drivers _sfdep_mm _sfdep_fs _sfdep_net _sfdep_ipc _sfdep_lib _sfdep_crypto _sfdep_arch/i386/kernel _sfdep_arch/i386/mm _sfdep_arch/i386/lib _FASTDEP_ALL_SUB_DIRS="kernel drivers mm fs net ipc lib crypto arch/i386/kernel arch/i386/mm arch/i386/lib"
make[1]: Entering directory `/usr/src/linux-2.4.22-pre8'
make -C kernel fastdep
make[2]: Entering directory `/usr/src/linux-2.4.22-pre8/kernel'

<...>

(30 or so more lines all looking like always)
and then:


make[3]: Entering directory `/usr/src/linux-2.4.22-pre8/drivers'
make -C acpi fastdep
make[4]: Entering directory `/usr/src/linux-2.4.22-pre8/drivers/acpi'
/usr/src/linux-2.4.22-pre8/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.22-pre8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -D_LINUX -I/usr/src/linux-2.4.22-pre8/drivers/acpi/include -nostdinc -iwithprefix include -- ac.c acpi_ksyms.c asus_acpi.c battery.c blacklist.c bus.c button.c ec.c fan.c numa.c osl.c pci_bind.c pci_irq.c pci_link.c pci_root.c power.c processor.c system.c tables.c thermal.c toshiba_acpi.c utils.c > .depend
realpath(/usr/src/linux-2.4.22-pre8/drivers/acpi/include) failed, No such file or directory
make[4]: *** [fastdep] Fehler 1
make[4]: Leaving directory `/usr/src/linux-2.4.22-pre8/drivers/acpi'
make[3]: *** [_sfdep_acpi] Fehler 2
make[3]: Leaving directory `/usr/src/linux-2.4.22-pre8/drivers'
make[2]: *** [fastdep] Fehler 2
make[2]: Leaving directory `/usr/src/linux-2.4.22-pre8/drivers'
make[1]: *** [_sfdep_drivers] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.4.22-pre8'
make: *** [dep-files] Fehler 2
grisey:/usr/src/linux#



Is this a bug or some mistake on my side?

--
Orm


P.S.: Thanx for the help on the previous issues!

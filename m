Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTIQOHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 10:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTIQOHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 10:07:13 -0400
Received: from infres.enst.fr ([137.194.192.1]:39813 "EHLO infres.enst.fr")
	by vger.kernel.org with ESMTP id S262761AbTIQOHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 10:07:02 -0400
Date: Wed, 17 Sep 2003 16:07:00 +0200 (CEST)
From: Ramon Casellas <casellas@infres.enst.fr>
X-X-Sender: casellas@gandalf.localdomain
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: IBM Thinkpad and ACPI 20030916 for 2.4.23-pre4
Message-ID: <Pine.LNX.4.58.0309171546250.8045@gandalf.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi All,

I'm currently using an IBM thinkpad X.31 (latest BIOS). With most recent 
IBM thinkpads, ACPI versions prior to 20030916 fail to correctly detect 
the Embedded Controller, thus making acpi practically unusable. [1] 
There is a patch from Yu Luming that fixes this, but introduces new 
errors [1][2] (unable to read battery status).

For 2.6.0-test3 up to test5-mm2, there is a "patch-set" [2] that fixes
most issues, and I have been using it succesfully for several weeks:

[1] http://bugme.osdl.org/show_bug.cgi?id=1038
[2] http://erkki.tty0.org/thinkpad/thinkpad-acpi.html


The output of dmesg with 2.6.0-test5-mm2 with patch[2]:

ACPI: RSDP (v002 IBM                                       ) @ 0x000f6ba0
ACPI: XSDT (v001 IBM    TP-1Q    0x00001041  LTP 0x00000000) @ 0x3ff6c6e6
ACPI: FADT (v003 IBM    TP-1Q    0x00001041 IBM  0x00000001) @ 0x3ff6c800
ACPI: SSDT (v001 IBM    TP-1Q    0x00001041 MSFT 0x0100000e) @ 0x3ff6c9b4
ACPI: ECDT (v001 IBM    TP-1Q    0x00001041 IBM  0x00000001) @ 0x3ff78ea3
ACPI: TCPA (v001 IBM    TP-1Q    0x00001041 PTL  0x00000001) @ 0x3ff78ef5
ACPI: BOOT (v001 IBM    TP-1Q    0x00001041  LTP 0x00000001) @ 0x3ff78fd8
ACPI: DSDT (v001 IBM    TP-1Q    0x00001041 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
ACPI: Subsystem revision 20030813
ACPI: Found ECDT
    ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.USB7._INI] 
(Node c1af8b60), AE_AML_REGION_LIMIT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (63 C)
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)


works fine....




I tried 2.4.23-pre4+ACPI 20030916 and it looks like that only the 
"Embedded Controller patch" has been included. I cannot read the status of 
the battery:

If I do cat /proc/acpi/battery/BAT0/state I get: 

alarm:                   2376 mWh
present:                 yes
design capacity:         47520 mWh
last full capacity:      41070 mWh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 2376 mWh
design capacity low:     475 mWh
capacity granularity 1:  1 mWh
capacity granularity 2:  1 mWh
model number:            IBM-08K8040
serial number:            1348
battery type:            LION
OEM info:                SANYO
present:                 yes

ERROR: Unable to read battery status
-------------------------------------

If I repeat again, the output of dmesg is (4)


There exists a patch at

[3] http://erkki.tty0.org/thinkpad/kernel/acpi-thinkpad-battery-patch


Has any one else seen this behaviour? For me, it is a regression. Can this
patch be integrated or is there a valid reason not to? I would appreciate 
an anwser on this.

Thank you for your work & time.


Regards,
R.


// --------------------------------------------------------
// Ramon Casellas 		GET/ENST/INFRES/RHD/C206  



(4):
ACB) in object f6916c68

utdelete-0381 [111] ut_update_ref_count   : **** Warning **** Large Reference Count (CACC) in object f6916f68

utdelete-0381 [116] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f6916c68

utdelete-0381 [113] ut_update_ref_count   : **** Warning **** Large Reference Count (CACB) in object f6916c68

utdelete-0381 [116] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f6916c68

utdelete-0381 [113] ut_update_ref_count   : **** Warning **** Large Reference Count (CACB) in object f6916c68

utdelete-0381 [116] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f6916c68

utdelete-0381 [113] ut_update_ref_count   : **** Warning **** Large Reference Count (CACB) in object f6916c68

 exstore-0296 [113] ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.GBST] (Node f7fd90e8), AE_AML_INTERNAL
utdelete-0381 [113] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f69169e8


(lines, and lines)..........


 exstore-0296 [127] ex_store_object_to_ind: Could not store object to indexed package element
 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.GBST] (Node f7fd90e8), AE_AML_INTERNAL
utdelete-0381 [127] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f69169e8

utdelete-0381 [127] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f6916c68

 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node f7fd9768), AE_AML_INTERNAL
acpi_battery-0195 [116] acpi_battery_get_statu: Error evaluating _BST
utdelete-0381 [131] ut_update_ref_count   : **** Warning **** Large Reference Count (CAC9) in object f69169e8

utdelete-0381 [129] ut_update_ref_count   : **** Warning **** Large Reference Count (CACA) in object f6916f68

 psparse-1121: *** Error: Method execution failed [\_SB_.PCI0.LPC_.EC__.BAT0._BST] (Node f7fd9768), AE_AML_INTERNAL
acpi_battery-0195 [118] acpi_battery_get_statu: Error evaluating _BST
utdelete-0381 [133] ut_update_ref_count   : **** Warning **** Large Reference Count (CAC9) in object f69169e8






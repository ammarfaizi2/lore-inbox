Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTKYSBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 13:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTKYSBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 13:01:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65008 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262762AbTKYSBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 13:01:40 -0500
Date: Tue, 25 Nov 2003 10:26:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: bevdv@yahoo.com
Subject: [Bug 1589] New: 2.6.0-test10 (SMP) hangs at boot during	SCSI initialization  (fwd)
Message-ID: <50220000.1069784804@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1589

           Summary: 2.6.0-test10 (SMP) hangs at boot during SCSI
                    initialization
    Kernel Version: 2.6.10-test10
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: bevdv@yahoo.com


Distribution: Gentoo

Hardware Environment:
please root # lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:09.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4400]
(rev a3)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07)
02:04.0 Ethernet controller: Accton Technology Corporation EN-1216 Ethernet
Adapter (rev 11)
02:06.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 04)
02:07.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

Software Environment:
unpatched 2.6.10-test10

# 
# SCSI device support
# 
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

# 
# SCSI support type (disk, tape, CD-ROM)
# 
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

# 
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
# 
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

# 
# SCSI low-level drivers
# 
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y


Problem Description:

With aic7xxx=verbose, the boot gets as far as:

Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Reading SEEPROM...done.
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: BIOS eeprom is present
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Secondary High byte
termination Enabled
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Secondary Low byte
termination Enabled
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Primary Low Byte
termination Enabled
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Primary High Byte
termination Enabled
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Downloading Sequencer
Program... 422 instructions downloaded
Nov 24 21:51:25 s_kernel@please kernel: ahc_pci:0:9:0: Features 0x1def6, Bugs
0x40, Flags 0x20485540


and then completely hangs, nothing but a reset will break out. I have heard a
report that someone else had this problem and their kernel would boot after they
recompiled without SMP support.  I will try that tomorrow, but it is late now. 

Oh, and I should mention that 2.6.0-test9 has been working without a hitch.

Steps to reproduce:



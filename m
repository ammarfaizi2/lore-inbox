Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318784AbSG0Qmg>; Sat, 27 Jul 2002 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSG0Qmg>; Sat, 27 Jul 2002 12:42:36 -0400
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:2267 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S318784AbSG0Qmf>; Sat, 27 Jul 2002 12:42:35 -0400
Date: Sat, 27 Jul 2002 10:45:52 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 rtc problems
Message-ID: <Pine.LNX.4.44.0207271034240.17033-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
After upgrading one of our dell 6400s to 2.4.18, we found that the
hardware clock would at times be stopped (cat /proc/driver/rtc confirmed
the output of /sbin/hwclock), sometimes would warp
forward, and sometimes would lose times.  I am aware of the problems
associated with rtc and smp, but this is the only smp system we run with
this problem.

I seem to have resolved the problem by disabling the NVRAM option.
After recompiling (other cleanups as well) and rebooting the systems
does not lose time, and the hardware clock is keeping very good time again.
The only other major changes were intel rng driver, OSB4/OSB5 specific IDE
options, and upgrade the e1000 driver from 4.0.7 to 4.3.2.

Has anyone else experienced this problem?  I don't understand how it could
be the NVRAM device, as the device file wasn't even created,
unless there was some other interaction happening.  

Here's a bit more info about hardware and kernel
o Changes between problematic kernel and current working kernel:
- Rebuilt for dell4300-6400 config after removing NVRAM, and intel rng
  drivers to try and resolve problems with rtc.
- Turned on additional parport options.
- Turned on netfilter as a module.
- Turned on ipv6 as a module.
- Removed blk_dev cmd640, rz1000.
- Turned on idepci_share_irq.
- Turned on svrks OSB4/OSB5 IDE interface.

o Dell 6400, 2x700MHz PIII Xeon

o lspci output:
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:04.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a)
00:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
00:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
00:07.0 PCI bridge: Intel Corp. 80960RP [i960 RP Microprocessor/Bridge]
(rev 02)
00:07.1 I2O: Intel Corp. 80960RP [i960RP Microprocessor] (rev 02)
00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04)
04:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
08)
04:0b.0 Ethernet controller: Intel Corp. 82542 Gigabit Ethernet Controller
(rev 03)


TIA

Regards
James Bourne

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."



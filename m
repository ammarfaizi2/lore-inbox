Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUJNOPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUJNOPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUJNOPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:15:38 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:9979 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265044AbUJNOPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:15:34 -0400
From: "Steven A. DuChene" <linux-clusters@mindspring.com>
Date: Thu, 14 Oct 2004 06:28:49 -0400
To: linux-kernel@vger.kernel.org
Subject: AIC-7899 not found with 2.6.9-rc4-mm1
Message-ID: <20041014062848.U22429@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with two on-board SCSI controllers (see lsoci output below)
and one AHA-2940U stuck into a PCI slot. The on-board controllers are Adaptec
AIC-7899P U160 chips on the Intel server mboard. I have been running the system with
2.6.8-rc4-mm1 but detected some abnormalities with NFS server subsystem stuff
so I decided to update to 2.6.9-rc4-mm1 however when I did so only the AHA-2940U
card that is stuck into the PCI slot is found. Since this is not the controller
with the disks attached the system is not able to find it's root filesystem.
The output of lspci looks like:

xcvs:/usr/local/src/linux-2.6.9-rc4-mm1 # lspci 
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC] (rev 7a)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:08.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
01:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m
01:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m

In my .config file I have the following set:

CONFIG_SCSI_AIC7XXX=y 
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set

This same configuration worked fine with 2.6.8-rc4-mm1 but not with the
2.6.9-rc4-mm1 source tree. Later this afternoon I will try backing out
the mm1 patch to the 2.6.9-rc4 source tree and see if the problem still
occures with just the plain 2.6.9-rc4 kernel.
-- 
Steven A. DuChene     linux-clusters at mindspring dot com

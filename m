Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVJFNOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVJFNOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVJFNOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:14:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35042 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750885AbVJFNOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:14:11 -0400
Message-ID: <43452315.7050801@pobox.com>
Date: Thu, 06 Oct 2005 09:13:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
References: <20051005210610.EC31826369@lns1058.lss.emc.com> <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de>
In-Reply-To: <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> mv_phy_reset: ENTER, port 0, mmio 0xf8a22000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_mv
> mv_phy_reset: ENTER, port 1, mmio 0xf8a24000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata4: no device found (phy stat 00000000)
> scsi3 : sata_mv
> mv_phy_reset: ENTER, port 2, mmio 0xf8a26000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata5: no device found (phy stat 00000000)
> scsi4 : sata_mv
> mv_phy_reset: ENTER, port 3, mmio 0xf8a28000
> mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 
> SCtrl 0x00000000
> ata6: no device found (phy stat 00000000)
> scsi5 : sata_mv

Staring at the docs a bit, I notice that the 50xx and 60xx have SATA 
S{status,control,error} registers at different locations.

50xx:

	SStatus:
	SATAHC0 0x20100 0x20200 0x20300 0x20400
	SATAHC1 0x30100 0x30200 0x30300 0x30400

	SError:
	SStatus addr + 4

	SControl:
	SStatus addr + 8

60xx:

	SStatus:
	SATAHC0 0x22300 0x24300 0x26300 0x28300
	SATAHC1 0x32300 0x34300 0x36300 0x38300

	SError:
	SStatus addr + 4

	SControl:
	SStatus addr + 8


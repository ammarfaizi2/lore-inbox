Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966453AbWKNXVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966453AbWKNXVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966461AbWKNXVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:21:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:50453 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966453AbWKNXVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:21:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uUFWhh7Ld67y2q0O0twgR603L1+PI0FB0m+QysJNMOfKVUx9CuT1UG+G59IFbU0Ikip0lj/T96yqBe5CFc3ndP4UrQcm5orDZ3IgDFVzQe4wz56sReVrkqEt6wYoXeWZdJRZ7AY1c9MKbOKENFnvPU4vSnpyJX1DGsDtZ/RWTXs=
Message-ID: <a44ae5cd0611141521pd342109jaae9e27aca3d2200@mail.gmail.com>
Date: Tue, 14 Nov 2006 15:21:46 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Larry.Finger@lwfinger.net
Subject: 2.6.19-rc5-mm2 -- bcm43xx busted (backing out the bcm43xx patches fixes it)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The last three MM kernels have fail to give me a working bcm43xx driver.
The odd thing is that dmesg output seems to indicate that the driver
is working okay.  NetworkManager doesn't see the driver, though.
"iwlist scan" fails to find any access points, too.  iwconfig shows
"Access Point: invalid".

I tried backing out the following patches, and it fixes the problem:

drivers/net/wireless/bcm43xx/bcm43xx.h
drivers/net/wireless/bcm43xx/bcm43xx_main.c
drivers/net/wireless/bcm43xx/bcm43xx_power.c
drivers/net/wireless/bcm43xx/bcm43xx_wx.c
drivers/net/wireless/bcm43xx/bcm43xx_xmit.c

After backing out the patches, dmesg shows:

bcm43xx driver
bcm43xx: Chip ID 0x4306, rev 0x3
bcm43xx: Number of cores: 5
bcm43xx: Core 0: ID 0x800, rev 0x4, vendor 0x4243, enabled
bcm43xx: Core 1: ID 0x812, rev 0x5, vendor 0x4243, disabled
bcm43xx: Core 2: ID 0x80d, rev 0x2, vendor 0x4243, enabled
bcm43xx: Core 3: ID 0x807, rev 0x2, vendor 0x4243, disabled
bcm43xx: Core 4: ID 0x804, rev 0x9, vendor 0x4243, enabled
bcm43xx: PHY connected
bcm43xx: Detected PHY: Version: 2, Type 2, Revision 2
bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
bcm43xx: PHY connected
bcm43xx: Microcode rev 0x127, pl 0xe (2005-04-18  02:36:27)
bcm43xx: Radio turned on
bcm43xx: Chip initialized
bcm43xx: 30-bit DMA initialized
bcm43xx: Keys cleared
bcm43xx: Selected 802.11 core (phytype 2)

Also, iwconfig shows:
eth2      IEEE 802.11b/g  ESSID:"loftywifi"  Nickname:"Broadcom 4306"
          Mode:Managed  Frequency=2.412 GHz  Access Point: 00:06:25:54:A2:0C
          Bit Rate=11 Mb/s   Tx-Power=19 dBm
          RTS thr:off   Fragment thr:off
          Encryption key:23F8-49CF-201A-4334-1210-7C3E-0A   Security mode:open
          Link Quality=76/100  Signal level=-53 dBm  Noise level=-72 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

Thanks,
          Miles

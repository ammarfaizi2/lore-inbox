Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVIMJ6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVIMJ6h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVIMJ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:58:36 -0400
Received: from outmx025.isp.belgacom.be ([195.238.2.49]:55725 "EHLO
	outmx025.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932475AbVIMJ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:58:36 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: ACPI S3 and ieee1394 don't get along
Date: Tue, 13 Sep 2005 11:56:31 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, linux1394-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509131156.31914.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists,

Running kernel 2.6.13.1, no patches.

Yesterday, after putting my laptop into S3 and reviving it at home, the firewire interface was
unusable, no response when plugging in my external disk, loading sbp2 manually didn't trigger anything.

At this point I unloaded the ohci1394 module, and reloaded it:

Sep 12 16:59:52 precious kernel: ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[00c09f00000c8dfa]
Sep 12 16:59:52 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 16:59:53 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 16:59:57 precious kernel: ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
Sep 12 16:59:57 precious kernel: ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Sep 12 16:59:57 precious kernel: PCI: Setting latency timer of device 0000:02:07.0 to 64
Sep 12 16:59:57 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 16:59:57 precious kernel: ohci1394: fw-host0: Runaway loop while stopping context: ...
Sep 12 16:59:58 precious last message repeated 3 times
Sep 12 16:59:58 precious kernel: ohci1394: fw-host0: OHCI-1394 165.165 (PCI): IRQ=[10]  MMIO=[d0209000-d02097ff]  Max Packet=[65536]
Sep 12 16:59:58 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 17:00:01 precious last message repeated 29 times
Sep 12 17:00:01 precious kernel: ohci1394: fw-host0: Serial EEPROM has suspicious values, attempting to setting max_packet_size to 512 bytes
Sep 12 17:00:02 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 17:00:31 precious last message repeated 2 times
Sep 12 17:00:39 precious kernel: ieee1394: Initialized config rom entry `ip1394'
Sep 12 17:00:39 precious kernel: ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
Sep 12 17:00:39 precious kernel: ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Sep 12 17:00:40 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 17:00:40 precious kernel: ohci1394: fw-host0: Runaway loop while stopping context: ...
Sep 12 17:00:40 precious last message repeated 3 times
Sep 12 17:00:40 precious kernel: ohci1394: fw-host0: OHCI-1394 165.165 (PCI): IRQ=[10]  MMIO=[d0209000-d02097ff]  Max Packet=[65536]
Sep 12 17:00:40 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]
Sep 12 17:00:43 precious last message repeated 29 times
Sep 12 17:00:43 precious kernel: ohci1394: fw-host0: Serial EEPROM has suspicious values, attempting to setting max_packet_size to 512 bytes
Sep 12 17:00:44 precious kernel: ohci1394: fw-host0: Set PHY Reg timeout [0xffffffff/0x00004000/100]

clearly it didn't really got back it's old state when returning from S3. Rebooting helped, but that's
what i'm trying to avoid by using S3 :p

lspci for the firewire interface:

0000:02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Acer Incorporated [ALI]: Unknown device 001f
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at d0209000 (32-bit, non-prefetchable) [size=2K]
        Memory at d0200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

I saw this thread: http://marc.theaimsgroup.com/?l=linux1394-user&m=111262313930798&w=2 tho I'm not sure if it's relevant to this.

Any patches I might try? The linux1394.org site still is down, so nothing to dig on there ;)

For the firewire maintainers: great job you're doing on it!

Jan

-- 
  Smoking is the leading cause of statistics.

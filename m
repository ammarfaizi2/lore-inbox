Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKVJR>; Thu, 11 Jan 2001 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRAKVJH>; Thu, 11 Jan 2001 16:09:07 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:37640 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129631AbRAKVI5>; Thu, 11 Jan 2001 16:08:57 -0500
Message-ID: <3A5E20E0.ED883A63@cs.wisc.edu>
Date: Thu, 11 Jan 2001 13:08:48 -0800
From: Mihai Christodorescu <mihai@cs.wisc.edu>
Organization: UWisc - CS - http://www.cs.wisc.edu/~mihai
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 eth0 timeout after wake from suspend
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I jsut upgraded to 2.4.0 and I started getting eth timeouts after the machine
wakes from suspend. The sequence of log events is:

Jan 11 07:16:34 HOST apmd[420]: System Suspend
Jan 11 12:20:27 HOST kernel: PCI: Found IRQ 5 for device 00:0a.0
Jan 11 12:20:41 HOST apmd[420]: Normal Resume after 05:04:07 (-1% unknown) AC
power
Jan 11 12:20:41 HOST anacron[3599]: Anacron 2.3 started on 2001-01-11
Jan 11 12:20:41 HOST anacron[3599]: Normal exit (0 jobs run)
Jan 11 12:20:49 HOST kernel: NETDEV WATCHDOG: eth0: transmit timed out

	The kernel is compiled with APM, but without ACPI support. The bios (Award
BIOS on Asus A7V motherboard) is configured to go to suspend mode, and it
support ACPI (if I compile the kernel with ACPI support, it detects the bios
support, but it no longer goes into suspend). The network card is a NetGear
FA310TX (with a DEC 21140AE chipset), and I am running it with the tulip
driver. The boot detection of the card looks like:

eth0: Lite-On 82c168 PNIC rev 32 at 0x9400, 00:A0:CC:40:B4:AD, IRQ 5.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
PPP generic driver version 2.4.1
eth0: Setting full-duplex based on MII#1 link partner capability of
41e1.                         

(it says lite-on, but it is a NetGear FA310TX)

	When it comes back from suspend, I have to unload the driver (modprobe -r
tulip) and load it again in order to get the network running. Kernel 2.2.17
used to wake from suspend just fine.
	Any suggestions? Please CC: me (mihai@cs.wisc.edu), as I am not on the kernel
mailing list.

Thanks,

Mihai

-- 
 Mihai Christodorescu -=- mihai@cs.wisc.edu - http://www.cs.wisc.edu/~mihai
.---------------------------------------------------------------------------
|   The man of knowledge must be able not only to love his enemies but also
| to hate his friends.                                - Friedrich Nietzsche
`---------------------------------------------------------------------------
PGP signature block might follow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbQKQRRW>; Fri, 17 Nov 2000 12:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130576AbQKQRRM>; Fri, 17 Nov 2000 12:17:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65296 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130451AbQKQRQ6>;
	Fri, 17 Nov 2000 12:16:58 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171646.QAA01224@raistlin.arm.linux.org.uk>
Subject: Re: VGA PCI IO port reservations
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Fri, 17 Nov 2000 16:46:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, mj@suse.cz
In-Reply-To: <3A155E8C.7D345649@mandrakesoft.com> from "Jeff Garzik" at Nov 17, 2000 11:36:28 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> > For example, S3 cards typically use:
> > 
> >  0x0102,  0x42e8,  0x46e8,  0x4ae8,  0x8180 - 0x8200,  0x82e8,  0x86e8,
> >  0x8ae8,  0x8ee8,  0x92e8,  0x96e8,  0x9ae8,  0x9ee8,  0xa2e8,  0xa6e8,
> >  0xaae8,  0xaee8,  0xb2e8,  0xb6e8,  0xbae8,  0xbee8,  0xe2e8,
> >  0xff00 - 0xff44
      ^^^^ PCI IO addresses

> I tried to push this through when I was hacking heavily on fbdev
> drivers, especially S3, and it didn't fly.  On x86's, those addresses
> are already reserved:

No they're not.

> [jgarzik@rum linux_2_4]$ cat /proc/iomem
> 00000000-0009efff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> [...]

   ^^^^^^^^^^^^^ PCI memory addresses.

> Another alternative I thought of is freeing the resource if it is
> allocated by the system, and having the driver allocate its own
> resource.  When the driver unloads, it frees its resources and allocates
> the whole region back to the system.  I look at this as the fbdev
> driver's "clarifying the picture" of the hardware resource usage. 

If the driver isn't loaded, the port is still used by the hardware.  Therefore,
it should be reserved independent of whether we have the driver loaded/in kernel
or not.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

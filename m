Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266164AbRGGNk5>; Sat, 7 Jul 2001 09:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266169AbRGGNks>; Sat, 7 Jul 2001 09:40:48 -0400
Received: from mail1.mx.voyager.net ([216.93.66.200]:521 "EHLO
	mail1.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S266164AbRGGNko>; Sat, 7 Jul 2001 09:40:44 -0400
Message-ID: <3B47130B.6B0D4F04@megsinet.net>
Date: Sat, 07 Jul 2001 08:47:55 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jim Roland <jroland@roland.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
In-Reply-To: <3B469D66.7B100BD3@megsinet.net> <002201c106e7$4a64da20$bb1cfa18@JimWS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim,

Thanks for the info, comments interleaved below

Thanks
Martin

Jim Roland wrote:
> 
> Activating an IDE drive in an older BIOS (newer ones have a SCSI option in
> the "A/C/CDROM" options) will always force an IDE drive boot with older
> BIOSes.  Older BIOSes are written to stop looking for a boot device once it
> has found one, and it's own IDE is where it says "Ok, I have boot
> capability", otherwise no IDE drive, means it passes boot control to other
> system BIOSes (like your SCSI or NIC cards).  This is by default with older
> systems.

This behavior is acceptable, as I can as you suggest move the kernel to the
IDE and tell it the root device is /dev/md0.  Actually that is what I did
to a floppy to get access to the system while the BIOS was set to <auto>
detect the IDE drives.   Since I only boot whenever Linus puts out a new
kernel that isn't so much of a concern.

> 
> I expect someone will rebut my comments about the kernel (which is fine, I'm
> not a Kernel hacker--PROPERLY USED TERM HERE (not the media's term) <grin>),
> but it is my understanding that the kernel uses your system BIOS for actual
> reads/writes at the hardware level, this way it does not have to account for
> EVERY possible BIOS out there.  (Other OSes use BIOS system calls for this
> purpose as well)  When you turn BIOS to <NONE> the OS does what it can, but
> the BIOS in your system *SHOULD* refuse to process the call, instead it's
> doing the read/writes, but not the same way as if IDE was turned on.

But, that's kind of the point I'm driving at if the OS can't correctly access the
IDE interface it shouldn't do it at all.

My guess is that the CMD64X driver is broken since the system can write data
to the HD but with random corruption. Ditto for reading data.  Likewise,
why would I see an increase in write performance when "dd if=/dev/zero of=/dev/null"
is running simultaneously on another console.

> Are you getting IDE corruption with the BIOS set to <AUTO> for your IDE
> drive?

None whatsoever.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132670AbRAVRCq>; Mon, 22 Jan 2001 12:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132800AbRAVRCg>; Mon, 22 Jan 2001 12:02:36 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:39438 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132670AbRAVRCY>; Mon, 22 Jan 2001 12:02:24 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF3D@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Duncan Laurie'" <duncan@virtualwire.org>,
        Petr Matula <pem@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: RE: int. assignment on SMP + ServerWorks chipset
Date: Mon, 22 Jan 2001 09:01:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duncan,

> From: Duncan Laurie [mailto:duncan@virtualwire.org]
> 
> Hi Petr,
> 
> I didn't consider that your hardware would have subtle differences
> than Mr. Dunlap's Intel SBT2 board, but these could have made the
> hard-coded values in the patch invalid.  So instead try the attached
> patch, and this time you'll need to plug in some values into a boot
> parameter to override the mptable entry.

Petr's listing of /proc/interrupts also did not use IRQ 9
(from Jan. 11, 2001 email).

I expect that our STL2 boards are very much alike, with possible
differences in processor speed and RAM size.  I also have
disabled SCSI in BIOS SETUP while Petr has not, since he is using
SCSI disks and I am using IDE.

> This "mpint=" parameter allows you to alter a specific (IO)INT mptable
> entry destination APIC and INT.  It takes four arguments, the first
> two for looking up the entry to change in the current mptable by APIC
> and INT, and the second two are for the new APIC and INT 
> values to use.
> (I also have an expanded version that allows more detailed
> modifications but the number of arguments gets out of hand very fast)
> 
> The values to use depend on what your system is configured to use
> for the USB interrupt.  This can be obtained by using the dump_pirq
> utility from the recent pcmcia utilities.  (I made some modifications
> to recognize the ServerWorks IRQ router which is available from
> ftp://virtualwire.org/dump_pirq)

Thanks for that.

> The output you are looking for should look something like this:
> 
> Device 00:0f.0 (slot 0): ISA bridge
>     INTA: link 0x01, irq mask 0x0400 [10]
> 
> The USB device is actually function 2, but uses INTA#.  The irq
> mask value should give you the new INT value to put in the
> mptable.  The old INT value can be read from the dmesg output
> or by compiling and running mptable, which I also made available
> at ftp://virtualwire.org/mptable.c.  (it appears to be '0' on your
> hardware as well as Mr. Dunlap's)  The destination APIC should just
> be the ID of the first IO-APIC in the system, in this case 4.

I had also ported that program a few months ago, but was
advised against it since the BIOS can build the MP table
dynamically, and it could be from a skeleton table in EEPROM,
so the mptable program could find and print the wrong version
of the table.  Just a small warning.

> So based on the example above, you would add "mpint=5,0,4,10" to
> the boot parameters.  One caveat, this doesn't actually change the
> mptable as it is stored in memory so if you use the mptable program
> to view it you will still see the original values.

Duncan, do you still think that there might be a BIOS MP table
error?  Also, what would you propose as a long-term solution to
this problem?  This patch or something else?

Thanks,
~Randy


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

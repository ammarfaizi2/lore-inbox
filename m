Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135901AbRDTM5U>; Fri, 20 Apr 2001 08:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135903AbRDTM5E>; Fri, 20 Apr 2001 08:57:04 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:49346 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S135901AbRDTM4l>; Fri, 20 Apr 2001 08:56:41 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@transmeta.com>,
        <linux-power@phobos.fachschaften.tu-muenchen.de>
Subject: Re: PCI power management
Date: Fri, 20 Apr 2001 14:56:15 +0200
Message-Id: <20010420125615.23599@mailhost.mipsys.com>
In-Reply-To: <3AE02E45.57D7BA9D@mandrakesoft.com>
In-Reply-To: <3AE02E45.57D7BA9D@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some devices (bad bad HW designers ;) just can't do it themselves. The
>> Rage M3 requires the host to assert PCI RST#, and some motherboards
>> provide no documented facility for that (it might be possible with Apple
>> ASICs for example, it's just not documented).
>
>Why should we support such a non-spec device?  Tell ATI to fix their
>hardware, and tell users (a) not to use the hardware, or (b) use the
>hardware with the knowledge that you are screwed when it comes to Power
>Management.
>
>Unless there are more cases like this, this should not factor at all
>into the modifications to the PCI and PM code...

Well, I can tell all PowerBook and iBook users to forget about sleep...

Also, that would not be the first time we have to deal with poorly
documented hardware. I don't think we should refuse to handle any
hardware that is out of spec... it would be like saying Linux doesn't
support any x86 with a broken BIOS...

It's not so complicated to have the minimum flexibility for the driver
to tell it's maximum supported power level, and I don't see why it would
be a problem to use D2 instead of D3 when we don't support D3 for a given
device (either because the HW is broken, undocumented, or because our
driver just don't know how to bring back the chip to life).

If the motherboard _requires_ it (because it will cut power from the chip),
the we can refuse to enter sleep when one driver can't do it (instead of
letting the user crash the box badly).

In any case, I beleive you are focusing on a point of detail. All
I'm asking for (in this specific case) is a simple mask of flags set
by the driver to tell what it can handle. It's also useful for
devices that don't support PM on machines whose motherboard provide
facility to turn OFF power on selected cards. It would allow us to
turn off cards for drivers that can handle recovering. 

Also, I don't think the problem of powering back up the chip and
re-initing it from scratch is specific to those ATI chips. Look at
XFree, it has to run a BIOS emulator to soft boot video chips. On
PCs, I beleive you have the BIOS that re-init them when waking up
from an APM or ACPI suspend. On non-PCs when suspend is not handled
by the firmware but directly by the kernel, that's not the case.

Ben.




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265562AbRGFHfb>; Fri, 6 Jul 2001 03:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbRGFHfV>; Fri, 6 Jul 2001 03:35:21 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:33035 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S265562AbRGFHfH>; Fri, 6 Jul 2001 03:35:07 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Date: Fri, 6 Jul 2001 09:34:59 +0200
Message-Id: <20010706073459.5593@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.33.0107050810400.22053-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107050810400.22053-100000@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Nope.
>
>I do not want to maintain two interfaces. If we make user space the way to
>do these things, then we will do pretty much most of the driver setup etc
>in user space. We'd have to: we'd enter user space before drivers have had
>a chance to initialize, exactly because "features like these" can change
>the device mappings etc.
>
>And I don't want to have two completely different bootup paths.

I agree. Also, having this userland step would help for things like
booting from an FireWire or USB hard disk. I hacked the SBP2 (FW)
driver to be useable as a boot device, but this involved adding an
ugly schedule() loop for a couple of seconds before mouting root
in order to leave some time for the drive to be probed. Also, on
such dynamic busses, you can't really know which device major/minor
a given drive will be assigned.

Having a userland mecanism here would allow waiting for all devices
to be probed, reading of the disk GUID (on fw at least) to figure
out where is the real root device, etc... Even displaying a nice
UI to let the user pick a root device is none is found, etc...

So your idea fixes more than just the ACPI problems ;)

Ben.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQLYGR2>; Mon, 25 Dec 2000 01:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbQLYGRS>; Mon, 25 Dec 2000 01:17:18 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:45957 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S130010AbQLYGRH>; Mon, 25 Dec 2000 01:17:07 -0500
Date: Sun, 24 Dec 2000 23:46:02 -0600
From: Eric Shattow <radoni@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Proposal: devfs names ending in %d or %u
Reply-To: radoni@crosswinds.net
In-Reply-To: <20001224192840.A12097@adam.yggdrasil.com>
In-Reply-To: <20001224192840.A12097@adam.yggdrasil.com>
X-Mailer: Spruce 0.7.5 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14AQT2-0001ud-00@dfw-mmp2.email.verio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2000, Adam J. Richter wrote:
> 	I propose to change the devfs registration functions
> to allow registrations of devices ending in %d or %u, in which
> case it will use the first value, starting at 0, that generates a
> string that already registered.  So, if I have disc0, disc1, and disc2,
> and I remove the device containing disc1, then disc1 will be next
> disc device name to be registered, then disc3, then disc4, etc.

i use devfs for my computers and i agree that the quasi-consistancy of
device naming is annoying.  my example is with my scsi zip ext. drive. 
when i insert a FAT formatted disc with a PC partition table, the partition
i want to mount is part1.  when i insert a HFS formatted disc with a MAC
partition table, the partition i want to mount is part4. this is very ugly,
having to set up two entries in fstab for the same device.  instead of
messing around with the naming behavior, why not add configuartion options
to the devfsd daemon?  they could be per-driver/host/device.  maybe i just
don't see how to do it with the existing system. in the meantime i am just
setting up a /dev/mntsym/ directory that has symlinks "zip" "cdrom" "dvd",
etc. when the appropriate modules register, as a quick hack until this is
resolved.

> This will make it a bit simpler to add devfs support to
> the remaining drivers that do not have it, and it will make
> numbering within devfs much simpler by default.  Of course, drivers
> that want to do their own thing the current way would not be impeded
> from doing so by this change.

it is my opinion that drivers should not have to be too specific about
where their representitive /dev entries end up. i don't know enough about
internals, but there must be a way to unify the registration of device
entries. make the drivers register with the devfs system with the default
informations and specifications, and let the devfs system make those dumb
null entries or what ever else. it would be yet another layer of
abstraction, but it might help make the devfs more flexible.

sidenote: i got a new laptop with a serial port and lots of unsupported
hardware. i went to work hacking away at what i could. i noticed especially
with devfs, that debugging serial port like /dev/tts/0 is impossible if the
serial.o driver refuses to load due to an IRQ conflict. if the driver never
registers/auto_config's, the /dev/tts entries are not there to use.  this
is of concern, since some device names should be created regardless of
whether the device is loaded or not.  without the device entries for serial
ports i was not able to give 'setserial' or 'stty' a proper device name for
the ports. the PCI standards committee slacked off on the PCI serial spec,
it is really weak for standards on devices like modems. the serial port is
a (Xircom MPCI 56) Toshiba internal PCI modem 56, a real modem like i
always thought would be supported by the serial driver, and yet sits unused
like the winmodems i was careful to avoid.

that's my dime-and-a-quarter.

Eric Shattow
radoni@crosswinds.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

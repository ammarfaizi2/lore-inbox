Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283451AbRK3BLo>; Thu, 29 Nov 2001 20:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283453AbRK3BLe>; Thu, 29 Nov 2001 20:11:34 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30137 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283451AbRK3BL0>; Thu, 29 Nov 2001 20:11:26 -0500
Date: Thu, 29 Nov 2001 18:11:21 -0700
Message-Id: <200111300111.fAU1BLR05033@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
In-Reply-To: <20011130015538.68b09e03.rene.rebe@gmx.net>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
	<200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
	<20011130012752.0fd5380a.rene.rebe@gmx.net>
	<200111300034.fAU0YB904723@vindaloo.ras.ucalgary.ca>
	<20011130015538.68b09e03.rene.rebe@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
> On Thu, 29 Nov 2001 17:34:11 -0700
> Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
> > Um, from your previous message, it seems that host numbering doesn't
> > change depending on BIOS settings.
> 
> It was the first storry - my older Athlon.

OK, so, just to be clear, BIOS settings are *not* changing host
numbering. IOW, "host1" always refers to the same piece of hardware,
whether or not "host1" appears in devfs.

> > So what exactly is happening? And what is the problem? I realise you
> > may find the naming a little confusing, but is there an actual
> > problem?
> 
> ok - again.
> 
> I have a K6 on an ALI Aladin-5 board and an additional IDE controller
> (Promisse). The onboard can be found as /dev/host0 and the additional
> Promisse one appears as /dev/host2:
> 
> server1:~ # l /dev/ide/
> total 0
> drwxr-xr-x   1 root     root            0 Jan  1  1970 .
> drwxr-xr-x   1 root     root            0 Jan  1  1970 ..
> drwxr-xr-x   1 root     root            0 Jan  1  1970 host0
> drwxr-xr-x   1 root     root            0 Jan  1  1970 host2
> 
> The boot messages:
[...]
> I works - but sucks, because I'm not able to predict the
> ide-controller entries in /dev/ide/* because they seem (for me)
> randomly on each workstaion I am ...

But it is actually predictable, isn't it? Think of it this way: the
IDE subsystem reserves "slots" (host numbers) for installed hardware.
If a piece of hardware is disabled in the BIOS, it doesn't mean that
the slot won't be reserved.

> (All info from my very first mail ...)
> 
> The other bug is: On a Athlon-600 workstation based on an Irongate
> board (Asus-K7M) I have to disable the first (primarry) channel of
> the onbaord IDE controller, because it has problem with the UDMA-66
> mode. But when I disable this channel, Linux generates a /dev/ide/host1
> entry - No host0 entry is there. Sure it works - but sucks, too!
> (Generates a very unstable feeling in me ...)

The "host0" entry isn't shown, because it is disabled. But to say
"when I disable this channel, Linux generates a /dev/ide/host1" isn't
correct, and implies a problem where there isn't. The correct way to
describe this is:
"host0" is my primary onboard IDE controller. It might not appear if I
disable it.
"host1" is my secondary onboard IDE controller. It has the same name
whether or not I disable the primary.

And this is a Feature[tm]. It means that tomorrow when a shiny new
drive arrives, you can plug it into your primary channel and enable
the channel in the BIOS. You can then boot without having to fix your
/etc/fstab, because /dev/ide/host1 is still pointing to the same
devices.

The only thing that confuses me is why the secondary onboard channel
is /dev/ide/host1 rather than /dev/ide/host0/bus1.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

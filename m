Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131799AbRATVCf>; Sat, 20 Jan 2001 16:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbRATVCZ>; Sat, 20 Jan 2001 16:02:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131799AbRATVCW>; Sat, 20 Jan 2001 16:02:22 -0500
Date: Sat, 20 Jan 2001 13:01:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <7uDh9tbHw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.10.10101201247330.10602-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 Jan 2001, Kai Henningsen wrote:
> 
> Then again, I could easily see those I/O devices go the general embedded  
> route, which in a decade or two could well mean they run some sort of  
> embedded Linux on the controller.
> 
> Which would make some features rather easy to implement.

I'm not worried about a certain class of features. I will predict, for
example, that disk subsystems etc will continue to get smarter, to the
point where most people will end up just buying a "file server" whenever
they buy a disk. THOSE kinds of features are the obvious ones when you
have devices that get smarter, and the kinds of features people are
willing to pay for.

The things I find really doubtful is that somebody would be so silly as to
make the low-level electrical protocol be anything but a simple direct
point-to-point link. Shared buses just do not scale, and they also have
some major problems with true high-performance GBps bandwidth. 

Look at where ethernet is today. Ten years ago most people used it as a
bus. These days almost everybody thinks of ethernet as point-to-point,
with switches and hubs to make it look nothing like the bus of yore. You
just don't connect multiple devices to one wire any more.

The advantage of direct point-to-point links is that it's a hell of a lot
faster, and it's also much easier to distribute - the links don't have to
be in lock-step any more etc. It's perfectly ok to have one really
high-performance link for devices that need it, and a few low-performance
links in the same system do not bog the fast one down.

But point-to-point also means that you don't get any real advantage from
doing things like device-to-device DMA. Because the links are
asynchronous, you need buffers in between them anyway, and there is no
bandwidth advantage of not going through the hub if the topology is a
pretty normal "star" kind of thing. And you _do_ want the star topology,
because in the end most of the bandwidth you want concentrated at the
point that uses it.

The exception to this will be when you hav esmart devices that
_internally_ also have the same kind of structure, and you have a RAID
device with multiple disks in a star around the raid controller. Then
you'll find the raid controller doing raid rebuilds etc without the data
ever coming off that "local star" - but this is not something that the OS
will even get involved in other than sending the raid controller the
command to start the rebuild. It's not a "device-device" transfer in that
bigger sense - it's internal to the raid unit.

Just wait. My crystal ball is infallible.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

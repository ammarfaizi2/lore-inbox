Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbREOVSI>; Tue, 15 May 2001 17:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbREOVR6>; Tue, 15 May 2001 17:17:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55052 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S261551AbREOVRm>; Tue, 15 May 2001 17:17:42 -0400
Message-ID: <3B019CB7.78A2C5EB@evision-ventures.com>
Date: Tue, 15 May 2001 23:16:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: Getting out of hand?
In-Reply-To: <Pine.LNX.4.21.0105142114310.23663-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 14 May 2001, Alan Cox wrote:
> >
> > Except that Linus wont hand out major numbers, which means I can't even boot
> > simply off such a device. I bet the vendors in question dont think the sun
> > shines out of linus backside any more.
> 
> Actually, it does. It's just that some people have gotten so blinded by my
> a** that they can no longer see it any more ;)
> 
> The problem I have is that there are lots of _good_ solutions, but they
> all imply a bit more work than the bad ones.
> 
> What does that result in? Everybody continues to use the simple old setup,
> which required no thought at all, but that is a pain to maintain.
> 
> For example, the only thing you need in order to boot is to have a nice
> clean "disk" major number. That's it. Nothing fancy, nothing more.
> 
> Look at what we have now:
> 
>  - ramdisk: major 1. Fair enough - ramdisk is special, in that it doesn't
>    have any "real hardware". No problem.
>  - SCSI disks:
>         major 8, 65-71,
>  - Compaq smart2:
>         major 72-79
>  - Compaq CISS:
>         major 104-111
>  - DASD;
>         major 94
>  - IDE:
>         major 3, 22, 33-34, 56-57, 88-91
> 
> and then the small random ones.
> 
> NONE of these major numbers have _any_ redeeming qualities except for the
> ramdisk. They should all be _one_ major number, namely "disk". There are
> absolutely NO advantages to having separate devices for soem strange
> compaq controllers and IDE disks. There is _no_ point in having some SCSI
> disks show up at major 8, while others (who just happen to be attached to
> a scsi bus that is not driven by the generic SCSI layer) show up at major
> 104 or whatever.

And then the IDE stuff is stiuoid to use the same major numbers for
in fact entierly different devices like CD-ROM and IDE disk drivers on
the same major... This makes it VERY uncomfortable to guarantee that
for example the sector size and driver read ahead are properties
tighted to the major number alone... In fact Linux is bundling 
read ahead with the major number only, in esp. inside the RAID drivers
which is entierly wrong! (see blksize_size array and read_ahead array).

And yes the RAID drivers are in particular *VERY* stiupid in
terms of major/minor number usage.

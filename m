Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbREOI02>; Tue, 15 May 2001 04:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbREOI0S>; Tue, 15 May 2001 04:26:18 -0400
Received: from aeon.tvd.be ([195.162.196.20]:8796 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S262679AbREOI0E>;
	Tue, 15 May 2001 04:26:04 -0400
Date: Tue, 15 May 2001 10:24:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: Getting out of hand?
In-Reply-To: <Pine.LNX.4.21.0105142114310.23663-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.05.10105151022470.15808-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Linus Torvalds wrote:
> On Mon, 14 May 2001, Alan Cox wrote:
> > Except that Linus wont hand out major numbers, which means I can't even boot
> > simply off such a device. I bet the vendors in question dont think the sun
> > shines out of linus backside any more.
> 
> For example, the only thing you need in order to boot is to have a nice
> clean "disk" major number. That's it. Nothing fancy, nothing more. 
> 
> Look at what we have now:
> 
>  - ramdisk: major 1. Fair enough - ramdisk is special, in that it doesn't
>    have any "real hardware". No problem.
>  - SCSI disks:
> 	major 8, 65-71,
>  - Compaq smart2:
> 	major 72-79
>  - Compaq CISS:
> 	major 104-111
>  - DASD;
> 	major 94
>  - IDE:
> 	major 3, 22, 33-34, 56-57, 88-91
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

    [...]

> How hard is it to generate a new "disk driver framework", and let people
> register themselves, kind of like the "misc" drivers do. Except we'd only
> allow DISKS. You could add something like
> 
> 	register_disk_driver("compaq-ciss", nr_disks, &my_queue);
> 
> and then the disk driver framework will select a range of minor numbers
> for the disks, and forward all requests that come to those minor numbers
> to "my_queue". No major numbers. No fixed minors. And the user sees _one_
> disk major, and doesn't care _what_ the hell is behind it.

Looks exactly like what we used to do for serial ports on the m68k platform...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


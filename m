Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316262AbSEKTJg>; Sat, 11 May 2002 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316263AbSEKTJf>; Sat, 11 May 2002 15:09:35 -0400
Received: from smtp3.wanadoo.nl ([194.134.35.186]:15850 "EHLO smtp3.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S316262AbSEKTJe>;
	Sat, 11 May 2002 15:09:34 -0400
Message-Id: <4.1.20020511205025.009703a0@pop.cablewanadoo.nl>
X-Mailer: QUALCOMM Windows Eudora Pro Version 4.1
Date: Sat, 11 May 2002 21:04:20 +0200
To: Dave Jones <davej@suse.de>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: Linux 2.5.14-dj2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br,
        andre@linux-ide.org, vojtech@suse.cz
In-Reply-To: <20020511191406.S5262@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:14 11-5-02 +0200, Dave Jones wrote:
> > found a few other problems:
> > 1) the pio fix posted last week is not included in your tree or Linus' and
>
>Erm. That went into my tree a while back, and a day or so later, into
>one of Martin's IDE-5x patches.  It also went into Linus' tree a while
>back. See changeset 1.513.1.14 at
>http://linus.bkbits.net:8080/linux-2.5/cset@1.513.1.14?nav=index.html

and still the patch I included applied to 2.5.14-dj2... 

> > I found this the hard way: severe filesystem damage and system lockup and a
> > kernel (2.4.19-pre8) panic because the root partition could not be mounted
> > (as reported before). 
>
>Ah, 2.4.19 would be Marcelo's world.

sorry for the misunderstanding, after the crash I booted into 2.4.19-pre8
to recover my system and that did not work because the 2.5.14-dj2 kernel
destroyed the first descriptors of my ext2-filesystem. It was not meant to
report the kernel panic but to show the severity of the problem that was
done by the 2.5.14-dj2 kernel...

> > The following patch fixes this, apllies with an offset of -2 lines:
> > -- begin patch --
> > --- linux-2.5.10/drivers/ide/ide-taskfile.c    Wed Apr 24 16:15:19 2002
> > +++ linux/drivers/ide/ide-taskfile.c  Fri Apr 26 15:44:42 2002
> > @@ -202,7 +202,7 @@
> >  			ata_write_slow(drive, buffer, wcount);
> >  		else
> >  #endif
> > - 			ata_write_16(drive, buffer, wcount<<1);
> > + 			ata_write_16(drive, buffer, wcount);
> >  	}
> >  }
>
>Yes, it does look like a variant of this patch is missing there too.
>Andre, Confirm?  Line 112 looks suspect back there. Or is 2.4 doing
>different voodoo with the wcount ?

So this patch applied to 2.5.14-dj2 and I did not try to apply it to a 2.4
tree... again sorry for the misunderstanding.

>
> > 2) After boot the system is not responsive to the keyboard, logging in via
> > ssh and doing a `insmod psmouse` followed by a `rmmod psmouse` results in a
> > working keyboard...
> > before and after insmod there is no interrupt 1 listed in /proc/interrupts,
> > but after doing the rmmod it is listed: "  1:         52          XT-PIC
> > i8042"
> > the mouse interrupt is listed as " 12:        154          XT-PIC  i8042"
> > the following message was issued after `rmmod psmouse`: "input: AT Set 2
> > keyboard on isa0060/serio0"
>
>Odd, That's one for Vojtech to think about 8-)

2.5.13-dj2 also had this problem, I can't remember if 2.5.13-dj1 had the
same problem.

>Thanks for the report.

No thanks, it's fun to play with these kernels (even to recover a heavily
damaged system :)

	Rudmer

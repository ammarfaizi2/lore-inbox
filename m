Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129217AbRBBNze>; Fri, 2 Feb 2001 08:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbRBBNzO>; Fri, 2 Feb 2001 08:55:14 -0500
Received: from www.topmail.de ([212.255.16.226]:25810 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129217AbRBBNzG> convert rfc822-to-8bit;
	Fri, 2 Feb 2001 08:55:06 -0500
Message-ID: <022901c08d1f$bf8a2c20$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>,
        "David Ford" <david@linux.com>
In-Reply-To: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca> <3A79F812.D52B17B1@linux.com>
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
Date: Fri, 2 Feb 2001 13:54:44 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "David Ford" <david@linux.com>
To: "Michael J. Dikkema" <mjd@moot.ca>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, February 01, 2001 11:58 PM
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)


> "Michael J. Dikkema" wrote:
> 
> > I went from 2.4.0 to 2.4.1 and was surprised that either the root
> > filesystem wasn't mounted, or it couldn't be read. I'm using devfs.. I'm
> > thinking there might have been a change with regards to the devfs
> > tree.. is the legacy /dev/hda1 still /dev/discs/disc0/part1?
> 
> This symlink doesn't exist/isn't usable for boot.  Use the qualified
> pathname.
> 
> I.e. /dev/discs/disc0/part1 points to /dev/ide/host0/bus0/target0/lun0/part1
> on my machine.
> 
> Use that pathname.
> 
> -d

I am used to do "root=0301" on the lilo prompt to avoid that.
Right it works when devfs is mounted at boot (kernel config)
and you change the lilo.conf from:

image=/boot/bzImage
 label=linux
 root=/dev/hda1
 vga=3845

to:

image=/boot/bzImage
 label=linux
 append="root=0301 vga=3845"

or:

image=/boot/bzImage
 label=linux
 append="root=/dev/ide/host0/bus0/target0/lun0/part1 vga=3845"

Maybe the append= thing shortly spoken of in the devfs docu is important.
And at boot time _there are no symlinks_ !!

When init=/bin/bash fails, you prolly have an empty /dev on your root fs
(as usual when doing devfs) and automount _off_. Turn it on.

-mirabilos

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12+(proprietary extensions) # Updated:20010129 nick=mirabilos
GO/S d@ s--: a--- C++ UL++++ P--- L++$(-^lang) E----(joe) W+(++) loc=.de
N? o K? w-(+$) O+>+++ M-- V- PS+++@ PE(--) Y+ PGP t+ 5? X+ R+ !tv(silly)
b++++* DI- D+ G(>++) e(^age) h! r(-) y--(!y+) /* lang=NASM;GW-BASIC;C */
------END GEEK CODE BLOCK------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

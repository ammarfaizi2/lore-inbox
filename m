Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbQLOP4z>; Fri, 15 Dec 2000 10:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLOP4p>; Fri, 15 Dec 2000 10:56:45 -0500
Received: from marjorie.loran.com ([209.167.240.3]:45577 "HELO
	marjorie.loran.com") by vger.kernel.org with SMTP
	id <S129697AbQLOP4d>; Fri, 15 Dec 2000 10:56:33 -0500
Message-ID: <01cf01c066ab$036fc030$890216ac@ottawa.loran.com>
From: "Dana Lacoste" <dana.lacoste@peregrine.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net> <20001215155741.B4830@ping.be>
Subject: Re: Linus's include file strategy redux
Date: Fri, 15 Dec 2000 10:23:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 15, 2000 at 12:14:04AM +0000, Miquel van Smoorenburg wrote:

> It's the version that's in cvs, I just did an cvs update.  It's
> been in it for ages.  If it's wrong, someone *please* correct it.

I think this is the important part.
This subject has come up quite a few times in the past
couple of weeks on the scyld (eepro/tulip) mailing lists.

Essentially, whatever solution is implemented MUST ensure :

1 - glibc will work properly (the headers in /usr/include/* don't
    change in an incompatible manner)

2 - programs that need to compile against the current kernel MUST
    be able to do so in a quasi-predictable manner.

Here's some suggestions (feel free to hack this to pieces, but please
don't let this fall to the side with everyone doing it differently!
we need consensus! :)

- /usr/include/[linux|asm] will be directories, not symlinks, and
  their content will be the headers that glibc was compiled against.

- /usr/include/kernel will be a symlink to the target kernel headers.
  i.e. /usr/src/linux/include for most of us.

This way, anything that needs to use the 'default' methods of accessing
these headers will be able to function as usual, and anyone who needs
to access the specific kernel headers can simply do -I/usr/include/kernel

I know that for my projects this is essentially what I do : I make sure that
all of my separate-from-kernel compiling that needs to be done that depends
on the kernel gets recompiled every time i change the kernel,
but I only change /usr/include/linux when I recompile glibc.

We really need a documented way to deal with this!
It's getting silly the number of questions that people ask!

--
Dana Lacoste
Linux Developer
Peregrine Systems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

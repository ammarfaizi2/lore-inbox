Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314872AbSEHTGk>; Wed, 8 May 2002 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314889AbSEHTGj>; Wed, 8 May 2002 15:06:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314872AbSEHTGi>; Wed, 8 May 2002 15:06:38 -0400
Date: Wed, 8 May 2002 12:06:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <3CD8FB08.1040004@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205081200340.5406-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 May 2002, Martin Dalecki wrote:
>
> I don't think that it's always the proper aproach for hardware
> portability to do it on the "micro operation" level. That's good
> for generics like inb outb. In the case of the ATA interface it's
> better to do it on the "functional" level above...

Amen.

Helleluja.

Listen to the man.

Please don't play games with "ide_outb()" etc, which cause 99% of the
architectures to have to make the 1:1 translation to just "outb()", and
which also makes it incredibly cumbersome to handle multiple _different_
controllers that just happen to use different schemes.

Instead, making the virtualization at a higher point means that you can
have _one_ set of common operations for traditional PCI/ATA controllers
(and that one set uses inx/outx/readx/writex), and then you have a few
others for the "strange" cases.

And done properly with per-controller (or drive - you may want to
virtualize at the drive level just because you could separate out
different kinds of drive accesses that way too) function pointers you can
then _mix_ access methods, without getting completely idiotic run-time
checks inside "ide_out()".

			Linus


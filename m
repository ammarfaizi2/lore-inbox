Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316252AbSEQOsV>; Fri, 17 May 2002 10:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316254AbSEQOsT>; Fri, 17 May 2002 10:48:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316252AbSEQOsS>; Fri, 17 May 2002 10:48:18 -0400
Date: Fri, 17 May 2002 10:48:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: Halil Demirezen <halild@bilmuh.ege.edu.tr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Just an offer
In-Reply-To: <20020517141928.GC6613@louise.pinerecords.com>
Message-ID: <Pine.LNX.3.95.1020517103006.143A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Tomas Szepe wrote:

> > The remaining problem is how one trips a reboot if the remote machine
> > doesn't come up correctly. That problem can be handled by temporarily
> > changing panic() to a hard reset.
> 
> Trouble is, this couldn't "detect" problems like unresolved symbols in
> ethernet drivers or a troublesome fix that makes init/mount malfunction
> and many more common issues that make you have to get in the car and
> drive off to reset the damn beast.

Where there is a will, there is a way. As others have reported, you
can have an old "always-on" machine at the remote site. You can have
LILO redirect kernel messages out the serial port to be viewed
from your always-on machine, you can reset the hung machine with an
opto-isolator driven off your always-on machine's parallel port, etc.

It you are really serious about doing remote updates, you can also
boot using initrd, and install a bunch of disk drivers until one
(or more) don't fail to install, install a bunch of ethernet drivers
until one (or more) don't fail to install, etc. This can all be
handled in the initrd boot-script. --And that boot-script can be
a full-fledged 'C' program that can do anything a root-priviliged
program can do, including mounting an alternate root file-system
(maybe a CDROM) if all else fails. You don't have to use the default
"run-off-the-end-of-the-script" initrd process. Any program that
you write to replace the ash.static/initrd script has complete
control of the machine.

Booting an initial RAM-Disk requires NO hardware drivers! The
thing got loaded by LILO, through the BIOS services, then a
transition to protected-mode, you don't need anything installed.
Your program or script can try all possible drivers, trying to
get a root file-system on-line. The same for a network card.

Anyway, once it boots and you can review what actually got installed
from the network, you can make a final initrd boot-script.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


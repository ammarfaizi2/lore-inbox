Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131175AbRCUEWu>; Tue, 20 Mar 2001 23:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRCUEWl>; Tue, 20 Mar 2001 23:22:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53440 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131175AbRCUEW1>;
	Tue, 20 Mar 2001 23:22:27 -0500
Message-ID: <3AB82C36.C807B787@mandrakesoft.com>
Date: Tue, 20 Mar 2001 23:21:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org,
        Will Newton <will@misconception.org.uk>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103171951340.440-100000@mikeg.weiden.de> <Pine.LNX.4.33.0103190015080.8534-100000@dogfox.localdomain> <20010318192221.A27150@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Mon, Mar 19, 2001 at 12:16:26AM +0000, Will Newton wrote:
> 
> > In /etc/modules.conf I have:
> >
> > options parport_pc irq=none
> >
> > but dmesg says:
> >
> > parport0: PC-style at 0x378 (0x778), irq 7, dma 3
> > [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> 
> Jeff, this is a bug with the Via code in parport_pc.c.  Basically, the
> problem is that the code that detects the Via doesn't know what
> parameters you passed.  I know about the problem, but I don't know the
> fix yet.

Will,
What are your parallel port settings in BIOS?
Do you have Plug-n-Play OS enabled in BIOS?

The current Via-specific parport_pc.c code forces on the best possible
parallel port modes the chip can handle.  In retrospect, what it should
be doing is reading the configuration BIOS has set up, and not touching
it.

I am not sure that I agree, however, that an "irq=none" on the kernel
cmd line should affect the operation of the Via code.  I would much
rather fix the Via code as I suggest above.

Time to look for and drag out the old Via laptop...  Oh well, I needed
to debug the Via audio code some more anyway. :)

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.

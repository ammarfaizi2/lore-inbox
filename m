Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbQLGRPF>; Thu, 7 Dec 2000 12:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130872AbQLGROz>; Thu, 7 Dec 2000 12:14:55 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:32262 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S130762AbQLGROs>; Thu, 7 Dec 2000 12:14:48 -0500
Date: Thu, 7 Dec 2000 11:44:55 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, Pete Zaitcev <zaitcev@metabyte.com>
Subject: Re: YMF PCI - thanks, glitches, patches (fwd)
In-Reply-To: <E1441FJ-0002QX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012071108220.23591-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan!

> > The Linux-sound list appears to be dead (I don't see my message in
> > http://www.kernelnotes.org/lnxlists/linux-sound/), so I'm sending to the
>
> sound-list@redhat.com is alive and well however.

You cannot imagine how frustrating it was to search for the archive.  I
couldn't find an up-to-date archive, and www.kernel.org keeps silence
about mailing lists. I cannot afford subscribing to every list just to
slightly polish support for my hardware.

> > Dec  5 18:08:16 fonzie kernel: ymfpci: ioctl cmd 0x5401
> > Dec  5 18:08:50 fonzie last message repeated 9 times
>
> Just debugging this is fine

Well, 0x5401 is TCGETS. Other sound drivers just ignore it. I believe the
drivers should only log the ioctls that are relevant to them (i.e.
sound-related ioctls for sound drivers) and are not implemented.

> > $ play spinout.wav
> > sox: Unable to set audio speed to 5512 (set to 8000)
>
> 8Khz is the lower limit right now the way the board is driven.

So, it's not just a matter of changing the constants under "case
SNDCTL_DSP_SPEED" in ymf_ioctl()? Actually, I hacked them to be
4000<rate<50000 and it worked fine, but I'll drop this part of my patch if
you believe it's unsafe.

Anyway, the problem with handing sox is solved by replacing all ENOTTY
with EINVAL in ymfpci.c. It has nothing to do with the lower frequency
limit. No other sound driver ever uses ENOTTY.

Regards,
Pavel Roskin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

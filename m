Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278636AbRJXQVF>; Wed, 24 Oct 2001 12:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278625AbRJXQUz>; Wed, 24 Oct 2001 12:20:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45835 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278603AbRJXQUo>; Wed, 24 Oct 2001 12:20:44 -0400
Date: Wed, 24 Oct 2001 09:19:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wO1x-0001Vt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110240915590.8049-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Alan Cox wrote:
>
> Assuming you want to synchronize the raid before suspend - a reasonably
> policy but not essential then you'd have to shut down the raid before
> sd, then sd would let the devices shut down which lets the controller
> shutdown

I will _refuse_ to have a kernel suspend that synchronizes the raid etc.
That would make suspend/resume potentially take a _loong_ time.

If you want to synchronize your raid thing, make the user-level thing that
triggers the suspend do it. Same goes for things like "sync network
filesystems" etc. This is not a kernel level issue, and the kernel
shouldn't even try to do it.

If somebody has pending stuff over NFS and suspends, and when it comes
back it's not on the network any more, that is 100% equivalent to removing
a PCMCIA network card while running. It's supposed to work - but if you
lose data that's YOUR problem, not the kernels.

		Linus


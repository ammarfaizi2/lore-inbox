Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSHQS1m>; Sat, 17 Aug 2002 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318128AbSHQS1m>; Sat, 17 Aug 2002 14:27:42 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:2267 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318124AbSHQS1k>; Sat, 17 Aug 2002 14:27:40 -0400
Message-Id: <5.1.0.14.2.20020817192217.02179a50@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 17 Aug 2002 19:30:52 +0100
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IDE?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020817181624.GM10730@lug-owl.de>
References: <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
 <Pine.GSO.4.21.0208162057550.14493-100000@weyl.math.psu.edu>
 <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:16 17/08/02, Jan-Benedict Glaw wrote:
>On Fri, 2002-08-16 18:35:29 -0700, Linus Torvalds <torvalds@transmeta.com>
>wrote in message <Pine.LNX.4.44.0208161822130.1674-100000@home.transmeta.com>:
> > On Fri, 16 Aug 2002, Alexander Viro wrote:
>
> >     - in particular, it would only bother with PCI (or better)
> >       controllers, and with UDMA-only setups.
>[...]
> > And then in five years, in Linux-3.2, we might finally just drop support
> > for the old IDE code with PIO etc. Inevitably some people will still use
>
>That's bad. Then, you're nailed to use old kernels without having
>possibilities of recent kernels only because you're working with eg. old
>Alphas, PCMCIA-IDE things or so? Bad, bad, badhorribly bad. Even it's
>sloooow, there'll always some need for PIO-only controller support...

I don't think it is possible to have DMA only drivers. On DMA 
failure/timeouts/whatever, the current DMA drivers always fall back to PIO 
mode and this is a good thing. Otherwise many transfers would simply fail. 
Dropping PIO mode fallback would mean a lot of IO errors. Any system put 
under stress will at some point fall back to PIO mode (at least judgjing 
from the limited number of systems I have) because it doesn't manage to do 
the DMA transfers in time. That was very visible during the period when 
Andre's new IDE core went into 2.5.something_early and it turned out that 
PIO was broken at that point. For example my VIA box was running just fine 
then in DMA mode but as soon as I put it under stress it blew up due to it 
falling out of DMA and the then broken PIO mode... And VIA686b is 
mainstream hardware...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


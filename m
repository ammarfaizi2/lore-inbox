Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135854AbRAMBLg>; Fri, 12 Jan 2001 20:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135712AbRAMBLR>; Fri, 12 Jan 2001 20:11:17 -0500
Received: from [216.184.166.130] ([216.184.166.130]:52282 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S135452AbRAMBLP>; Fri, 12 Jan 2001 20:11:15 -0500
Date: Fri, 12 Jan 2001 17:09:08 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101121649220.8097-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1010112165949.1292b-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Linus Torvalds wrote:

> Date: Fri, 12 Jan 2001 16:52:00 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: John Heil <kerndev@sc-software.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
>     linux-kernel@vger.kernel.org
> Subject: Re: ide.2.4.1-p3.01112001.patch
> 
> 
> 
> On Fri, 12 Jan 2001, John Heil wrote:
> 
> > On Sat, 13 Jan 2001, Alan Cox wrote:
> > 
> > > Date: Sat, 13 Jan 2001 00:25:28 +0000 (GMT)
> > > From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > > To: Linus Torvalds <torvalds@transmeta.com>
> > > Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
> > > Subject: Re: ide.2.4.1-p3.01112001.patch
> > > 
> > > > what the bug is, and whether there is some other work-around, and whether
> > > > it is 100% certain that it is just those two controllers (maybe the other
> > > > ones are buggy too, but the 2.2.x tests basically cured their symptoms too
> > > > and peopl ehaven't reported them because they are "fixed").
> > > 
> > > I've not seen reports on the later chips. If they had been buggy and then 
> > > fixed I'd have expected much unhappy ranting before the change
> > 
> > The "fix" was an hdparm command like hdparm -X66 -m16c1d1 /dev/hda.
> > Which I set for my VIA 686a on a Tyan mobo w a 1G Athlon.
> 
> Careful. It may be that your fix just avoids the corruption because the
> other changes make it ok - like the 16-sector multi-count thing maybe
> hides a problem that might still exist - it just changes the "normal"
> timing so that you won't ever see it in practice any more.
> 
> These kinds of magic interactions is why I'm not at all happy about driver
> changes until people really know what it was that caused it, and _know_
> that it's gone.
> 
> Anyway, for you the problem apparently happened even on a 686a, but just
> the 586 series. Correct?

Yes, initially the 686a was problematic, now with an 80 wire cable its
fine. 

One point of clarification... I started out with a simple hdparm -d1
which failed 85% of the time. I added the other stuff only to enhance the
-d0 state I was left with.

I then changed to the 80 wire cables and retried with only -d1 again, 
and to my surprise, the problems never came back and DMA stayed on.
A while later, I added -X66 and it too worked great. Then lastly came
the re-add of the rest giving current state.

> 
> 			Linus
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
kerndev@sc-software.com
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

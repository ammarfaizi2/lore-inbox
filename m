Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135712AbRAMBOQ>; Fri, 12 Jan 2001 20:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136107AbRAMBOG>; Fri, 12 Jan 2001 20:14:06 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:51466
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136106AbRAMBNx>; Fri, 12 Jan 2001 20:13:53 -0500
Date: Fri, 12 Jan 2001 17:12:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: John Heil <kerndev@sc-software.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101121649220.8097-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101121655010.2411-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Linus Torvalds wrote:

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
                                                         ^^
There no chipset calls that allow one to envoke 32-bit data access on the
data-taskfile register.  This may bite you in the arse! (see below)

> > Which I set for my VIA 686a on a Tyan mobo w a 1G Athlon.
> 
> Careful. It may be that your fix just avoids the corruption because the
> other changes make it ok - like the 16-sector multi-count thing maybe
> hides a problem that might still exist - it just changes the "normal"
> timing so that you won't ever see it in practice any more.

This is why it is better to do on paper the timings and not create code
that is varible based on the "ide-bus-clock" not the "pci-bus-clock".
You can only run timings at 33MHz clocking, period.  The exceptions are
for those that can report from the chipset that a clocking-base other than
33 is detected.

I told you that I have the new code that is scheduled for 2.5 certified on
analizers to be technically correct as it relates to the "state diagrams"
in the standard.

> These kinds of magic interactions is why I'm not at all happy about driver
> changes until people really know what it was that caused it, and _know_
> that it's gone.

Linus I know how the driver is to work and how it behaves in
non-multimodes, but I am not sure that even Mark Lord could tells you or
me about the true nature of the current multimode with various chipsets.

Sheesh some of them are now documenting that special bits must be set to
do 32-bit word access on the dataport.

Cheers,

Andre Hedrick
Linux ATA Development



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

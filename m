Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313557AbSDZHvi>; Fri, 26 Apr 2002 03:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313595AbSDZHvh>; Fri, 26 Apr 2002 03:51:37 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30735
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313557AbSDZHvh>; Fri, 26 Apr 2002 03:51:37 -0400
Date: Fri, 26 Apr 2002 00:35:55 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Bill Davidsen <davidsen@tmr.com>, Stephen Samuel <samuel@bcgreen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <20020426040457.GO574@matchmail.com>
Message-ID: <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Basically it is a global design flaw from the beginning, and since I have
only 2.4 to address it is a real nasty!  Short version, each subdriver
personally does not do unique error handling.  Thus a the simple good/bad
approach to a darwin world has come to bite hard now.  There is a failure
to address error/sense decoding based on the operations requested to
perform.  Second the mainloop is ATA/IDE centered for all events and this
is in proccess to be fixed for 2.4 soon.  Third requires all ATAPI to
decode wrt to primary opcode executed and sense of the preferred event
tables and not the generic catch all.

It is a blood mess, and difficult to describe over email :-/ (for me).

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS Mike, "Mr. Hedrick" was my genetic donor, "Andre" is what I answer too.

On Thu, 25 Apr 2002, Mike Fedyk wrote:

> On Wed, Apr 24, 2002 at 11:33:23PM -0400, Bill Davidsen wrote:
> > I suspect (without having a good way to check) that all IDE devices
> > sharing the IRQ with the error device *may* be affected. That's the only
> > thing which comes to mind, I'll add a Promise controller and disk on a
> > totally separate board and see if that changes anything. Hopefully it will
> > not share the IRQ :-(
> 
> I don't think it has to do with the IRQs, but it sounds like the entire ide
> chipset (think two cables one one chipset...) has stopped responding when
> ONE device (out of a possible four (with two cables)) has failed media.
> 
> Let's use an example to help shine the light on exactly what I'm saying (I'm
> trying to summarize what's been said in the threads, and I haven't tested
> this... though I will be working on such a system in the next few weeks):
> 
> 1)
> Two drives each on a seperate cable, but on the same chipset:
> /dev/hda (hard drive) (chipset1)
> /dev/hdc (cd-rom) (chipset1)
> 
> Put broken CD into /dev/hdc, and read somehow (dd, cat, whatever), now try
> to read from /dev/hda.  This (according to this thread) should be damn slow
> and you will have a very hard time to use this system while it is trying to
> read the CD.
> 
> 2)
> Two drives, each on a seperate cable and on different chipsets:
> /dev/hda (hard drive) (chipset1)
> /dev/hde (cd-rom) (chipset2)
> 
> Put broken CD into /dev/hde, read it again, and try to read from /dev/hda.
> All should be good, with blue skies, and a responsive system.
> 
> Can someone verify that the above is true, and acurately expresses
> what they've experienced?
> 
> Also, can someone say for sure (Andre) that this is a hardware limitation,
> not a Linux IDE locking problem, and with no possibility of a software
> work-around? 
> 
> Thanks,
> 
> Mike
> 


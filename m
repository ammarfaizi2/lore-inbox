Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130887AbRATXMs>; Sat, 20 Jan 2001 18:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRATXMi>; Sat, 20 Jan 2001 18:12:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56330 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130887AbRATXMU>; Sat, 20 Jan 2001 18:12:20 -0500
Message-ID: <3A6A1B40.459A1B7@transmeta.com>
Date: Sat, 20 Jan 2001 15:12:00 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Minors remaining in Major 10 ??
In-Reply-To: <Pine.LNX.4.10.10101201501290.657-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> On Sat, 20 Jan 2001, H. Peter Anvin wrote:
> 
> > Andre Hedrick wrote:
> > >
> > > HPA,
> > >
> > > Thoughts on granting all block subsystems a general access misc-char minor
> > > to do special service access that can not be down to a given device if it
> > > is open.  There are some things you can not do to a device if you are
> > > using its device-point to gain entry.  Also do the grab a neighboor and
> > > force the migration to find the desired major/minor is painful.
> > >
> >
> > Hmmm... this would be better done using a dedicated major (and then minor
> > = block major.)  This is something we can do in 2.5 once we have the
> > larger dev_t; at this point, I'd be really hesitant to allocate
> > additional that aren't obligatory.
> 
> Er, I did not make the point clear enough, drat.
> 
> mknod /dev/ide-service c 10 ???
> mknod /dev/scsi-service c 10 ???
> 
> These would be char devices that would allow one to pass a struct to an
> ioctl to do device or host services that normally have to attempted by
> opening the device desired.  This fails if you are trying to unload the
> driver (with KMOD enabled) so that you could switch devices or change
> driver types.  Yes this is the migration to a hotswap^H^H^H^H^H^H^H
> general host/device services calls.
> 

No, I think I understood perfectly well.  I said that if it's going to be
bound to each block device subsystem it would make more sense to
establish that tie explicitly -- if that isn't possible I'm a bit
confused.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

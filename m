Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292062AbSB0EtP>; Tue, 26 Feb 2002 23:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292079AbSB0Es4>; Tue, 26 Feb 2002 23:48:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13833
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292062AbSB0Esy>; Tue, 26 Feb 2002 23:48:54 -0500
Date: Tue, 26 Feb 2002 20:35:39 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Brett <brett@bad-sports.com>
cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5-dj1 - ide_set_handler/kernel timer <-- and now dj2 as well
In-Reply-To: <Pine.LNX.4.44.0202271352310.29386-100000@bad-sports.com>
Message-ID: <Pine.LNX.4.10.10202262020420.17728-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh this is the ATOMIC/ATOMIX problem I have been working on and may
finally crushed but at a price!  This issue is about FORCED PARTIAL
COMPLETIONS.  Basically, I have been restricted by a few policies in the
kernel which invokes ATOMIC Segements for the OS but screws the ATOMIC of
the hardware.

I will lay out the specifics why a patch that adopts portions of the
changes in 2.5.5 and backs out a few until a closer look can be taken.

This patch will include how, who, and why the global ATOMIC in 2.4 is a
problem, and the proper way to address the Hardware Segment of the
transfer.  The effect until it is fixed is a FUBAR of you data if and only
if you have an error condition.

As for the PANIC, I spent 10 hours last night from 7pm to 5am this past
morning hunting to kill it, and success.

For now I suggest you move your laptop back to a 2.4 kernel because,
regardless if multmode works in the patch to be submitted.  GAWD forbid
you tank an error, and this is not a joke, it is not a bluff.

I am DAMN serious about this data issue.

I bitched about and never had a solution, but now I do have the outline
for a solution and it is dynamic enough to assist all the legacy hardware
that was rudely unsupported, IIRC during the transistion in 2.5.

IMHO, we have shorted BLOCK and the HARDWARE over on policy force upon the
lot.  It is the beloved "partial completion update".  I will state it can
be accomplished but it shall protect and preserve the granularity of the
hardware segment over the top layer rules above BLOCK.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Wed, 27 Feb 2002, Brett wrote:

> 
> Hey,
> 
> Subject says it all... still getting these
> Oh, and the kernel just panicked.
> 
> Traded some emails with andre about this last time,
> and he was unable to get it to stop.
> 
> any ideas ?
> 
> 	/ Brett
> 
> On Fri, 22 Feb 2002, Dave Jones wrote:
> 
> > On Fri, 22 Feb 2002, Brett wrote:
> > 
> > > This just popped up a few minutes after boot:
> > > hda: ide_set_handler: handler not null; old=c01c4d30, new=c01c4d30
> > > bug: kernel timer added twice at c01c6197.
> > 
> > Argh, I thought things would be less problematic by dropping
> > those ide changes.   Looks like I missed something.
> > I'll take a look in the morning.
> > 
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


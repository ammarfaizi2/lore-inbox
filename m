Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289051AbSAUFuA>; Mon, 21 Jan 2002 00:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289053AbSAUFr2>; Mon, 21 Jan 2002 00:47:28 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289054AbSAUFqz>; Mon, 21 Jan 2002 00:46:55 -0500
Date: Sat, 19 Jan 2002 18:05:00 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Rob Radez <rob@osinvestor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Andre's IDE Patch (1/7)
In-Reply-To: <5.1.0.14.2.20020120011709.027c46e0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10201191756360.9354-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton is correct, his the first person to ever sit down and do a peer
review of the code otherwise it would have been found earlier.
The code is correct, but how it interfaces to the kernel is dead wrong,
with the exclusion of DMA.

Data should not be damaged, since a simple pio mount would deadlock cold,
or even faster earlier deadlock would happen durning partition checking,
long before.

The full disclosure is one line was stubbed out/ changed to an undef,
thus disk io was not running PIO taskfile, a simple one line change made
things appear one way and not as reality suggested.

For the most part, the patch cleans up all the other automatic services.
This stablized some minor issues but to specifics are not fully chased and
documented.

It comes down to one thing, I got to deep in the hardware to make it run
perfect and clean and forgot how to make it interface to the kernel.

Regards,

On Sun, 20 Jan 2002, Anton Altaparmakov wrote:

> I think I know what Andre is referring to (Andre please correct me if I am 
> wrong) and if I am correct than you are still safe to use the currently 
> existing big patch (as long as you do NOT tamper with it in any way - I 
> mean that, a one line change is sufficient to destroy your data). If you 
> split it up, there is a _very_ high chance broken code will be executed 
> which will destroy your data on first time a PIO transfer occurs...
> 
> Best regards,
> 
> Anton
> 
> At 00:58 20/01/02, Rob Radez wrote:
> >On Sat, 19 Jan 2002, Andre Hedrick wrote:
> > > Please don't do that.  There is a fatal flaw in those patches we all
> > > observed in 2.5.3pre1.  I have 2.4.16 as a possible candidate and
> > > auto-patching for 2.4.17 at the moment.
> >
> >On Wed, 16 Jan 2002, Andre Hedrick wrote:
> > > If the driver falls out of DMA, DEADBOX!!!!
> > > There is a conflict of BIO and ACB and it is very fatal.
> >
> >It was my impression that the problem with 2.5.3-pre1 was a complication
> >that existed only because of bio in 2.5.  Oops.  I assume this means then
> >that all of us running your ide.2.4.16.12102001.patch should immediately
> >revert so Bad Things don't happen?
> 
> 
> 
> 
> -- 
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


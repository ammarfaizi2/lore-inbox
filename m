Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSHaGVR>; Sat, 31 Aug 2002 02:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSHaGVR>; Sat, 31 Aug 2002 02:21:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29188
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316289AbSHaGVQ>; Sat, 31 Aug 2002 02:21:16 -0400
Date: Fri, 30 Aug 2002 23:24:38 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Isely <isely@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.44.0208310100190.23964-100000@grace.speakeasy.net>
Message-ID: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2002, Mike Isely wrote:

> On Fri, 30 Aug 2002, Andre Hedrick wrote:
> 
> > 
> > Your data is not trashed.
> 
> Well actually it was.  After the driver read bad data from the disk 
> (presumably mis-addressed) my knee-jerk reaction was to run e2fsk -y to 
> "fix" it.  And _that_ trashed the data.

Okay that sounds more like it.  The driver did not damage the data, only
user space forced down the driver trashed it.  Regardless of the
definition of "is" you system was wrecked.

> 
> > Linux failed to understand cut off partitions.
> 
> ???

This was a great concern of mine when 48-bit was introduced.

> 
> > When you said you put it on primary channel, I realized that you have a
> > system that breaks the rules of Promise and I am not sure.
> 
> What are the "rules of Promise" or where may I find such information?

You do not want to sign the NDA's to get the data sheets, aquire all the
hardware to test, generate tables of irregularities, query Promise, and
then scratch your head why.

I have a FastTrak 100 TX4 the BIOS fails to see beyond 128GB, but in
practice it does.

The PDC20267 will puke in 48-bit DMA, but run clean in 48-bit PIO :-/
Oh but that is the primary channel, Seconday Channel is clean both ways :-\

PDC20262 works in 48-bit DMA every where.

PDC20265 similar to PDC20267 except yours.

Rules are emperical tests and rants back at the OEM, and ....

> 
> > This will make it more painful to parse systems which can 48-bit and those
> > which can not.
> > 
> > This is not going to be fun.
> 
> But this wasn't a problem in 2.4.19-ac4; what confounding factor now is 
> making it difficult?

Cause there were reports of PDC20265/PDC20267 comming in as deadlocking.
Thanks for the wrinkle in the fabric of ruleless world. :-)

> > 
> > grep "hwif->addressing" pdc202xx.c
> > 
> > Stub out the three lines.
> > 
> > Recompile and reboot, it will be fixed
> 
> Will do.  Thanks.  If you have a more permanent fix you'd like me to 
> test, let me know.

Oh another dang piece of the puzzle found and it does not fit anywhere!

Cheers,

Andre Hedrick
LAD Storage Consulting Group


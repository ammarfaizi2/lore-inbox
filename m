Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUAWCag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 21:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUAWCa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 21:30:28 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17425
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265215AbUAWCaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 21:30:15 -0500
Date: Thu, 22 Jan 2004 18:27:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: Re: HPT372 DMA corruption
In-Reply-To: <yw1xu12z9yyq.fsf@kth.se>
Message-ID: <Pine.LNX.4.10.10401221821170.9012-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It has NOTHING to do with VIA!

It has everything to do with a missing function th hpt366.c code.

It is all about what the FIFO thresholds are wrt to when interrupts are
issued and a pre-emptive like notification.

I am waiting on one of my customers report they are happy with the fix and
will ship the fix before I release it to the public.  I have this serious
problem on not testing volitale patches on the general masses.

In my opinion, after several weeks of hard-on testing, the changes are
clean, correct, and exact.

Noting this type of patch would not be doable, had I not split the
individual dma operations way back when.

And yes for the remainder of the peanut gallery, I will "SHUT UP" for now.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 14 Jan 2004, Måns Rullgård wrote:

> Chuck Berg <chuck@encinc.com> writes:
> 
> > On Fri, Jan 09, 2004 at 03:24:28PM -0500, Richard B. Johnson wrote:
> > [cmp -l bad good]
> >> >  89260029   0  31
> >> >  89260030   0 327
> >> >  89260031   0 200
> >> >  89260032   0  13
> >> 
> >> Since whole bytes are not written, this looks strangely like
> >> an attempt to DMA to cached RAM! Since the CPU didn't write
> >
> > I tested this by reading with O_DIRECT, and immediately after each read(),
> > read all of a 1MB array (my cache is only 256kB), and then checking the
> > data. The same corruption occurs. 
> >
> > Via had a DMA corruption bug a couple years ago with similar symptoms,
> > apparently with the VT82C686B southbridge. Mine is a VT82C586B (which some
> > people also reported problems with). My board dates long after these
> > problems were discovered, so I sure hope it's not the same bug. I'll try
> > upgrading my BIOS to the latest version in case Soyo's changelog is not
> > entirely honest.
> 
> Well, VIA never did have a good reputation.
> 
> > I did learn some more about the pattern of corruption. The data is not
> > being written to memory - the "bad" data is whatever happened to be there
> > before. It usually happens in 4, but sometimes 64 or 32 byte chunks.
> 
> Is it always a multiple of 4 bytes?  Is there any pattern in the
> position of the corruption, such as always aligned to some value?
> 
> > When I read from the device with O_DIRECT, the corruption only
> > appears at the very end of the read. I've confirmed this for reads
> > of 512 bytes through 256k at multiples of 512 bytes.
> 
> Could something be cutting off the DMA transfer too early?
> 
> -- 
> Måns Rullgård
> mru@kth.se
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


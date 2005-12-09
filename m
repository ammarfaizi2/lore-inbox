Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVLINWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVLINWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 08:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbVLINWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 08:22:34 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:26612 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751325AbVLINWd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 08:22:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PJ6AOzNbaY4WJAPHhhYCWIs/L/HtKQrGweHVUjaPp3Q0ilQqgFdvlLrIqX3BC9x5RydEXyBJDDfq+/7MvMWh+015a0JQH/OWeuN6jsZ+6CDQwTzvAZTv+5y2x10op5/fvD63MFHdd1TSRZDd5j7rSJTK1x7s6AcmDI3e2e/aTwU=
Message-ID: <58cb370e0512090522h1e6a2c94r45ed652fd3a30da3@mail.gmail.com>
Date: Fri, 9 Dec 2005 14:22:31 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Cc: Jens Axboe <axboe@suse.de>, Erik Slagter <erik@slagter.name>,
       Jeff Garzik <jgarzik@pobox.com>,
       Randy Dunlap <randy_d_dunlap@linux.intel.com>, hch@infradead.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <20051209115511.GA25842@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051208134438.GA13507@infradead.org> <43989B00.5040503@pobox.com>
	 <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com>
	 <1134121522.27633.7.camel@localhost.localdomain>
	 <20051209103937.GE26185@suse.de>
	 <1134125145.27633.32.camel@localhost.localdomain>
	 <43996A26.8060700@pobox.com>
	 <1134128127.27633.39.camel@localhost.localdomain>
	 <20051209114641.GH26185@suse.de>
	 <20051209115511.GA25842@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, Dec 09, 2005 at 12:46:42PM +0100, Jens Axboe wrote:
> > On Fri, Dec 09 2005, Erik Slagter wrote:
> > > I case this (still) isn't clear, I am addressing the attitude of "It's
> > > ACPI so it's not going to be used, period".
> >
> > The problem seems to be that you are misunderstanding the 'attitude',
> > which was mainly based on the initial patch sent out which stuffs acpi
> > directly in everywhere. That seems to be a good trigger for curt/direct
> > replies.
>
> I was just following the example set by the ide acpi suspend/resume
> patch, which people didn't seem to object to nearly as much. I guess
> IDE's such a hack anyway that people aren't as worried :) I'll try
> produce a patch that just inserts platform-independent code into scsi
> around the start of next week.

Sigh, it seems this is what you get for being nice... ;)

Don't get it wrong IDE people (at least me) are also worried but
they know that there are cases in which ACPI support will help
(even if the main method should be talking to hardware directly)
NOW not in X years when we will have proper, architecture
independent suspend/resume handling (we can live with
"ide_acpi=on" kernel parameter before it happens happily).

I also pointed out that I would like to have generic code which
can be shared between libata and IDE drivers (after all both
can provide you with struct pci_dev * and port/device number).

It would be even better if this code will stay in drivers/acpi/ata.c
(?) and libata/IDE will just use the same functions (which will turn
to NOP if CONFIG_ACPI=n) for PATA.

Thanks,
Bartlomiej

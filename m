Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVIKJix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVIKJix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVIKJix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 05:38:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4803 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964840AbVIKJiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 05:38:52 -0400
Date: Sun, 11 Sep 2005 10:38:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luben Tuikov <ltuikov@yahoo.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
Message-ID: <20050911093847.GA5429@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 09:12:18PM -0700, Luben Tuikov wrote:
> > You can't do something like this and be generic.  You intercept all of
> > the slave_* calls and try to provide the template.
> 
> I don't intecept them.
> 
> A SAS LLDD doesn't implement them.  It implements Execute Command SCSI RPC,
> and a bunch of TMFs.

It should, though.  the scsi_host_template is absolutely meant to be set
in the LLDD.  Take a look at libata which uses pretty much only library
routines as methods in the scsi_host_template but let's the low-level
driver supply it anyway.

> No self respecting SAS chip would not do 64 bit DMA, or have an sg tablesize
> or any other limitation.

Famous last words..

> (Oh, I know, the solution you're paid to push into the kernel
> doesn't need those since it does all SAS in the firmware.)

James isn't paid by anyone to do scsi work.

> > There's already an embryonic SAS class working its way through the SCSI
> > list.  Could you look at enhancing that instead of trying to produce a
> > competing class?
> 
> Hmm, lets see:
> I posted today, a _complete_ solution, 1000 years ahead of this
> "embryonic SAS class" you speak of.

They're actually serving different needs.  The host-bases SAS code you
wrote should be layering below my SAS transport class.

> This complete solution was written of the actual SCSI specs,

Just because I can still talk like a normal human without resorting
to techno-babble all the time I still have read the important t10.org
specs.

> While this "embryonic SAS class" doesn't implement _any_ of that.
> It is vastly incomplete, and _most of all_ it doesn't adhere to the spec,
> because, again, the firmware of the controller you're writing this
> against, hides all SAS from the driver.

What SPEC do you think a representation of SAS domains in the linux driver
model just adhere to?

>    After "emd", Dell (Hi Matt!) learned quickly that if they want something
> in SCSI Core, they have to hire the people who _make_the_decisions_ what

s/_make_the_decisions_/listen to what the folks that make decisions tell them/

> So as long as *you are on their payroll*, what are you discussing here
> with me?  *You have an agenda*!  You are not seeking the right
> solution, you're seeking the agenda that you're being paid to follow.

As far as I know the only payroll James is on is Steeleye Technologies,
a clustering company.

> Furthermore, LSI's SAS controller, which Dell is using, does
> *not* export _anything_ SAS to SCSI Core.  This is the whole point
> of MPT (their licensed technology) -- to hide the transport
> in the firmware and export only pure SCSI LUs to the kernel, so that
> _one_ driver can work with multiple transports which the firmware
> is implementing and hiding from the driver (at least this was the inital
> thought).  For this reason  their driver should've been included into
> the kernel from the get go, but you created some work for yourself.

Oh, always nice to hear from someone that the driver for the technology
competing to their employers' product shouldn't be included..

There will be more SAS LLDDs that either do more things in firmware like
LSI Fusion and ones that do things in the Host like the Adaptec one.  And
we need to support both.  The best way to do that is to have a small top
layer that just unifies the SAS domain presentation, and a 'libsas' layer
below it for host-bases SAS implementations.

> I long for the days of the previous maintainer.  Had it not been
> for him and Andi, we may have never had scsi commands from a slab,
> scsi_done queue, done_q softirq processing, scsi timer hook, etc.
> Of course back then Splentec wasn't your payrol company, but there
> was some common sense present in linux-scsi.

Could you please stop this bullshit spreading now, thanks?

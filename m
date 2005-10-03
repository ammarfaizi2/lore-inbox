Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVJCP1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVJCP1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVJCP1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:27:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:62941 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932285AbVJCP12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:27:28 -0400
Message-ID: <43414DDE.4050804@adaptec.com>
Date: Mon, 03 Oct 2005 11:27:26 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       Patrick Mansfield <patmans@us.ibm.com>, ltuikov@yahoo.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>	 <433D8542.1010601@adaptec.com> <1128113158.12267.29.camel@mulgrave> <433DB6BE.4020706@adaptec.com> <433DDA8F.6050203@pobox.com>
In-Reply-To: <433DDA8F.6050203@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 15:27:26.0831 (UTC) FILETIME=[F5D44FF0:01C5C82E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 20:38, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>I'm sure you'll do whatever humanly possible to show
>>that _your_ idea can be applied: you can do this now:
>>just use a big if () { ... } else { ... } statement and
>>you're done.
> 
> 
> This is not how we do things in Linux.  You're doubling the maintenance 
> burden.

No necessarily.  See below.

> If you really want to do this, at least don't fill up drivers/scsi/ with 
> an additional, completely unrelated codepath.

How do you say it is unrelated?

Is USB storage unrelated? (other than the fact that it doesn't live
in drivers/scsi/)

> There is commonality between aic94xx and MPT/LSI stuff.  aic94xx SAS 
> transport layer is a superset of MPT/LSI SAS transport:  it clearly 
> needs far more management code.

And MPT/LSI SAS does not need this managament as this layer
is completely implemented in FW and not exposed (and for a reason).

> We understand this.  The part you don't understand is that we want to 
> emphasize the commonality, rather than let aic94xx and MPT/LSI go in 
> completely different directions.

But this was LSI's decision, remember?  We did work together,
until LSI and Dell decided that they'd rather let Christoph do it.
(Since who cares about the technological merit of the code when it
will be accepted into the kernel?)

Now you want to integrate the two?  Apparently LSI and Dell haven't
made up their mind.

As I said: Vendors are completely playing to the tune of a couple
of people at linux-scsi, for this reason we haven't seen _any_
SCSI or Storage _innovation_ in SCSI Core.

As opposed to those vendors saying: We _really_ need 64 bit LUNS
and it would be really nice to get rid of HCIL, etc, etc.

If all vendors pushed for that and were not afraid to speak
up (because they have drivers to write and patches to submit
and want acceptance), then SCSI Core would be a better place.

IMO, 64 bit LUNs and no HCIL is more important than "transport
attributes" and should've _preceded_ them.

The fact that you're trying to umbrella them together, doesn't
make it _technologically_ correct.

Remember, a person's fall starts when they're surrounded by "Yes" men.

> Read it again:  aic94xx/BCMxxx is a superset of functionality, not 
> completely different.

One implements all transport related tasks in FW and exposes only LUs
to the LLDD, the other implements only the interface to the transport
in the chip (the interconnect), and the rest is handed to upper layers.

If you sit down with a clean sheet of _paper and a pencil_ and try
to draw out the layering infrastructure for both and how they
interface with SCSI Core, you'll see that with MPT, things are
_upside_ down compared to USB/SBP/SAS.  Now trying to reconcile both,
while possible, would be extremely _ugly_, unless say, you can fake out
event formation in an MPT based LLDD, but then again, you'd need to
resolve the host template thing...

It would just be extremely ugly and not as flowing and straightforward
as the current code is.

	Luben


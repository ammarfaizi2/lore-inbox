Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVI0PBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVI0PBu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVI0PBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:01:50 -0400
Received: from magic.adaptec.com ([216.52.22.17]:28112 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S964965AbVI0PBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:01:49 -0400
Message-ID: <43395ED0.6070504@adaptec.com>
Date: Tue, 27 Sep 2005 11:01:36 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <4339440C.6090107@adaptec.com> <20050927131959.GA30329@infradead.org>
In-Reply-To: <20050927131959.GA30329@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 15:01:45.0812 (UTC) FILETIME=[60D4F940:01C5C374]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/05 09:19, Christoph Hellwig wrote:
> On Tue, Sep 27, 2005 at 09:07:24AM -0400, Luben Tuikov wrote:
> 
>>P.S. This is a second resend of an identical message
>>I posted to lkml and lsml yesterday.
> 
> 
> And it's not gotten anymore includable.  Please fix the major structural

Major?

Christoph, why diseminate FUD, when we can concentrate on the
_technical_ merits of SCSI and SAS instead?

Why talk non-constructive things, when we can have a SCSI Storage
discussion?

> issues pointed out when you first sent it out.  That's in the following
> order:
> 
>  - not trying to integrate with the sas transport class in Linus'

Well here we go _again_:

The SAS Transport Class (your an JB's incarnation) is _not_
a management infrastructure, it was _never_ _intended_ to be.

The whole point of it is to _export_ *attributes* of MPT-technology
like drivers.  All those drivers that it caters to _do_ _not_ need a
_management_ layer (Discovery, Expander configuration, etc.).
They "export" SCSI LUs directly to SCSI Core through their LLDDs.

If you cared to read any of the "techno-babble" (as you call it)
documents and specs you'd clearly see how and _why_ it fits
with a SCSI Stack.  As baby food, see this _picture_:
http://www.t10.org/scsi-3.gif
For an adult meal, maybe some reading of "techno-babble"
would help?

>    tree at all, not even using the transport class infrastructure
>    at all, creating it's own sysfs trees in rather wierd ways

"weird ways" ?  Did you care to see what a SAS domain looks like?
There is plenty of references, slides, course notes, etc on the
Internet.

Christoph, I work with this technology every day.  OTOH, you
blocked LSI's drivers from going in until they sent you hardware
just a month ago.

What you see in sysfs is _exactly_ what you'd see in the _physical_
world, _including_ the "locking" -- i.e. the "kobject_get".  It "locks"
object which are needed for the command to travel to, in _actuallity_.

If you say that it is "weird" then you are also saying that
a SAS Domain in the *physical* world is weird.

It is the _natural_ representation of the SAS domain.

What seems "weird" to you, is what it _actually_ is.

This is what this new technology is.  You can learn it
or you can call it "weird" and "techno-babble", and invent
your own understanding of SAS and shove it down the throat
of thousands of Linux users and vendors.

>  - not beeing structures as a library (ala libata which is a very good
>    model for it)

It _cannot_ be presented as a library, because _again_ it is a
*management layer*, an infrastructure.

What it manages is, _again_ to repeat myself, SAS objects:
ports, connections, devices, discovery, expander management, etc.

See the original Announcement 0 here, it explains this in detail:
http://marc.theaimsgroup.com/?l=linux-scsi&m=112629423714248&w=2

>  - duplicating the lun scanning code instead of using the scsi core one

The LUN scanning code is, uum, how to say this nicely... wrong?
It did its job for Parallel SCSI and for broken arrays who do not
respond to REPORT LUNS, but have a bunch of disks behind, but it is
wrong _by design_ and it is _not_ _relevant_ in SAS.  To properly see
how LUN scanning is done, look at sas_discover.c.

SCSI Core does not know about everyday SCSI objects like a "SCSI
Device with a Target port". It does things backwarads _and_ foremost
of all, it uses _HCIL_.

What needs fixing is, SCSI Core to
	- not use HCIL,
	- use 64 bit LUNs,
	- know about SCSI devices with Target ports,
	- proper representation of SCSI Domains
          (FC, USB, IEEE 1394, Infiniband, SAS, iSCSI)

Christoph, SCSI Core is 20 years behind.

I appreciate your aggresiveness and JB's political games,
but what it comes down to, Linux SCSI, vendors, users, and
its _other_ developers suffer.

Anyway, when all you have is an AIC-94xx or BCM8603 chip on your
mainboard (check with SuperMicro) you *do not need* the semantically
fat, broken and wrong SCSI Core (catering to old, outdated, broken
SPI machines).

You need a _minimal_ SCSI Core, SAM/SPC-like, when you have a new
technology like SAS and _none_ of the semantically fat and broken
SCSI Core is _relevant_ in a SAS world.

Christoph how long are you and James Bottomley going to hold
SCSI Core _hostage_ to new technologies?

How long are you going to _block_ SCSI storage innovation
from the Linux kernel?

Or is this the new way of embezzling hardware from vendors?
Is this what is done in the other Linux kernel subsystems?

I don't get it.  If you or James Bottomley think that
	- LUNS can be represented as "u64", and
	- sending REQUEST SENSE clears ACA,
	- "SCSI Device with Target port" is "techno-babble",
how can you drive new SCSI technology?

Someone please pinch me, because I'm dreaming this horrible
nightmare.

	Luben


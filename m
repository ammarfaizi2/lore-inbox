Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbVIJCpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbVIJCpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbVIJCpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:45:07 -0400
Received: from web51613.mail.yahoo.com ([68.142.224.86]:43936 "HELO
	web51613.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751020AbVIJCpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:45:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wsW9AVs0EJQQTnQnNadKB89T3R/aQ7ljbj/8GFZFXhn5qJVo8NTRb1EVHe5k39IDvvvBj832HrYy+YnaL0ZlZi1NGvavDfNhoB8LCXuRuD/WmhZM8OXBDjiHnjCuz9v0l+/6QOqUlTwQwCuk10NSIKXqaM68n8/loisUlY7xfy4=  ;
Message-ID: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
Date: Fri, 9 Sep 2005 19:44:54 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1126308304.4799.45.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Fri, 2005-09-09 at 15:40 -0400, Luben Tuikov wrote:
> > +/**
> > + * sas_do_lu_discovery -- Discover LUs of a SCSI device
> > + * @dev: pointer to a domain device of interest
> 
> Aside from all the other problems,

"Aside from all the other problems"?

WTF?

This is very rude James.  You have to _specific_ as opposed to
spreading FUD like this.

> this one completely duplicates the
> mid-layer infrastructure for handling devices with Logical Units.

No, it does *not*.  James, you have _stop_ spreading FUD, relying
that other people have not read the SCSI Core code.

See here:
    SCSI Core has *no representation* of a SCSI Device with a
SCSI Target Port.

I've _clearly_ outlined that in the comments of the code,
which you _conveniently_ did _not_ cut and paste here.

I've been asking for a generic SCSI Target representation for
the last 5 years, which you conventiently skip to mention.
Or shall we search linux-scsi archives?

As to duplication: NOT!

Why?

Look at scsi_scan_target() declaration:

void scsi_scan_target(struct device *parent, unsigned int channel,
		      unsigned int id, unsigned int lun, int rescan);

Channel, id, lun, rescan?  WTF?

Do you see any of this in the proprely implemented LU discovery
code in the SAS discovery code I submitted?

> > + * Discover logical units present in the SCSI device.  I'd like this
> > + * to be moved to SCSI Core, but SCSI Core has no concept of a "SCSI
> > + * device with a SCSI Target port".  A SCSI device with a SCSI Target
> > + * port is a device which the _transport_ found, but other than that,
> > + * the transport has little or _no_ knowledge about the device.
> > + * Ideally, a LLDD would register a "SCSI device with a SCSI Target
> > + * port" with SCSI Core and then SCSI Core would do LU discovery of
> > + * that device.
> 
> That would be what scsi_scan_target() actually does.

No, it does *not* do that.

STOP SPREADING FUD!

Let everyone take a look at scsi_scan_target() -- it fails in its
interface.  It has no concept of "SCSI device with Target port".

I asked for pure SCSI device with Target port implementation of
scsi_target and _you_ rejected it about 4 years ago.  Shall I search
for this message in the linux-scsi archives?

> > + * REPORT LUNS is mandatory.  If a device doesn't support it,
> > + * it is broken and you should return it.  Nevertheless, we
> > + * assume (optimistically) that the link hasn't been severed and
> > + * that maybe we can get to the device anyhow.
> 
> That's a surprisingly optimistic statement from someone who claims to
> have worked in SCSI for so long.  We have a huge list of heuristics for

Ouch!  Getting into the personal arena now, are we?

James, how old are the blacklisted devices you talk of?

How old are SAS devices? 

> devices that violate the standards in one way or another.  We already
> have a flag for a SCSI3 device that doesn't respond correctly to
> REPORT_LUNS ... and we have a few other reports of potentially more
> suspect devices.

Are those devices SAS?

Again, stop spreading FUD and talking as you know what you're talking about.

"few other reports of potentially more suspect devices" -- is such
a broad and vague statement that it isn't worth much.

First are those SAS devices.

Second, SAS devices being very recent have their firmware written
to latest specs, and advertised as SPC-3 and SAM-3.

> Now, if you did this properly and used the mid-layer infrastructure you
> wouldn't have to worry about any of this.
> 
> > +static int sas_do_lu_discovery(struct domain_device *dev)
> 
> Please just handle targets ... scanning beyond targets is best handled
> in generic code.

I agree.

But that generic code you talk about is complete *crap* and needs
rewriting.  When that generic code, can handle "SCSI device with
a Target port" then I'd love to off load that to SCSI Core.

In fact initially I _really_ tried to offload that to SCSI Core,
but it didn't quite work, then I wrote LU discovery.  Just run it on
real hardware.

    Luben


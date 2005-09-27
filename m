Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVI0PyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVI0PyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVI0PyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:54:20 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:64154 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964990AbVI0PyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:54:19 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <43395ED0.6070504@adaptec.com>
References: <4339440C.6090107@adaptec.com>
	 <20050927131959.GA30329@infradead.org>  <43395ED0.6070504@adaptec.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 10:53:00 -0500
Message-Id: <1127836380.4814.36.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 11:01 -0400, Luben Tuikov wrote:
> On 09/27/05 09:19, Christoph Hellwig wrote:
> > On Tue, Sep 27, 2005 at 09:07:24AM -0400, Luben Tuikov wrote:
> > 
> >>P.S. This is a second resend of an identical message
> >>I posted to lkml and lsml yesterday.
> > 
> > 
> > And it's not gotten anymore includable.  Please fix the major structural
> Christoph, why diseminate FUD, when we can concentrate on the
> _technical_ merits of SCSI and SAS instead?

That's what *we* are concentrating on.  Technically, I have no problem
with the aic94xx driver being based on a domain device.  However, you
cannot have two separate transport classes for SAS.  So these two need
to be unified before this driver becomes includable.

It looks to me to be a fairly simple exercise to unify these two classes
giving LSI a functional interface and you a domain device based one and
removing all the duplication of mid-layer functionality as part of doing
this.

> Why talk non-constructive things, when we can have a SCSI Storage
> discussion?
> 
> > issues pointed out when you first sent it out.  That's in the following
> > order:
> > 
> >  - not trying to integrate with the sas transport class in Linus'
> 
> Well here we go _again_:
> 
> The SAS Transport Class (your an JB's incarnation) is _not_
> a management infrastructure, it was _never_ _intended_ to be.

Actually, it was intended to be such.  The sysfs components of the
transport class are the unified management interface to the transport.

> The whole point of it is to _export_ *attributes* of MPT-technology
> like drivers.  All those drivers that it caters to _do_ _not_ need a
> _management_ layer (Discovery, Expander configuration, etc.).
> They "export" SCSI LUs directly to SCSI Core through their LLDDs.

No, the point of a transport class is to export the underlying
attributes of the actual devices that are present.  This is supposed to
be independent of the driver used to connect to them (and that's what
your sas class breaks).

> >  - duplicating the lun scanning code instead of using the scsi core one
> 
> The LUN scanning code is, uum, how to say this nicely... wrong?
> It did its job for Parallel SCSI and for broken arrays who do not
> respond to REPORT LUNS, but have a bunch of disks behind, but it is
> wrong _by design_ and it is _not_ _relevant_ in SAS.  To properly see
> how LUN scanning is done, look at sas_discover.c.

I've told you before, if you find something that's broken send a patch
in to fix it.  I've already told you why the code in sas_discover can't
work for other drivers (although I still don't have an explanation from
you of why scsi_scan_target can't work for sas_discover).

> What needs fixing is, SCSI Core to
> 	- not use HCIL,
> 	- use 64 bit LUNs,
> 	- know about SCSI devices with Target ports,
> 	- proper representation of SCSI Domains
>           (FC, USB, IEEE 1394, Infiniband, SAS, iSCSI)

As I've already said several times you're welcome to send in a patch to
change this as well ... as long as you either don't break every other
driver, or fix them all with the patch.  You were given a step by step
procedure at least for the I replacement piece.

> Christoph how long are you and James Bottomley going to hold
> SCSI Core _hostage_ to new technologies?

The only power of a maintainer is to say "no".  So, although I cannot
make you fix any of the problems in your submission, I can say no until
an acceptable submission comes along for this driver.  At this point, I
believe all the technical issues of what needs to happen are well
understood; I also believe that this is an important enough piece of
hardware that an acceptable driver will come along even if you want to
play dog in the manger, so all I can do is wait.

James



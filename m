Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbUBYAgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbUBYAgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:36:10 -0500
Received: from mail0.lsil.com ([147.145.40.20]:42373 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262550AbUBYAfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:35:47 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC3E2@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-alpha1
Date: Tue, 24 Feb 2004 19:34:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Here is the list of enhancements this driver has build over the current
2.10.1 driver. Please list you specific concerns so that the driver can be
modified accordingly. This is an updated version of the current driver in lk
2.6, which should take all your fixes, instead of current 2.00.3 in 2.6.2


1.	Support for upcoming MPT *RAID* controllers. These are not the
currently in kernel fusion-mpt controllers we are talking about.

2.	Controller and device re-ordering on both lk 2.4 and lk 2.6. If this
is not desired, the driver code would be modified to make it PCI ordered
detection. The driver also re-orders the drives, based on which one is
chosen as boot drive. Matt, please add your comments here.

3.	Support for DPC using tasklets. This is currently available for
traditional mailbox controllers only.

4.	Native hot-plug support for both lk 2.4 and lk 2.6

5.	Single code for lk 2.4 and lk 2.6. We would like to keep the driver
this way but again if general kernel rules are against this, this is the
right inflection point, we will fork the driver.

6.	Single code to support *all* x86-32, IA64, and x86-64 platforms

7.	Exports physical devices on their actual addresses instead 2.10.1
scheme of exporting logical drives first and than exporting physical devices
on virtual channels.

8.	Support for up to 256 commands (configurable) per mailbox based
adapter instead of 127 for 2.10.1 driver.

9.	"mbox_fast_load" module parameter allows the driver to load much
faster than 2.10.1.

10.	Efficient algorithm to translate mid-layer device address to
megaraid device addresses.


Thanks
-Atul Mukker
LSI Logic Corporation

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com]
> Sent: Tuesday, February 24, 2004 4:14 PM
> To: Mukker, Atul
> Cc: 'James Bottomley'; 'matt_domsch@dell.com'; 'Paul Wagland'; Matthew
> Wilcox; 'linux-kernel@vger.kernel.org'; 'linux-scsi@vger.kernel.org'
> Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable
> bug fix)
> 
> 
> On Tue, Feb 24, 2004 at 04:02:34PM -0500, Mukker, Atul wrote:
> > > > controllers and also a single code base, with a very small 
> > > footprint patch -
> > > > if at all required, to support various kernels.
> > > 
> > > I didn't say "no".  I'm just warning you that you've chosen a 
> > > hard road
> > > to hoe, particularly with the limited life of 2.4.
> > 
> > In my opinion, maintaining support for 2.4 drivers and adding new
> > controllers to it would be crucial for a considerable time 
> to come even
> 
> there is a difference between just adding a pci id and adding all new
> features.
> 
> > Do we want to discover controllers and devices directed 
> solely by kernel and
> > should driver interfere a little bit.
> 
> I always considered the megaraid code here extremely hairy... 
> I'd love to
> see it go when we can 
> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVI2PEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVI2PEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVI2PEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:04:54 -0400
Received: from magic.adaptec.com ([216.52.22.17]:50323 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932172AbVI2PEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:04:53 -0400
Message-ID: <433C0285.3050106@adaptec.com>
Date: Thu, 29 Sep 2005 11:04:37 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Patrick Mansfield <patmans@us.ibm.com>, Luben Tuikov <ltuikov@yahoo.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281530190.19896-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10509281530190.19896-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 15:04:46.0779 (UTC) FILETIME=[2185D8B0:01C5C507]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/05 18:43, Andre Hedrick wrote:
> I have a vested interest in the improvement of the Linux SCSI Core and
> wider adoption and support for SATA II and SAS controllers with their
> associated domains and transport.

Us and other companies too.

> Proving a better design with a migration path for integration is the key
> for success; however, I am not the person to be the political voice in the

Yes, _it is_ the key to success.

> James is king of the hill, and is reasonable to a point.  James also

Which "hill" is the question.  If he were reasonable, he'd
understand that the two technologies _are_ completely different and
distinct and he'd not try to shove HIS solution down my throat.
Just as I do not shove my solution in his throat.

The whole point is that MPT-based (IOP on package) solutions
_do not_ need a Transport Layer, since that Transport Layer
_is_ already present: in the firmware _and_ access to it
is _firmware_ dependent.

All the while open transport solutions (ours and apparently
Broadcoms') _expose_ the whole infrastructure and _give_ you
the chip as an interface to the interconnect.  So you actually
_need_ a transport management layer.  Now that transport
management layer sits _below_ SCSI Core and SCSI Core is
_unaware_ of the transport.

> follows a model of generalization v/s specific design.  Argh, this is not
> going to be an easy one to explain or back away from now.  Erm, inclusive
> API design is where I am wanting to go with this thought.

You can have inclusive API design for chips like AIC-94xx and BCM8603,
because they <see paragraph above>.

MPT-based ones <see paragraph above> would also use inclusive
design _for MPT-based chips_.

> Have you and company considered the approach of mapping to a library of
> sorts?

Hmm, it is not a library.

It is a layer, again, because of what the chip actually is, and because
of what it implements.

Take a look at the announcement text, I do give some description there
and in the code the drivers/scsi/sas-class/README file describes
the event/managment infrastructure.  Also you can take a look at the code.
http://linux.adaptec.com/sas/

What you'll see in the code is:

  hardware implementation  (interconnect, SAM 4.15, 1.3)
      firmware implementation  (interconnect, SDS, SAM 4.6, 1.3)
          LLDD                     (SAM, section 5, 6, 7)
             Transport Layer          (SAM 4.15, SAS)
                  SCSI Core             (SAM section 4,5,8)
                     Commmand Sets        (SAM section 1)

A very nice explanation in latest SAM4r03,
section 4.15 The SCSI model for distributed communications.

Now for MPT based solutions you have:

  LLDD                  (SAM, section 5, 6, 7)
     SCSI Core             (SAM section 4,5,8)
        Commmand Sets         (SAM section 1)

You see?  No Transport Layer between LLDD and SCSI Core!
Why?  Because all this work is done in FIRMWARE!

That is, the LLDD exports the LUs right into SCSI Core,
So in effect there is _no_ need for a software Transport
Layer.

Can we have a video/tele conference on this?

	Luben


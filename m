Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbSISMOv>; Thu, 19 Sep 2002 08:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266646AbSISMOv>; Thu, 19 Sep 2002 08:14:51 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:9427 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S266469AbSISMOu>; Thu, 19 Sep 2002 08:14:50 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A6E@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Scott Murray'" <scottm@somanetworks.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux hot swap support
Date: Thu, 19 Sep 2002 08:19:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick response. We are working on a new HW layout. I think
that I already got the answer to the critical question that I need. Once I
have the HW in place, I have to be sure that the 2.4.18-3 Kernel (or
greater) can support hot swap withoout any third party SW. Of course I
understand that my driver will have to be modified. This answer I already
received yesterday. Thanks very much.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Scott Murray [mailto:scottm@somanetworks.com]
Sent: Wednesday, September 18, 2002 8:06 PM
To: Bloch, Jack
Cc: Greg KH; Linux Kernel Mailing List
Subject: Re: Linux hot swap support


On Wed, 18 Sep 2002, Greg KH wrote:

> On Wed, Sep 18, 2002 at 05:37:50PM -0400, Bloch, Jack wrote:
> > At the moment, I only support removal. The way it works is as follows.
> >
> > Upon system start up my device driver detects all of the boards which
are
> > present (I support up to six). For each board it allocates the necessary
I/O
> > lists memory needed for operation. All addresses are then mapped to user
> > space with a mmap interface. Now, all HW is accessible from user space.
For
> > each device, an ISR is installed. As soon as the ejector handle for a
> > particular device is opened, the board (which is a Motorola 68060 based
> > board) issues an interrupt to me. I will shut this board down and
> > de-allocate any of the previously reserved resources. What is not so
easy is
> > to perform the insert. I thought about allocating memory becessary for a
> > maximum configuration, but I would still need to get the insertion
event.
> > But anyway  since our device (even though it has multiple boards
internally)
> > is seen as a monolithic device from the main controlling host, the loss
of a
> > single board causes it to be taken out of service.
>
> Hm, you might want to take a look at the cPCI patches from Scott Murray,
> he has a solution for the resource and insertion problem that will
> probably work for you.  You can find the patches on the pcihpd-discuss
> mailing list, and I think they were also posted to lkml in the past too.
> He's working on cleaning them up a bit for inclusion in the main kernel
> tree.

>From looking at the datasheet of the AMCC S5935, it appears to not be
compliant with the PICMG 2.1 cPCI hotswap specification.  That means
that it will probably take quite a bit of hardware and software hacking
to make insertion work.  My patches should provide a bit of basis for
further hacking if you do want to try and build something yourself, but
if reliable hotplugging is important to your project, I'd suggest
considering a switch to a PCI controller or bridge that is PICMG 2.1
hotswap compliant.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269627AbSISAAz>; Wed, 18 Sep 2002 20:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269703AbSISAAz>; Wed, 18 Sep 2002 20:00:55 -0400
Received: from [63.204.6.12] ([63.204.6.12]:46005 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S269627AbSISAAy>;
	Wed, 18 Sep 2002 20:00:54 -0400
Date: Wed, 18 Sep 2002 20:05:54 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: "Bloch Jack" <Jack.Bloch@icn.siemens.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux hot swap support
In-Reply-To: <20020918214741.GI10970@kroah.com>
Message-ID: <Pine.LNX.4.33.0209181946050.13805-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Greg KH wrote:

> On Wed, Sep 18, 2002 at 05:37:50PM -0400, Bloch, Jack wrote:
> > At the moment, I only support removal. The way it works is as follows.
> >
> > Upon system start up my device driver detects all of the boards which are
> > present (I support up to six). For each board it allocates the necessary I/O
> > lists memory needed for operation. All addresses are then mapped to user
> > space with a mmap interface. Now, all HW is accessible from user space. For
> > each device, an ISR is installed. As soon as the ejector handle for a
> > particular device is opened, the board (which is a Motorola 68060 based
> > board) issues an interrupt to me. I will shut this board down and
> > de-allocate any of the previously reserved resources. What is not so easy is
> > to perform the insert. I thought about allocating memory becessary for a
> > maximum configuration, but I would still need to get the insertion event.
> > But anyway  since our device (even though it has multiple boards internally)
> > is seen as a monolithic device from the main controlling host, the loss of a
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





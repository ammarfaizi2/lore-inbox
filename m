Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268608AbSIRVcu>; Wed, 18 Sep 2002 17:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268631AbSIRVcu>; Wed, 18 Sep 2002 17:32:50 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:4515 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S268608AbSIRVct>; Wed, 18 Sep 2002 17:32:49 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A6B@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux hot swap support
Date: Wed, 18 Sep 2002 17:37:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, I only support removal. The way it works is as follows.

Upon system start up my device driver detects all of the boards which are
present (I support up to six). For each board it allocates the necessary I/O
lists memory needed for operation. All addresses are then mapped to user
space with a mmap interface. Now, all HW is accessible from user space. For
each device, an ISR is installed. As soon as the ejector handle for a
particular device is opened, the board (which is a Motorola 68060 based
board) issues an interrupt to me. I will shut this board down and
de-allocate any of the previously reserved resources. What is not so easy is
to perform the insert. I thought about allocating memory becessary for a
maximum configuration, but I would still need to get the insertion event.
But anyway  since our device (even though it has multiple boards internally)
is seen as a monolithic device from the main controlling host, the loss of a
single board causes it to be taken out of service.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, September 18, 2002 5:31 PM
To: Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support


On Wed, Sep 18, 2002 at 05:09:50PM -0400, Bloch, Jack wrote:
> Our HW uses an AMCC S5935 PCI controller. Right now, since we own both
> device and SW, we are using a simple interrupt mechanism to accomplish the
> hot swap. 

What do you mean "simple interrupt mechanism"?  How does the OS know
that a PCI card has disappeared or show up?

thanks,

greg k-h

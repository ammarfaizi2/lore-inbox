Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269043AbSIRVqa>; Wed, 18 Sep 2002 17:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269246AbSIRVqa>; Wed, 18 Sep 2002 17:46:30 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:17319 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S269043AbSIRVq3>; Wed, 18 Sep 2002 17:46:29 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793A6C@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux hot swap support
Date: Wed, 18 Sep 2002 17:51:30 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the help, but a generic question. If my HW has a hotswap
controller (theoretically), I do not need any thrird party SW to handle the
hot swap insert/remove. Linux 2.4.18-3 Kernel should support this correct? I
should just run /sbin/hotplug pci on start up.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, September 18, 2002 5:48 PM
To: Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support


On Wed, Sep 18, 2002 at 05:37:50PM -0400, Bloch, Jack wrote:
> At the moment, I only support removal. The way it works is as follows.
> 
> Upon system start up my device driver detects all of the boards which are
> present (I support up to six). For each board it allocates the necessary
I/O
> lists memory needed for operation. All addresses are then mapped to user
> space with a mmap interface. Now, all HW is accessible from user space.
For
> each device, an ISR is installed. As soon as the ejector handle for a
> particular device is opened, the board (which is a Motorola 68060 based
> board) issues an interrupt to me. I will shut this board down and
> de-allocate any of the previously reserved resources. What is not so easy
is
> to perform the insert. I thought about allocating memory becessary for a
> maximum configuration, but I would still need to get the insertion event.
> But anyway  since our device (even though it has multiple boards
internally)
> is seen as a monolithic device from the main controlling host, the loss of
a
> single board causes it to be taken out of service.

Hm, you might want to take a look at the cPCI patches from Scott Murray,
he has a solution for the resource and insertion problem that will
probably work for you.  You can find the patches on the pcihpd-discuss
mailing list, and I think they were also posted to lkml in the past too.
He's working on cleaning them up a bit for inclusion in the main kernel
tree.

Hope this helps,

greg k-h

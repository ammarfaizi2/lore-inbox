Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbSIRVmk>; Wed, 18 Sep 2002 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269043AbSIRVmk>; Wed, 18 Sep 2002 17:42:40 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:1800 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268926AbSIRVmj>;
	Wed, 18 Sep 2002 17:42:39 -0400
Date: Wed, 18 Sep 2002 14:47:41 -0700
From: Greg KH <greg@kroah.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux hot swap support
Message-ID: <20020918214741.GI10970@kroah.com>
References: <180577A42806D61189D30008C7E632E8793A6B@boca213a.boca.ssc.siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180577A42806D61189D30008C7E632E8793A6B@boca213a.boca.ssc.siemens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 05:37:50PM -0400, Bloch, Jack wrote:
> At the moment, I only support removal. The way it works is as follows.
> 
> Upon system start up my device driver detects all of the boards which are
> present (I support up to six). For each board it allocates the necessary I/O
> lists memory needed for operation. All addresses are then mapped to user
> space with a mmap interface. Now, all HW is accessible from user space. For
> each device, an ISR is installed. As soon as the ejector handle for a
> particular device is opened, the board (which is a Motorola 68060 based
> board) issues an interrupt to me. I will shut this board down and
> de-allocate any of the previously reserved resources. What is not so easy is
> to perform the insert. I thought about allocating memory becessary for a
> maximum configuration, but I would still need to get the insertion event.
> But anyway  since our device (even though it has multiple boards internally)
> is seen as a monolithic device from the main controlling host, the loss of a
> single board causes it to be taken out of service.

Hm, you might want to take a look at the cPCI patches from Scott Murray,
he has a solution for the resource and insertion problem that will
probably work for you.  You can find the patches on the pcihpd-discuss
mailing list, and I think they were also posted to lkml in the past too.
He's working on cleaning them up a bit for inclusion in the main kernel
tree.

Hope this helps,

greg k-h

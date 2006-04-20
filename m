Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWDTXoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWDTXoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDTXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:44:06 -0400
Received: from pat.qlogic.com ([198.70.193.2]:3380 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S1751286AbWDTXoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:44:04 -0400
Date: Thu, 20 Apr 2006 16:44:04 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: James Smart <James.Smart@Emulex.Com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
Message-ID: <20060420234404.GM8514@andrew-vasquezs-powerbook-g4-15.local>
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <4446AC80.6040604@cs.wisc.edu> <44479BA8.1000405@emulex.com> <4447C8C2.30909@cs.wisc.edu> <4447E91E.7030603@emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447E91E.7030603@emulex.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 20 Apr 2006 23:44:04.0352 (UTC) FILETIME=[4EBD7000:01C664D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, James Smart wrote:

> Note: We've transitioned off topic. If what this means is "there isn't a 
> good
> way except by ioctls (which still isn't easily portable) or system calls",
> then that's ok. Then at least we know the limits and can look at other
> implementation alternatives.

this topic has been brought-up many times in the past, most recently:

	http://thread.gmane.org/gmane.linux.drivers.openib/19525/focus=19525
	http://thread.gmane.org/gmane.linux.kernel/387375/focus=387455

where is was suggested to pathscale folks to use some blend of sysfs,
netlink sockets and debugfs:

	http://kerneltrap.org/node/4394

> >>Mike Christie wrote:
> >Instead of netlink for scsi commands and transport requests....
> >
> >For scsi commands could we just use sg io, or is there something special
> >about the command you want to send? If you can use sg io for scsi
> >commands, maybe for transport level requests (in my example iscsi pdu)
> >we could modify something like sg/bsg/block layer scsi_ioctl.c to send
> >down transport requests to the classes and encapsulate them in some new
> >struct transport_requests or use the existing struct request but do that
> >thing people keep taling about using the request/request_queue for
> >message passing.
> 
> Well - there's 2 parts to this answer:
> 
> First : IOCTL's are considered dangerous/bad practice and therefore it would
>   be nice to find a replacement mechanism that eliminates them. If that
>   mechanism has some of the cool features that netlink does, even better.
>   Using sg io, in the manner you indicate, wouldn't remove the ioctl use.
>   Note: I have OEMs/users that are very confused about the community's 
>   statement
>   about ioctls. They've heard they are bad, should never be allowed, will no
>   be longer supported, but yet they are at the heart of DM and sg io and 
>   other
>   subsystems. Other than a "grandfathered" explanation, they don't 
>   understand
>   why the rules bend for one piece of code but not for another. To them, all
>   the features are just as critical regardless of whose providing them.

I believe it to be the same for most hardware-vendor's customers...

> Second: transport level i/o could be done like you suggest, and we've
>   prototyped some of this as well. However, there's something very wrong
>   about putting "block device" wrappers and settings around something that
>   is not a block device.

Eeww...  no wrappers.  Your netlink prototypes certainly get FC-
transport further along, but would also be nice if there could be some
subsystem consensus on *the* interface.

I honestly don't know which interface is *best*, but from a HBA
vendors perspective managing per-request locally allocated memory is
undesirable.

Thanks,
av

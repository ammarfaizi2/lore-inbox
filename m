Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVEQPhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVEQPhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVEQPhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:37:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:53132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261723AbVEQPfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:35:42 -0400
Date: Tue, 17 May 2005 08:35:27 -0700
From: Greg KH <greg@kroah.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: [PATCH] Fix root hole in pktcdvd
Message-ID: <20050517153527.GA23281@kroah.com>
References: <11163046681444@kroah.com> <11163046692974@kroah.com> <20050517050025.GP1150@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517050025.GP1150@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 06:00:25AM +0100, Al Viro wrote:
> On Mon, May 16, 2005 at 09:37:49PM -0700, Greg KH wrote:
> > ioctl_by_bdev may only be used INSIDE the kernel.  If the "arg" argument
> > refers to memory that is accessed by put_user/get_user in the ioctl
> > function, the memory needs to be in the kernel address space (that's the
> > set_fs(KERNEL_DS) doing in the ioctl_by_bdev).  This works on i386 because
> > even with set_fs(KERNEL_DS) the user space memory is still accessible with
> > put_user/get_user.  That is not true for s390.  In short the ioctl
> > implementation of the pktcdvd device driver is horribly broken.
> 
> Same comment as for previous patch.  I'll take a look at that sucker,
> it might happen to be OK, seeing that most of the bdev ->ioctl() instances
> ignore file argument and we might get away with passing odd stuff to
> anything that could occur here.

Ok, so, do you suggest we just pass NULL in there, or do you have a
better suggestion?

thanks,

greg k-h

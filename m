Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVBXXkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVBXXkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVBXXgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:36:48 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:31100 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262533AbVBXXfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:35:23 -0500
Date: Thu, 24 Feb 2005 15:34:58 -0800
From: Greg KH <gregkh@suse.de>
To: Malcolm Rowe <malcolm-linux@farside.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Symlink /sys/class/block to /sys/block
Message-ID: <20050224233458.GB26941@suse.de>
References: <courier.4217CBC9.000027C1@mail.farside.org.uk> <20050222190412.GA23687@suse.de> <courier.421C5047.00003EBA@mail.farside.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.421C5047.00003EBA@mail.farside.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 09:43:35AM +0000, Malcolm Rowe wrote:
> Greg KH writes: 
> 
> >>Following the discussion in [1], the attached patch creates 
> >>/sys/class/block
> >>as a symlink to /sys/block. The patch applies to 2.6.11-rc4-bk7.  
> >>
> >>Please cc: me on any replies - I'm not subscribed to the mailing list. 
> >Hm, your patch is linewrapped, and can't be applied :(
> 
> Bah, and I did send it to myself first, but I guess my mailer un-flowed it 
> for me :-(.  I'll try to find a better mailer. 
> 
> >But more importantly:
> >>static void disk_release(struct kobject * kobj)
> >
> >Did you try to remove a disk (like a usb device) and see what happens
> >here?  Hint, this isn't the proper place to remove the symlink...
> 
> Er, yeah. Oops. 
> 
> *Is* there a sensible place to remove the symlink from, though?  Nobody 
> seems to call subsystem_unregister(&block_subsys), which is the place I'd 
> expect to add a call to, and I can't see anything that's otherwise 
> obvious... 

If the subsystem is never unregistered, then don't worry about undoing
the symlink.

thanks,

greg k-h

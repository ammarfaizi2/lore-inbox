Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTLEXig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLEXif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:38:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:25024 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264874AbTLEXiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:38:22 -0500
Date: Fri, 5 Dec 2003 15:36:18 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Mike Gorse <mgorse@mgorse.dhs.org>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031205233618.GB14162@kroah.com>
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org> <20031201093804.GA6918@in.ibm.com> <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org> <20031202071112.GA20864@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202071112.GA20864@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 12:41:13PM +0530, Maneesh Soni wrote:
> Hi Mike,
> 
> I think now I understand the problem better. It looks to me a case of
> parent kobject going away before child. 

Yes, but I don't see how that is happening in the usb code :(

> As we have 
> 
> > sysfs 1-1: removing dir
> >  o 1-1:1.0 (10): <7>removing<7> done
> 
> and then
> > sysfs 1-1:1.0: removing dir
> 
> Its good that you enabled debug printks. We can see error 
> 
> > usb 1-1: hcd_unlink_urb d3d33f60 fail -22

This isn't an error, it can be ignored.  It just means that the driver
told the usb core to unlink a urb that was already unlinked.  Very
common thing.

> I think Greg or Pat can help you better in this case. I have no idea if 
> this error is creating this problem.

It's not this error, but something else.  The usb-serial code hasn't
changed in a while.  Can you try figuring out what kernel version this
bug shows up in?

thanks,

greg k-h

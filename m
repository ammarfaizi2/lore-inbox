Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbUJ2XHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbUJ2XHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUJ2XDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:03:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:41094 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263590AbUJ2W7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:59:39 -0400
Date: Fri, 29 Oct 2004 17:58:50 -0500
From: Greg KH <greg@kroah.com>
To: Mehulkumar J Patel <mehul.patel@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exclusive access to hardware for test purpose
Message-ID: <20041029225850.GB32032@kroah.com>
References: <20041029204325.GA30638@kroah.com> <OF8948B2BB.F576944E-ON65256F3C.00784B09-65256F3C.007CC331@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8948B2BB.F576944E-ON65256F3C.00784B09-65256F3C.007CC331@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 04:08:46AM +0530, Mehulkumar J Patel wrote:
> Greg KH <greg@kroah.com> 
> 30/10/2004 02:13

Ugh, don't use Notes to write internet email...

> > You need to disconnect the device from any current driver that might be
> > bound to it.  Then you need to bind to the device to make sure that no
> > one else binds to it.
> 
> Can you please elaborate, by disconnect, you mean unload the driver ?

No, the driver core matches up drivers to devices.  You need to tell the
driver core to disconnect that match.  See the recent patches to lkml
that expose the functions you need for what to do.

> If so I can not do that because one driver serving all cards including
> the one that I am not testing. So I can not unload driver.
> Please elaborate on how to bind to device.

Same as above, tell the driver core to do it.  Don't mess with the pci
remove functions, as there are still portions of the kernel that think
the link is there if you do that.

Good luck,

greg k-h

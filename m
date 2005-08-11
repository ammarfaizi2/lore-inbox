Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVHKSYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVHKSYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVHKSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:24:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:16609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932346AbVHKSYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:24:32 -0400
Date: Thu, 11 Aug 2005 11:24:23 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
Message-ID: <20050811182423.GC15803@kroah.com>
References: <Pine.LNX.4.44L0.0508101637360.4467-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0508101637360.4467-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 04:56:08PM -0400, Alan Stern wrote:
> Greg and Pat:
> 
> This patch (as536) simplifies the driver-model core by replacing the klist 
> used to store the set of devices bound to a driver with a regular list 
> protected by a mutex.  It turns out that even with a klist, there are too 
> many opportunities for races for the list to be used safely by more than 
> one thread at a time.  And given that only one thread uses the list at any 
> moment, there's no need to add all the extra overhead of making it a 
> klist.

Hm, but that was the whole reason to go to a klist in the first place.

> This version of the patch addresses the concerns raised earlier by Pat:  
> the list and mutex have been given more succinct names, and the obscure
> special-case code in device_attach has been replaced with a FIXME comment.  
> Note that the new iterators in driver.c could easily be changed to use
> list_for_each_entry_safe and list_for_each_entry, if the functions didn't
> offer the feature of starting in the middle of the list.  If no callers
> use that feature, it should be removed.

Pat, any opinions on this patch?

thanks,

greg k-h

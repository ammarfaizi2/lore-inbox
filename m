Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWEIXnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWEIXnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWEIXnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:43:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:58261 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932094AbWEIXnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:43:23 -0400
Message-ID: <44612916.1030606@us.ibm.com>
Date: Tue, 09 May 2006 18:43:18 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device	hotplug
 driver.
References: <20060509084945.373541000@sous-sol.org>	<20060509085200.826853000@sous-sol.org>	<20060509194044.GA374@kroah.com>	<20060509215314.GU24291@moss.sous-sol.org> <20060509220158.GA20564@kroah.com>
In-Reply-To: <20060509220158.GA20564@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, May 09, 2006 at 02:53:14PM -0700, Chris Wright wrote:
>   
>>> What is the "frontend/backend" relationship here?
>>>       
>> do you mean in sysfs?  or more in general?
>>     
>
> Either.  You seem to mention a lot of nested depths in sysfs or "files",
> yet your above tree doesn't show that.  And I don't understand what you
> mean by frontend/backend here either?  Is it a sysfs thing?  Or a Xen
> thing?
>   

Hi Greg,

XenStore is a shared namespace (similar to sysfs or open firmware) 
between domains.  The interdomain communication primitives exposed by 
Xen are very lowlevel (virtual IRQ and shared memory).  XenStore is 
implemented on top of these primitives and provides some higher level 
operations (read a key, write a key, enumerate a directory, notify when 
a key changes value).

We use XenStore to implement our virtual drivers (this infrastructure is 
called XenBus).  The drivers are split between a backend and frontend.  
The frontend is the portion of the driver that runs in the guest and the 
backend is the portion of the driver that runs in the host (and actually 
virtualizes the underlying device).

The xenbus_mkdir, etc. functions you see operate on XenStore.

Regards,

Anthony Liguori

> thanks,
>
> greg k-h
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/virtualization
>   


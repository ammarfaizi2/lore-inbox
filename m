Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTEAUGN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTEAUGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:06:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1968 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262299AbTEAUGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:06:12 -0400
Date: Thu, 1 May 2003 13:19:43 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Gibson <david@gibson.dropbear.id.au>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Subject: Re: request_firmware() hotplug interface.
Message-ID: <20030501201943.GA3498@kroah.com>
References: <20030501194702.GA2997@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501194702.GA2997@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 09:47:02PM +0200, Manuel Estrada Sainz wrote:
> 
>  - Why I don't think any more that sysfs is good as "the default" for
>    userspace to provide the firmware:
> 	- For drivers providing a sysfs entry for firmware:
> 		It will be trivial to use request_firmware() and arrange the
> 		hotplug scripts to get it copied to their sysfs firmware
> 		entry. They don't need any additional support for copying the
> 		firmware from userspace.

With the code in the latest -bk tree, if you simply create a struct
class and name it "firmware", and then just create a struct class_device
for any struct device that wants firmware to be loaded, you will get a
hotplug event generated for you (with the name "firmware")
automatically.  That is a lot simpler than the firmware.c code you
posted.

> 	- For drivers not providing a sysfs entry for firmware:
> 		They just want the appropriate firmware in a memory buffer. It
> 		doesn't make much sense to hack some code to get a sysfs entry
> 		for them and then tell hotplug where to copy the firmware.
> 		The driver won't know that the entry is there, and it won't
> 		make sense to write data to it unless requested via hotplug.

As all devices in the kernel should now be in sysfs (if not, please let
me know what busses haven't been converted yet), I think the firmware
class is a much simpler way to go.  You get the hotplug call for free,
and a sysfs entry where the firmware can be dumped to, if you want to do
it that way.

thanks,

greg k-h

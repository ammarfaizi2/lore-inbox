Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTEDOr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTEDOr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:47:59 -0400
Received: from cable50a067.usuarios.retecal.es ([212.22.50.67]:8655 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S263624AbTEDOr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:47:57 -0400
Date: Sun, 4 May 2003 16:59:59 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface.
Message-ID: <20030504145959.GA9216@ranty.ddts.net>
References: <20030501194702.GA2997@ranty.ddts.net> <20030501201943.GA3498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501201943.GA3498@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Greg,

 Sorry, for the delay, I wanted to answer already with some code, but I
 am too outdated on 2.5 development :(, so it will take a while.

On Thu, May 01, 2003 at 01:19:43PM -0700, Greg KH wrote:
> On Thu, May 01, 2003 at 09:47:02PM +0200, Manuel Estrada Sainz wrote:
> > 
> >  - Why I don't think any more that sysfs is good as "the default" for
> >    userspace to provide the firmware:
> > 	- For drivers providing a sysfs entry for firmware:
> > 		It will be trivial to use request_firmware() and arrange the
> > 		hotplug scripts to get it copied to their sysfs firmware
> > 		entry. They don't need any additional support for copying the
> > 		firmware from userspace.
> 
> With the code in the latest -bk tree, if you simply create a struct
> class and name it "firmware", and then just create a struct class_device
> for any struct device that wants firmware to be loaded, you will get a
> hotplug event generated for you (with the name "firmware")
> automatically.  That is a lot simpler than the firmware.c code you
> posted.

 Sounds promising, I'll try to code something on top of that.

> > 	- For drivers not providing a sysfs entry for firmware:
> > 		They just want the appropriate firmware in a memory buffer. It
> > 		doesn't make much sense to hack some code to get a sysfs entry
> > 		for them and then tell hotplug where to copy the firmware.
> > 		The driver won't know that the entry is there, and it won't
> > 		make sense to write data to it unless requested via hotplug.
> 
> As all devices in the kernel should now be in sysfs (if not, please let
> me know what busses haven't been converted yet),

 As said, I am outdated on 2.5 development, if I find any while I look at
 it, I promise to complain.

> I think the firmware class is a much simpler way to go.  You get the
> hotplug call for free, and a sysfs entry where the firmware can be
> dumped to, if you want to do it that way.

 Sounds good.

 Thanks

 	Manuel

 PS: Not much new, mainly proving that I'm not ignoring you :), I'm
 working on it.

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

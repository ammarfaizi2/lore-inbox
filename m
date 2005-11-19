Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbVKSB5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbVKSB5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbVKSB5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:57:41 -0500
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:37316 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S1161209AbVKSB5k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:57:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: question about driver built-in kernel
Date: Fri, 18 Nov 2005 18:57:38 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC5032F842D@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question about driver built-in kernel
Thread-Index: AcXsqYege/zCwqjDSOuC2/w9xykjDQAAarDA
From: <yiding_wang@agilent.com>
To: <greg@kroah.com>, <yiding_wang@agilent.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Nov 2005 01:57:38.0939 (UTC) FILETIME=[9E9A9CB0:01C5ECAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg! 

Got everything straighten up.
 
1, replaced init_module() by __init init_module to avoid kernel build conflict.
2, arranged correct sequence in Makefile to load two drivers in proper order.

Now it looks the pci bus register accessing has problem. If loaded as module, everything works fine. If build in kernel, it always failed at the spot driver resetting the chip through register during the kernel loading. It seems the pci base address mapping or something related has problem. Is there any difference for ioremap call between the kernel loading and after system is up? Is anything special on pci device register accessing during the kernel booting, compare with after system boot up?

Thanks!

Eddie 

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Friday, November 18, 2005 5:20 PM
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about driver built-in kernel

On Thu, Nov 17, 2005 at 05:18:34PM -0700, yiding_wang@agilent.com wrote:
> We have two driver modules to support our hardware for some
> applications. Both modules worked fine as loadable modules. Now I need
> to build both drivers in kernel 2.6.11-8. I have changed configuration
> file and make file. Both drivers are built OK with kernel together.

Have a pointer to the source for these drivers?

> 1, Because both drivers were loaded as module before, the entry point
> for both driver is "init_module()". Since both drivers are built in
> kernel, the entry name is conflicting. Changing one entry point name
> will make driver built OK. However, I am concerned that loading kernel
> will not pick up the driver with changed entry point name. What is the
> best way to handle this situation?

Make your init module function static, like all other kernel drivers.

> 2, One of built-in driver requires to be loaded before the second one.
> Because these two drivers are not belong to any existing group, such
> as network, scsi, where is the best place these two driver can be
> specified for loading sequence? I checked init.d and rc* files but did
> not figure out proper place to handle the requirement.

The linker specifies the loading order.

hope this helps,

greg k-h

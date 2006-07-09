Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWGIPCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWGIPCF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWGIPCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:02:05 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:5554 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1161022AbWGIPCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:02:03 -0400
Subject: Re: [RFC][PATCH 1/2] firmware version management: add
	firmware_version()
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: Martin Langer <martin-langer@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
In-Reply-To: <200607091644.53285.mb@bu3sch.de>
References: <20060708130904.GA3819@tuba>
	 <1152366597.29506.13.camel@localhost> <20060709122118.GA3678@tuba>
	 <200607091644.53285.mb@bu3sch.de>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 16:57:02 +0200
Message-Id: <1152457022.4573.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> > > > > It would be good if a driver knows which firmware version will be 
> > > > > written to the hardware. I'm talking about external firmware files 
> > > > > claimed by request_firmware(). 
> > > > > 
> > > > > We know so many different firmware files for bcm43xx and it becomes 
> > > > > more and more complicated without some firmware version management.
> > > > > 
> > > > > This patch can create the md5sum of a firmware file. Then it looks into 
> > > > > a table to figure out which version number is assigned to the hashcode.
> > > > > That table is placed in the driver code and an example for bcm43xx comes 
> > > > > in my next mail. Any comments?
> > > > 
> > > > why does this have to happen on the kernel side? Isn't it a lot easier
> > > > and better to let the userspace side of things do this work, and even
> > > > have a userspace file with the md5->version mapping? Or are there some
> > > > practical considerations that make that hard to impossible?
> > > 
> > > I fully agree that we shouldn't put firmware versioning into the kernel
> > > drivers. The pattern you give to request_firmware() can be mapped to any
> > > file on the file system. And you also have the link to the device object
> > > and I prefer you export a sysfs file for the version so that the helper
> > > application loading the firmware can pick the right file.
> > 
> > Bcm43xx has no helper application to upload the firmware. This is done 
> > in the driver. It's RAM based hardware without a Flash-ROM. The driver 
> > has to upload the firmware in the init phase after each reset.
> > 
> > The driver gets a firmware file from /lib/firmware/ without knowing 
> > which version this is. It's not possible to say enable this in the 
> > driver if you find a firmware x and disable that if it's only version 
> > y. That was my motivation to start thinking about firmware versioning.
> > 
> > But in the meantime I think it's a security issue, too. A driver 
> > should only accept firmware files with certified checksums. I guess it 
> > would be really difficult to enter a machine by firmware hijacking. So, 
> > I'm still in hope that this is only a paranoia on my side. But it's 
> > worth to think about it.
> 
> I really think drivers should only allow firmware files that are known
> to work. This should be verified by a hardcoded checksum in the driver.
> I support Martin's patch.

this should be done in the driver. So why do you try to enhance the
firmware_class to do this job. If your driver has special requirements
for firmware checks, then implement them. I don't see any advantage of
doing this kind of stuff in firmware_class at the moment.

Regards

Marcel



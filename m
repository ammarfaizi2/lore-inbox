Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbULHTfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbULHTfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbULHTe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:34:58 -0500
Received: from mail0.lsil.com ([147.145.40.20]:2242 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261332AbULHTeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:34:21 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57057A1A2B@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'Matt Domsch'" <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Wed, 8 Dec 2004 14:25:54 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The real way I'd like to handle this is via hotplug.  The 
> hotplug event would transmit the HCTL in the environment.  
> Whether the drive actually gets incorporated into the system 
> and where is user policy, so it's appropriate that it should 
> be in userland.
Hmm, is it possible for applications to create hotplug events? If it is,
this could a good idea as matter of system policies. Regardless, our
management applications interfaces with the firmware in terms of logical
drive numbers. Driver converts this number to the scsi host, bus, target etc
during all interactions with kernel. In order for applications to actually
notify kernel about arrival or removal of logical drives (hotplug event or
sysfs), it has to know the corresponding mapping used by driver, while
registering or would be registering, the device in question.

Since the mapping is private to the driver, it only can tell to application,
for a give logical driver *number* the corresponding scsi address

> > Removing a drive:- There is no sane way for the application 
> to map out 
> > drives to /dev/sd<x>. If application has a way of knowing 
> the HCTL of 
> > a deleted drive, then using that HCTL, it can match the 
> corresponding 
> > SCSI device name (/dev/sd<x>) and use sysfs to remove that drive.
> 
> Since The sysfs device name contains H:C:T:L surely you can 
> just do a find on /sys?

Again, there is no way for applications to relate H:C:T:L with a logical
drive number. This information must come from the driver.

Thanks
-Atul Mukker

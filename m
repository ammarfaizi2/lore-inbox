Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSGDWTH>; Thu, 4 Jul 2002 18:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGDWTH>; Thu, 4 Jul 2002 18:19:07 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28937
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315213AbSGDWTG>; Thu, 4 Jul 2002 18:19:06 -0400
Date: Thu, 4 Jul 2002 15:20:10 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot!
In-Reply-To: <200207041541.g64FfNW02097@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10207041517530.19028-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James,

The whole reason for my replacement was to add driverfs to IDE and remove
devfs and ultimately "de-gooch" the kernel.  So we are nearly 100 patches
in and the primary reason for ousting is still a failure, NICE!

On Thu, 4 Jul 2002, James Bottomley wrote:

> Er, oops, I think this one's my fault.
> 
> The recent driverfs additions for SCSI also added partition handling in 
> driverfs.  The code is slightly more invasive than it should be so the IDE 
> driver needs to know how to use it (which it doesn't yet).  In theory there's 
> a NULL pointer check in driverfs_create_partitions for precisely this case, 
> but it looks like the IDE code is forgetting to zero out a kmalloc of a struct 
> gendisk somewhere (hence the 5a5a... contents).  At a cursory glance, this 
> seems to be in ide/probe.c, so does the attached patch fix it?
> 
> I'll try to reproduce, but I'm all SCSI here except for my laptop.
> 
> James
> 
> 

Andre Hedrick
LAD Storage Consulting Group


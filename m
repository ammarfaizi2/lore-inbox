Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSGDPwO>; Thu, 4 Jul 2002 11:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSGDPwN>; Thu, 4 Jul 2002 11:52:13 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:14166 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317433AbSGDPwN>; Thu, 4 Jul 2002 11:52:13 -0400
Message-Id: <5.1.0.14.2.20020704165437.00b09c60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 04 Jul 2002 16:55:23 +0100
To: James Bottomley <James.Bottomley@steeleye.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot!
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
In-Reply-To: <200207041541.g64FfNW02097@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:41 04/07/02, James Bottomley wrote:
>Er, oops, I think this one's my fault.
>
>The recent driverfs additions for SCSI also added partition handling in
>driverfs.  The code is slightly more invasive than it should be so the IDE
>driver needs to know how to use it (which it doesn't yet).  In theory there's
>a NULL pointer check in driverfs_create_partitions for precisely this case,
>but it looks like the IDE code is forgetting to zero out a kmalloc of a 
>struct
>gendisk somewhere (hence the 5a5a... contents).  At a cursory glance, this
>seems to be in ide/probe.c, so does the attached patch fix it?
>
>I'll try to reproduce, but I'm all SCSI here except for my laptop.

Your patch fixed it. Please submit to Linus!

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


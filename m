Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSBYPEx>; Mon, 25 Feb 2002 10:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290769AbSBYPEn>; Mon, 25 Feb 2002 10:04:43 -0500
Received: from host194.steeleye.com ([216.33.1.194]:274 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S289817AbSBYPEW>; Mon, 25 Feb 2002 10:04:22 -0500
Message-Id: <200202251504.g1PF4Gq01637@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from Helge Hafting <helgehaf@aitel.hist.no> 
   of "Mon, 25 Feb 2002 11:57:35 +0100." <3C7A189F.8871B328@aitel.hist.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Feb 2002 09:04:16 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

helgehaf@aitel.hist.no said:
> I just wonder - isn't the amount of outstanding requests a device can
> handle constant?  If so, the user could determine this (from spec or
> by running an utility that generates "too much" traffic.)   

The spec doesn't make any statements about this, so the devices are allowed to 
do whatever seems best.  Although it is undoubtedly implemented as a fixed 
queue on a few devices, there are others whose queue depth depends on the 
available resources (most disk arrays function this way---they tend to juggle 
tag queue depth dynamically per lun).

Even if the queue depth is fixed, you have to probe it dynamically because it 
will be different for each device.  Even worse, on a SAN or other shared bus, 
you might not be the only initiator using the device queue, so even for a 
device with a fixed queue depth you don't own all the slots so the queue depth 
you see varies.

The bottom line is that you have to treat the queue full return as a normal 
part of I/O flow control to SCSI devices.

James



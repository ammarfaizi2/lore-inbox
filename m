Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSHOLVJ>; Thu, 15 Aug 2002 07:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSHOLVI>; Thu, 15 Aug 2002 07:21:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:35844 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316768AbSHOLVI>; Thu, 15 Aug 2002 07:21:08 -0400
Message-ID: <3D5B8FF9.102ACC62@aitel.hist.no>
Date: Thu, 15 Aug 2002 13:26:49 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Mike Galbraith <EFAULT@gmx.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] scsi disk sector size question
References: <3D5B6AD6.1030503@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> There's gotta be a better place to ask this, but...
> 
> Greetings,
> 
> Is it possible to change scsi drive sector size?  

The hardware sector size?  It depends on the drive.  
Some may let you do it, this usually requires a low-level
format, possibly using litte-documented vendor specific tricks.

> Scsiinfo says no, which is
> inconvenient if you're making images of ancient drives (ST4766N) and find
> that some have 512 byte and others 1024 byte sectors.

Having two scripts, one for each case is too bad?  

> Why on earth would a manufacturer [drives are really CDC] do this?

You should really ask the manufacturer.  One reason may be to squeeze
more data onto the disk.  Each sector has some overhead on the magnetic 
surface, such as crc data and sector gaps.  And the sector number is 
written too so the disk firmware knows where the head is - this is why
you need a low-level format when changing.  You need to write
new sector numbers for the different-sized sectors.

The overhead means you get more data on the disk by using larger
sectors.  Fewer sectors in total means less overhead when per-sector
overhead adds upp.  

Helge Hafting

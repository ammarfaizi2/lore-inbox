Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSHONZu>; Thu, 15 Aug 2002 09:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSHONZu>; Thu, 15 Aug 2002 09:25:50 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:25058 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S316898AbSHONZs>; Thu, 15 Aug 2002 09:25:48 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A664702CD66F3@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Helge Hafting'" <helgehaf@aitel.hist.no>, Mike Galbraith <EFAULT@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [OT] scsi disk sector size question
Date: Thu, 15 Aug 2002 06:30:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can change the disk's reported capacity via mode select, and the sector
size is included in the block descriptor with it.  Changing the sector size
from the manufacturer is not recommended, but you could try, if you do a
format afterward.  

I have a tool called 'sgmode' that I use to do mode sense/select on a set of
drives based on disk model.  
http://cvs.carrierlinux.org/viewcvs/viewcvs.cgi/components/scsirastools/src/

Andy Cress

-----Original Message-----
From: Helge Hafting [mailto:helgehaf@aitel.hist.no] 
Sent: Thursday, August 15, 2002 7:27 AM
To: Mike Galbraith
Cc: linux-kernel
Subject: Re: [OT] scsi disk sector size question

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

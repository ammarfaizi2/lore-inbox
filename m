Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280447AbRKFUId>; Tue, 6 Nov 2001 15:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280417AbRKFUIX>; Tue, 6 Nov 2001 15:08:23 -0500
Received: from web12301.mail.yahoo.com ([216.136.173.99]:56735 "HELO
	web12301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280447AbRKFUIQ>; Tue, 6 Nov 2001 15:08:16 -0500
Message-ID: <20011106200815.50754.qmail@web12301.mail.yahoo.com>
Date: Tue, 6 Nov 2001 12:08:15 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: Mylex/Compaq RAID controller placement in config
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Ramamurthy wrote:

> > I know it might seem silly, but as to make things clearer for most
> > users/admins, wouldn't it be better to just call them SCSI controllers, as
> > they all indeed connect SCSI drives to the host?
> 
> Eventhough they connect SCSI Drives, the fact is that they are totally
> different beast from the OS/driver perspective.

Actually, at least in Alan Cox's tree, the cciss driver is BOTH a SCSI driver
and a block driver simultaneously, or can be configured that way anyhow.  That
change was intruduced for the sole purpose of accessing SCSI tape drives via
array controllers.  (nevermind why you'd want to do that, suffice it to say,
some folks want this ability.)  I would consider it mostly a block driver, even
when SCSI tape drive support is compiled in.

In any case, the "drives" (logical volumes) which are presented by the
hardware/firmware and eventually by the driver to the OS do not in general
correspond 1-to-1 with physical SCSI drives.  Even the SCSI busses presented by
the cciss driver with SCSI tape support do not necessarily correspond with
physical SCSI busses, so considering these controllers "SCSI controllers" is
not really accurate, though typically they _contain_ what you can think of as
one or more SCSI controllers as part of the back-end, which the firmware uses
to control SCSI devices,.  Though, in some cases it could be a fibre-channel
back-end instead of SCSI.  In any case, the nature of the back-end is
irrelevant to the driver for purposes of doing i/o to logical volumes.

Incidentally, last time I checked, Linus' tree contained the documentation
portion of the patch which allowed a cciss controller to access SCSI tape
drives (Documentation/cciss.txt) but none of the actual code that implemented
that functionality... :-/  oh well.

-- steve (aka steve.cameron@compaq.com)

__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com

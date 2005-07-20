Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVGTAIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVGTAIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVGTAIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 20:08:14 -0400
Received: from mail0.lsil.com ([147.145.40.20]:2787 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261684AbVGTAIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 20:08:12 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: RE: [PATCH 22/82] remove linux/version.h from drivers/message/fus
	 ion
Date: Tue, 19 Jul 2005 18:07:41 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 12, 2005 8:17 PM, Matt Domsch wrote:
> In general, this construct:
> 
> > > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > > -static int inline scsi_device_online(struct scsi_device *sdev)
> > > -{
> > > -	return sdev->online;
> > > -}
> > > -#endif
> 
> is better tested as:
> 
> #ifndef scsi_device_inline
> static int inline scsi_device_online(struct scsi_device *sdev)
> {
>     return sdev->online;
> }
> #endif
> 
> when you can.  It cleanly eliminates the version test, and tests for
> exactly what you're looking for - is this function defined.
> 

What you illustrated above is not going to work.
If your doing #ifndef around a function, such as scsi_device_online, it's
not going to compile
when scsi_device_online is already implemented in the kernel tree.
The routine scsi_device_online is a function, not a define.  For a define
this would work.

I'm trying your example around msleep, msleep_interruptible, and
msecs_to_jiffies, and 
my code simply won't compile in SLES9 SP2(-191).  In SLES9 SP1(-139), these
three routines were not implemented and
your suggestion works.  I won't be able to to a linux version check as this
change occurred between service packs
of the 2.6.5 kernel suse tree.   Anybody on the linux forums have any ideas?

Example:

#ifdef msleep
static void inline msleep(unsigned long msecs)
{
        set_current_state(TASK_UNINTERRUPTIBLE);
        schedule_timeout(msecs_to_jiffies(msecs) + 1);
}
#endif




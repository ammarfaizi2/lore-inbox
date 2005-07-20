Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVGTDMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVGTDMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 23:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVGTDMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 23:12:52 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:42258 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261500AbVGTDMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 23:12:51 -0400
X-IronPort-AV: i="3.94,209,1118034000"; 
   d="scan'208"; a="288329011:sNHT18591620"
Date: Tue, 19 Jul 2005 22:12:49 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus ion
Message-ID: <20050720031249.GA18042@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 06:07:41PM -0600, Moore, Eric Dean wrote:
> On Tuesday, July 12, 2005 8:17 PM, Matt Domsch wrote:
> > In general, this construct:
> > 
> > > > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > > > -static int inline scsi_device_online(struct scsi_device *sdev)
> > > > -{
> > > > -	return sdev->online;
> > > > -}
> > > > -#endif
> > 
> > is better tested as:
> > 
> > #ifndef scsi_device_inline
> > static int inline scsi_device_online(struct scsi_device *sdev)
> > {
> >     return sdev->online;
> > }
> > #endif
> > 
> > when you can.  It cleanly eliminates the version test, and tests for
> > exactly what you're looking for - is this function defined.
> > 
> 
> What you illustrated above is not going to work.
> If your doing #ifndef around a function, such as scsi_device_online, it's
> not going to compile
> when scsi_device_online is already implemented in the kernel tree.
> The routine scsi_device_online is a function, not a define.  For a define
> this would work.

Sure it does, function names are defined symbols.

I'm doing exactly this in my backport of the openipmi drivers to RHEL4
and SLES9.

> I'm trying your example around msleep, msleep_interruptible, and
> msecs_to_jiffies, and 
> my code simply won't compile in SLES9 SP2(-191).  In SLES9 SP1(-139), these
> three routines were not implemented and
> your suggestion works.  I won't be able to to a linux version check as this
> change occurred between service packs
> of the 2.6.5 kernel suse tree.   Anybody on the linux forums have any ideas?
> 
> Example:
> 
> #ifdef msleep

#ifndef  you mean.

> static void inline msleep(unsigned long msecs)
> {
>         set_current_state(TASK_UNINTERRUPTIBLE);
>         schedule_timeout(msecs_to_jiffies(msecs) + 1);
> }
> #endif


Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

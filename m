Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317819AbSGVUtb>; Mon, 22 Jul 2002 16:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSGVUtb>; Mon, 22 Jul 2002 16:49:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13083 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317816AbSGVUt3>; Mon, 22 Jul 2002 16:49:29 -0400
Date: Mon, 22 Jul 2002 16:48:56 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Kurt Garloff <garloff@suse.de>, Pete Zaitcev <zaitcev@redhat.com>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Patch for 256 disks in 2.4
Message-ID: <20020722164856.D19904@devserv.devel.redhat.com>
References: <20020720195729.C20953@devserv.devel.redhat.com> <20020722170840.GB19587@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722170840.GB19587@nbkurt.etpnet.phys.tue.nl>; from garloff@suse.de on Mon, Jul 22, 2002 at 07:08:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 22 Jul 2002 19:08:40 +0200
> From: Kurt Garloff <garloff@suse.de>

> > For those who do not follow, John Cagle allocated 8 more SCSI
> > disk majors.
> 
> Have those officially been assigned to SCSI disks?
> So disks 128 -- 255 have majors 128 thr. 135?

I do not understand what your problem is. Do you refuse to recognise
John as the LANANA chair or something?

My patch is done in accordance with this:
http://www.lanana.org/docs/device-list/devices.txt

> > Here's a patch to make use of them. I am not sure
> > if we want a 2.5 version; it's going to be all devicefs anyhow...
> 
> I've written a patch for sd that makes the allocation of majors
> dynamic. The driver just takes 8 at sd_init and further majors are 
> allocated when disks are attached. Which saves a lot of memory for
> all the gendisk and hd_struct stuff in case you do not have a lot of 
> SCSI disks connected. The patch does support up to 160 SD majors, 
> though currently, it won't succeed getting more than 132 majors.

That's wonderful, but we cannot ship that. There is no userland
support to create device nodes in dynamic fashion and to ensure
that they do not conflict. This is why Arjan filed for and received
additional majors. Dynamic solutions need some time to float about
the community, I think.

BTW, DASD does the same thing already. I never saw any memo or document
explaining how to use this capability properly. Perhaps SuSE people
support it. Kurt, can you tell anything about it?

> Do you have any idea why we can't just sync all mounted filesystems
> in do_emergency_sync()?
>  DASD? LVM? EVMS? MD? Loop? NBD? DRBD? What's the rationale 
> of restricting the sync to only IDE and SCSI? Deadlock avoidance?

I suspect it is a deadlock prevention thing, too. I cannot say if
it ever worked satisfactory... :)

> I'm gonna post my patches tomorrow ...

Thanks, that's interesting. Like I said, they are not likely to
get to the distro soon, but I'd love to look at them.

-- Pete

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131623AbRCOCg5>; Wed, 14 Mar 2001 21:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131619AbRCOCgt>; Wed, 14 Mar 2001 21:36:49 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:45370 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131613AbRCOCgj>; Wed, 14 Mar 2001 21:36:39 -0500
Date: Wed, 14 Mar 2001 21:35:43 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: dledford@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
Message-ID: <20010314213543.A30816@devserv.devel.redhat.com>
In-Reply-To: <3AB028BE.E8940EE6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB028BE.E8940EE6@redhat.com>; from dledford@redhat.com on Wed, Mar 14, 2001 at 09:28:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 14 Mar 2001 21:28:14 -0500
> From: Doug Ledford <dledford@redhat.com>
 
> A bug report I was charged with fixing (qla2x00 driver doesn't see all luns or
> sees multiple identical luns in different scenarios) was not a bug in the
> qla2x00 driver.  [...]
>  The bug is that we were detecting offline devices and linking
> them into the device list.

Why is this a bug? What would happen when I telnet into the
the RAID box and enable my volumes on those LUNs?

>  But, some devices (at least the Clariion raid
> chassis) report luns that don't currently have any device bound to them as
> present but offline.  This meant if we truly scanned all luns then we got
> something like 100+ devices on one ID from this chassis when only 1 might be
> valid:-(

16384 LUNs for Fibre Channel. As you see, scanning is out of the
question. You must issue REPORT LUNs and fall back on scanning
if the device reports a check condition. I did that when I worked
in Sun Storage with A5000/A3500/T3 arrays couple of years ago.

-- Pete

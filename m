Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267666AbUHPOMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUHPOMC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267665AbUHPOMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:12:02 -0400
Received: from magic.adaptec.com ([216.52.22.17]:25512 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S267664AbUHPOLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:11:45 -0400
Message-ID: <4120C093.3070403@adaptec.com>
Date: Mon, 16 Aug 2004 10:11:31 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Greg KH <greg@kroah.com>, martins@au.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: VPD in sysfs
References: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2004 14:11:40.0805 (UTC) FILETIME=[F3950B50:01C4839A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> I've been sent a patch that reads some VPD from the Symbios NVRAM and
> displays it in sysfs.  I'm not sure whether the way the author chose
> to present it is the best.  They put it in 0000:80:01.0/host0/vpd_name
> which seems a bit too scsi-specific and insufficiently forward-looking
> (I bet we want to expose more VPD data than that in the future, so we
> should probably use a directory).
> 
> I actually have a feeling (and please don't kill me for saying this), that
> we should add a struct vpd * to the struct device.  Then we need something
> like the drivers/base/power/sysfs.c file (probably drivers/base/vpd.c)
> that takes care of adding vpd to each device that wants it.
> 
> Thoughts?  Since there's at least four and probably more ways of getting
> at VPD, we either need to fill in some VPD structs at initialisation or
> have some kind of vpd_ops that a driver can fill in so the core can get
> at the data.

I like this idea.  Certain VPD parameters are standard across SCSI devices,
so they could be shown in a standard way.

Not sure on the format of vpd_ops, _but_ getting the VPD data via
the EVPD bit in INQUIRY, could be pretty standard method, so that
if the LLDD doesn't set vpd_ops, they could be set to point to
the (this) generic way*. (The LLDD can snoop the INQUIRY data if
it wishes to, for further control.)

*I.e. the vpd_ops method(s) would be generic enough to abstract out
the actual method of getting the VPD...

Certainly, providing a vpd node in sysfs would help user level
apps id devices more easily.  This could also be used by multipathing
sofware and other apps.  I think it's a good idea.

			Luben



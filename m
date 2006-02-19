Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWBSBZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWBSBZl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 20:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWBSBZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 20:25:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964803AbWBSBZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 20:25:41 -0500
Date: Sun, 19 Feb 2006 01:25:17 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Message-ID: <20060219012517.GW12169@agk.surrey.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <djwong@us.ibm.com>,
	device-mapper development <dm-devel@redhat.com>,
	Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
References: <43F38D83.3040702@us.ibm.com> <20060217151650.GC12173@agk.surrey.redhat.com> <43F6718E.2000908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F6718E.2000908@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:59:58PM -0800, Darrick J. Wong wrote:
> Actually, I was not aware that a device could exist without a table. 
> However, I suppose that geometry is a property of a device, not its 
> underlying configuration, so the forced_geometry is better off in struct 
> mapped_device.
 
There are 0, 1 or 2 tables associated with a device.  dm 
restricts which of them you can address through the ioctl
interface according to the state of the device.
Things are simpler if you can use this ioctl regardless of the state
of the tables, so a device-level one is more appropriate.

> Here's the third revision, with the geometry pushed into mapped_device 
> as well as fixes for the problems that you pointed out wrt string 
> passing, lack of warning messages, etc.  

Much better: I'll do a complete review now, fix up remaining minor things 
and get it submitted.

> Also, the v2 patch should have had the appropriate entries in 
> include/linux/compat_ioctl.h.  Maybe it fell off?  In any case, it is 
> present in this v3.
 
*32 isn't but the other *32 ones are?

[In the userspace patch where you add the ioctl to the list you need to 
use the version number which first included it i.e. 4, 6, 0 and you also
have to add it to the libdm-compat file for v1.]

Alasdair
-- 
agk@redhat.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933122AbWFZXhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122AbWFZXhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933150AbWFZWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:34:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:64987 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933122AbWFZWeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:34:22 -0400
Message-ID: <44A060BD.6090500@watson.ibm.com>
Date: Mon, 26 Jun 2006 18:33:33 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] per-task delay accounting: avoid send without listeners
References: <44A05F4F.8060503@watson.ibm.com>
In-Reply-To: <44A05F4F.8060503@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This applies on top of the rollup of -mm (as of 5:39, 26 Jun 06), over 2.6.17,
that you have provided at
http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2

Using this and not 2.6.17-mm2 due to inclusion of other patches that aren't in -mm2.

This concludes the changes I planned to make and should hopefully address all
the overhead concerns.


Jay,

If there are any remaining overhead issues you see, pls let me know asap.

Thanks,
Shailabh

Shailabh Nagar wrote:
> Don't send taskstats (per-pid or per-tgid) on thread exit when no one is
> listening for such data.
> 
> Currently the taskstats interface allocates a structure, fills it in
> and calls netlink to send out per-pid and per-tgid stats regardless of whether
> a userspace listener for the data exists (netlink layer would check for that
> and avoid the multicast).
> 
> As a result of this patch, the check for the no-listener case is performed
> early, avoiding the redundant allocation and filling up of the taskstats
> structures.
> 
> Signed-off-by: Balbir Singh <balbir@in.ibm.com>
> Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

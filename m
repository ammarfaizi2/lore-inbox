Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVBIBdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVBIBdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVBIBdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:33:12 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:56231 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261732AbVBIBdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:33:08 -0500
Date: Wed, 9 Feb 2005 12:29:00 +1100
From: Nathan Scott <nathans@sgi.com>
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-bk5: XFS: fcron: could not write() buf to disk: Resource temporarily unavailable
Message-ID: <20050209012900.GA1140@frodo>
References: <200502082051.36989.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502082051.36989.gluk@php4.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 08:51:36PM +0300, Alexander Y. Fomichev wrote:
> G' day
> 
> It looks like XFS broken somewhere in 2.6.11-rc1,
> sadly i can't sand "right" bugreport, some facts only.
> Upgrade to 2.6.11-rc2 makes fcron non-working for me in case of 
> crontabs directory is placed on XFS partition.
> When i try to install new crontab fcrontab die with error: 
> "could not write() buf to disk: Resource temporarily unavailable"

Is that an O_SYNC write, do you know?  Or a write to an inode
with the sync flag set?

> The same time it works with 2.6.10.

I'm chasing down a problem similar to this atm, so far looks like
something in the generic VM code below sync_page_range is giving
back EAGAIN, and that is getting passed back out to userspace by
XFS.  Not sure where/why/how its been caused yet though ... I'll
let you know once I have a fix or have found the culprit change.

cheers.

-- 
Nathan

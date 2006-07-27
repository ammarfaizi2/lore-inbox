Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751754AbWG0Xnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbWG0Xnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWG0Xnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:43:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61912 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750706AbWG0Xnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:43:40 -0400
Date: Fri, 28 Jul 2006 09:42:54 +1000
From: Nathan Scott <nathans@sgi.com>
To: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
Message-ID: <20060728094254.F2196410@wobbly.melbourne.sgi.com>
References: <44C8A5F1.7060604@profihost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44C8A5F1.7060604@profihost.com>; from s.priebe@profihost.com on Thu, Jul 27, 2006 at 01:39:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Thu, Jul 27, 2006 at 01:39:29PM +0200, ProfiHost - Stefan Priebe wrote:
> Hello!
> 
> The crash only occurs if you use quota and IDE without barrier support.
> 
> The Problem is, that on a new mount of a root filesystem - the flag 
> VFS_RDONLY is set - and so no barrier check is done before checking 
> quota. With this patch barrier check is done always. The partition 
> should not be mounted at that moment. For mount -o remount, rw or 
> something like this it uses another function where VFS_RDONLY is checked.

Ah, I see.  The patch isn't quite right, I think we will now need to
also add a test to xfs_mountfs_check_barriers() to ensure the device
beneath us is not bdev_read_only().

I'll add that and get the fix merged, thanks.

cheers.

-- 
Nathan

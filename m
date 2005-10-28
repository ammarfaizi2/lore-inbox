Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751949AbVJ1Wqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbVJ1Wqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbVJ1Wqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:46:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48074 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751945AbVJ1Wqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:46:46 -0400
Date: Sat, 29 Oct 2005 08:46:33 +1000
From: Nathan Scott <nathans@sgi.com>
To: AndyLiebman@aol.com
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: What happened to XFS Quota Support?
Message-ID: <20051029084633.A6142170@wobbly.melbourne.sgi.com>
References: <79.50cb86c7.3093fcfa@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <79.50cb86c7.3093fcfa@aol.com>; from AndyLiebman@aol.com on Fri, Oct 28, 2005 at 06:15:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 06:15:22PM -0400, AndyLiebman@aol.com wrote:
> could you be a little clearer on this. What do you mean by "there's a patch  
> already floating around". If I knew where to get the patch, I would have  
> installed it already rather than wasting half a day compiling various flavors of  
> the new kernel (no preemption, voluntary preemption, high preemption). 
>  

Oh, sorry - I was refering to this...

cheers.

-- 
Nathan

----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date: Fri, 28 Oct 2005 22:33:25 +0200
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, nathans@sgi.com,
   linux-xfs@oss.sgi.com, Dimitri Puzin <tristan-777@ddkom-online.de>
User-Agent: Mutt/1.5.11
From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] fix XFS_QUOTA for modular XFS

This patch by Dimitri Puzin submitted through kernel Bugzilla #5514 
fixes the following issue:

Cannot build XFS filesystem support as module with quota support. It 
works only when the XFS filesystem support is compiled into the kernel. 
Menuconfig prevents from setting CONFIG_XFS_FS=m and CONFIG_XFS_QUOTA=y.

How to reproduce: configure the XFS filesystem with quota support as 
module. The resulting kernel won't have quota support compiled into 
xfs.ko.

Fix: Changing the fs/xfs/Kconfig file from tristate to bool lets you 
configure the quota support to be compiled into the XFS module. The 
Makefile-linux-2.6 checks only for CONFIG_XFS_QUOTA=y.


From: Dimitri Puzin <tristan-777@ddkom-online.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1/fs/xfs/Kconfig.old	2005-10-28 19:51:02.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/xfs/Kconfig	2005-10-28 19:51:12.000000000 +0200
@@ -24,7 +24,7 @@
 	default y
 
 config XFS_QUOTA
-	tristate "XFS Quota support"
+	bool "XFS Quota support"
 	depends on XFS_FS
 	help
 	  If you say Y here, you will be able to set limits for disk usage on


----- End forwarded message -----

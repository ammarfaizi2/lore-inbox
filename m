Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUKBQI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUKBQI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUKBQIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 11:08:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4086 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262745AbUKBQGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:06:46 -0500
Date: Tue, 2 Nov 2004 10:03:34 -0600
From: Maneesh Soni <maneesh@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: sysfs backing store error path confusion
Message-ID: <20041102160334.GB3191@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200411020846.iA28kw3g051219@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411020846.iA28kw3g051219@sullivan.realtime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 02:46:58AM -0600, Milton Miller wrote:
> sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
> were expecting NULL.  
> 
> Compile & link tested.  (Yes, changing the callee would be a smaller change).
> 

Thanks for spotting this. But as you said, I will prefer to change the callee.
How about this patch? 

Andrew, Greg, please include this if found ok.

Thanks
Maneesh



o sysfs_new_dirent to retrun NULL if kmalloc fails. Thanks to Milton Miller 
  for spotting this.

Signed-off-by: <maneesh@in.ibm.com>
---

 linux-2.6.10-rc1-bk12-maneesh/fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~fix-sysfs_new_dirent-return fs/sysfs/dir.c
--- linux-2.6.10-rc1-bk12/fs/sysfs/dir.c~fix-sysfs_new_dirent-return	2004-11-02 08:38:57.000000000 -0600
+++ linux-2.6.10-rc1-bk12-maneesh/fs/sysfs/dir.c	2004-11-02 09:17:18.000000000 -0600
@@ -38,7 +38,7 @@ static struct sysfs_dirent * sysfs_new_d
 
 	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
 	if (!sd)
-		return -ENOMEM;
+		return NULL;
 
 	memset(sd, 0, sizeof(*sd));
 	atomic_set(&sd->s_count, 1);
_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266043AbUEUV7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbUEUV7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266044AbUEUV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:59:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35016 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266043AbUEUV7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:59:14 -0400
Date: Fri, 21 May 2004 16:55:18 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Steven Cole <scole@lanl.gov>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.6-bk-current and no CONFIG_SYSFS gives lib/kobject.c:395: error: void value not ignored as it ought to be
Message-ID: <20040521215518.GB14106@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <E256AB9C-A9A0-11D8-A7EA-000A95CC3A8A@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E256AB9C-A9A0-11D8-A7EA-000A95CC3A8A@lanl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 08:29:06AM -0600, Steven Cole wrote:
> Using the current 2.6.6-bk kernel, and without CONFIG_SYSFS,
> I get this error:
> 
>   CC      lib/kobject.o
> lib/kobject.c: In function `kobject_rename':
> lib/kobject.c:395: error: void value not ignored as it ought to be
>   CC      net/core/scm.o
> make[1]: *** [lib/kobject.o] Error 1
> 
> With CONFIG_SYSFS=y, the kernel builds OK.
> 
> 	Steven
> 

The sysfs_rename_dir() interface was changed recently but I forgto to change
the definition if CONFIG_SYSFS is not define. I think the following patch 
should be sufficient.

Thanks
Maneesh


o Fix the definition for sysfs_rename_dir() when CONFIG_SYSFS is not 
  defined.


 include/linux/sysfs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/sysfs.h~fix-CONFIG_SYSFS include/linux/sysfs.h
--- linux-2.6.6-bk6/include/linux/sysfs.h~fix-CONFIG_SYSFS	2004-05-21 16:22:24.000000000 -0500
+++ linux-2.6.6-bk6-maneesh/include/linux/sysfs.h	2004-05-21 16:41:32.000000000 -0500
@@ -80,9 +80,9 @@ static inline void sysfs_remove_dir(stru
 	;
 }
 
-static inline void sysfs_rename_dir(struct kobject * k, const char *new_name)
+static inline int sysfs_rename_dir(struct kobject * k, const char *new_name)
 {
-	;
+	return 0;
 }
 
 static inline int sysfs_create_file(struct kobject * k, const struct attribute * a)

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696

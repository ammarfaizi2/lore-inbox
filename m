Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSGLTEw>; Fri, 12 Jul 2002 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSGLTEv>; Fri, 12 Jul 2002 15:04:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30361 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316848AbSGLTEp>;
	Fri, 12 Jul 2002 15:04:45 -0400
Message-ID: <3D2F28C5.80403@us.ibm.com>
Date: Fri, 12 Jul 2002 12:06:45 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] AFFS fix return without releasing BKL
References: <Pine.LNX.4.44.0207112236330.28515-100000@serv>
Content-Type: multipart/mixed;
 boundary="------------050202000105010605000706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050202000105010605000706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Roman Zippel wrote:
> Hi,
> 
> On Thu, 11 Jul 2002, Dave Hansen wrote:
> 
>>This was found by Dan Carpenter <error27@email.com>, using an smatch
>>script.  Looks to me like like an error caused during all the BKL
>>pushing.  1 more coming...
> 
> Actually lock_kernel() and the test there can be removed completely.

Patch attached to do just that.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------050202000105010605000706
Content-Type: text/plain;
 name="affs-bkl_ret-2.5.25-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="affs-bkl_ret-2.5.25-1.patch"

--- linux-2.5.25-clean/fs/affs/namei.c	Thu Jun 20 15:53:49 2002
+++ linux/fs/affs/namei.c	Fri Jul 12 12:05:24 2002
@@ -342,14 +342,7 @@
 	pr_debug("AFFS: rmdir(dir=%u, \"%.*s\")\n", (u32)dir->i_ino,
 		 (int)dentry->d_name.len, dentry->d_name.name);
 
-	lock_kernel();
-
-	/* WTF??? */
-	if (!dentry->d_inode)
-		return -ENOENT;
-
 	res = affs_remove_header(dentry);
-	unlock_kernel();
 	return res;
 }
 

--------------050202000105010605000706--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317853AbSGKXnF>; Thu, 11 Jul 2002 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317870AbSGKXnE>; Thu, 11 Jul 2002 19:43:04 -0400
Received: from p50886A23.dip.t-dialin.net ([80.136.106.35]:31876 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317853AbSGKXnC>; Thu, 11 Jul 2002 19:43:02 -0400
Date: Thu, 11 Jul 2002 17:45:38 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andreas Dilger <adilger@clusterfs.com>
cc: Thunder from the hill <thunder@ngforever.de>,
       Dawson Engler <engler@csl.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
In-Reply-To: <20020711233226.GC8738@clusterfs.com>
Message-ID: <Pine.LNX.4.44.0207111742400.26269-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Andreas Dilger wrote:
> So, how does adding braces and a linefeed fix the locking problem here?
> ;-)

I did add the contents, they were just not added physically. I have them 
somewhere in my mind...

Index: fs/hpfs/dir.c
===================================================================
RCS file: /var/cvs/thunder-2.5/fs/hpfs/dir.c,v
retrieving revision 1.1
diff -p -u -r1.1 dir.c
--- fs/hpfs/dir.c       19 Jun 2002 02:11:50 -0000      1.1
+++ fs/hpfs/dir.c       11 Jul 2002 23:44:58 -0000	mind
@@ -211,7 +211,10 @@ struct dentry *hpfs_lookup(struct inode

        lock_kernel();
        if ((err = hpfs_chk_name((char *)name, &len))) {
-               if (err == -ENAMETOOLONG) return ERR_PTR(-ENAMETOOLONG);
+               if (err == -ENAMETOOLONG) {
+                       unlock_kernel();
+                       return ERR_PTR(-ENAMETOOLONG);
+               }
                goto end_add;
        }

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbUAUTj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266112AbUAUTj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:39:27 -0500
Received: from sandershosting.com ([69.26.136.138]:14502 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S266109AbUAUTjY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:39:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200401211434.04749@sandersweb.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH-BK-2.6] NTFS fix "du" and "stat" output (NTFS 2.1.6).
Date: Wed, 21 Jan 2004 14:38:57 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <Pine.SOL.4.58.0401191413180.7391@yellow.csi.cam.ac.uk> <200401211318.53776@sandersweb.net>
In-Reply-To: <200401211318.53776@sandersweb.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 January 2004 01:24 pm, David Sanders wrote:
> On Monday 19 January 2004 09:15 am, Anton Altaparmakov wrote:
> > This fixes the erroneous "du" and "stat" output people reported on
> > ntfs partitions containing compressed directories.
>
> Thanks for the quick patch.  There are still problems with the
> reported disk usage.  I use as an example the file win.ini.  With the
> 2.4.24 kernel I get the following results:
> $ ls -l win.ini
> -r--r-----    1 root     staff         399 Jan 27  2003 win.ini
>
> $ stat win.ini
>   File: "win.ini"
>   Size: 399       	Blocks: 2          IO Block: 1024   Regular File
> Device: 305h/773d	Inode: 1023        Links: 1
> Access: (0440/-r--r-----)  Uid: (    0/    root)   Gid: (   50/  
> staff) Access: Thu Jan 15 15:34:09 2004
> Modify: Mon Jan 27 18:54:00 2003
> Change: Sun Sep 22 07:23:44 2002
>
> $ du -h win.ini
> 1.0k	win.ini
>
> But, under the 2.6.1 kernel:
> $ ls -l win.ini
> -r-xr-x---    1 root     staff         399 Jan 27  2003 win.ini
>
> $ stat win.ini
>   File: "win.ini"
>   Size: 399       	Blocks: 0          IO Block: 4096   Regular File
> Device: 305h/773d	Inode: 1023        Links: 1
> Access: (0550/-r-xr-x---)  Uid: (    0/    root)   Gid: (   50/  
> staff) Access: Thu Jan 15 15:34:09 2004
> Modify: Mon Jan 27 18:54:00 2003
> Change: Mon Jan 27 18:54:00 2003
>
> $ du -h win.ini
> 0	win.ini
>
> Now, surely the 2.4.24 kernel is reporting the more accurate disk
> usage since with 2.6.1 it reports 0 blocks (vice 2).
>
> Thanks in advance,
I thought perhaps stat -f output would be usefull:
>From WINNT 4.0
stat -f win.ini
  File: "win.ini"
    ID:        1078931058   (    404F2E72) Namelen:          255 Type: 
NTFS
Blocks: Total:    8385866 Free:    3808839 Available:    3808839 Size: 
512
Inodes: Total:    8385866 Free:    3808839

>From 2.4.24 kernel:
  File: "win.ini"
    ID: 0        0        Namelen: 255     Type: ntfs
Blocks: Total: 8385866    Free: 3808930    Available: 3808930    Size: 
512
Inodes: Total: 40642      Free: 0         

>From 2.6.1 kernel:
  File: "win.ini"
    ID: 404f2e72 90404f42 Namelen: 255     Type: ntfs
Blocks: Total: 1048233    Free: 476116     Available: 476116     Size: 
4096
Inodes: Total: 40642      Free: 95        

-- 
David Sanders
linux@sandersweb.net

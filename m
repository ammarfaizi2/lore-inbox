Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbTCFXM7>; Thu, 6 Mar 2003 18:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCFXM7>; Thu, 6 Mar 2003 18:12:59 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:37136 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP
	id <S261218AbTCFXM4>; Thu, 6 Mar 2003 18:12:56 -0500
Message-ID: <3E67CA0C.4070108@torque.net>
Date: Fri, 07 Mar 2003 09:22:04 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: sysfs mount point permissions in 2.5.64
References: <Pine.LNX.4.33.0303051706020.998-100000@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

Thanks. That patch fixed the problem I reported.

Doug Gilbert


Patrick Mochel wrote:
> On Thu, 6 Mar 2003, Douglas Gilbert wrote:
> 
> 
>>In lk 2.5.64 on my i386 box the sysfs mount point
>>( "/sys") changes permission from:
>>   drwxr-xr-x
>>to
>>   drw-r--r--
>>during the boot process. I didn't notice this feature
>>in lk 2.5.63 . Chmodding the directory back to its former
>>permissions get overridden by subsequent boot sequences.
>>
>>This change in permissions inhibits non-root users from using
>>utilities that scan sysfs for information (e.g. lsscsi).
>>
>>Is this a feature or otherwise?
> 
> 
> This is certainly not intended, and is entirely my fault. The patch below 
> should fix it.
> 
> 	-pat
> 
> ===== fs/sysfs/mount.c 1.5 vs edited =====
> --- 1.5/fs/sysfs/mount.c	Tue Mar  4 12:17:14 2003
> +++ edited/fs/sysfs/mount.c	Wed Mar  5 17:06:25 2003
> @@ -33,7 +33,7 @@
>  	sb->s_op = &sysfs_ops;
>  	sysfs_sb = sb;
>  
> -	inode = sysfs_new_inode(S_IFDIR | S_IRUGO | S_IWUSR);
> +	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
>  	if (inode) {
>  		inode->i_op = &simple_dir_inode_operations;
>  		inode->i_fop = &simple_dir_operations;
> 




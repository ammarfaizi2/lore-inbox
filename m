Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267791AbTBVDU1>; Fri, 21 Feb 2003 22:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbTBVDU1>; Fri, 21 Feb 2003 22:20:27 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:62133 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267791AbTBVDUZ>; Fri, 21 Feb 2003 22:20:25 -0500
Message-ID: <3E56EED8.8070301@blue-labs.org>
Date: Fri, 21 Feb 2003 22:30:32 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS woes continued, 2.5.59 v.s. 2.5.61
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shell -> 2.5.59, serves /home/xxxxx to web/mail server
W/Mail -> 2.5.61, client for /home/xxxx, serves other directories to two 
other clients

Clients, 2.5.61 and 2.5.56, these load the W/Mail exported directories fine.

The /home/xxxx mounts exported by Shell for W/Mail are the problem.  
2.5.59 -> 2.5.61.  Worked fine up until today.

Shell syslog:
Feb 21 22:16:30 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:749 for /home/james (/home/james)
Feb 21 22:16:41 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:753 for /home/hnc (/home/hnc)
Feb 21 22:16:51 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:757 for /home/hnc (/home/hnc)
Feb 21 22:17:02 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:761 for /home/securitynerds (/home/securitynerds)
Feb 21 22:17:13 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:765 for /home/securitynerds (/home/securitynerds)
Feb 21 22:17:23 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:769 for /home/m2k (/home/m2k)
Feb 21 22:17:34 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:773 for /home/m2k (/home/m2k)
Feb 21 22:17:44 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:777 for /home/nexpedition (/home/nexpedition)
Feb 21 22:17:55 james rpc.mountd: authenticated mount request from 
mail.blue-labs.org:781 for /home/nexpedition (/home/nexpedition)
[.....]

W/Mail:
# mount -t nfs -a
mount: wrong fs type, bad option, bad superblock on james:/home/james,
       or too many mounted file systems
mount: wrong fs type, bad option, bad superblock on james:/home/hnc,
       or too many mounted file systems
mount: wrong fs type, bad option, bad superblock on 
james:/home/securitynerds,
       or too many mounted file systems
mount: wrong fs type, bad option, bad superblock on james:/home/m2k,
       or too many mounted file systems
mount: wrong fs type, bad option, bad superblock on james:/home/nexpedition,
       or too many mounted file systems

syslog:
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs: server james not responding, timed out
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
nfs: server james not responding, timed out
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs: server james not responding, timed out
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
nfs: server james not responding, timed out
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs: server james not responding, timed out
nfs_get_root: getattr error = 5
nfs_read_super: get root inode failed
nfs warning: mount version older than kernel
nfs: server james not responding, timed out
[....]

2.5.62 is a no-go, OOPS on boot.  I've had too much NFS frustration to 
deal with yet another problem so I haven't posted that OOPS yet.

This NFS issue is pretty important to me since it's a 100% fault 
condition, not a once in a while.

Make that 2.5.61 is also broken (OOPS) on boot.  FSCK.

Ok, trying .60.

David



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbTBACEY>; Fri, 31 Jan 2003 21:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTBACEY>; Fri, 31 Jan 2003 21:04:24 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:64900 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264681AbTBACEX>; Fri, 31 Jan 2003 21:04:23 -0500
Message-ID: <3E3B2D2E.8000604@blue-labs.org>
Date: Fri, 31 Jan 2003 18:13:02 -0800
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
Subject: NFS problems, 2.5.5x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsis:  nfsserver:/home/david mount, get dir. entries loops forever, 
2.5.59 for client and server.

Example:  ls -l /home/david

An strace will show the same directory entries flying by over and over 
until memory is exhausted or ^c comes along.  It worked at first for 
about 30 minutes while I finished the new gentoo install on my desktop, 
but then things got weird.  the nfs server spat out a big long callback 
trace (oops) and died hard.  Had to reset the power.  The looping 
started just minutes before that.  I've rebooted, tried 2.5.53 on the 
client but no go.

Doing a stat on a single file works fine.  Doing a glob, i.e. ls -l on 
the mount directory fails.  Doing ls -l on any sub directory of the 
mount works fine.

ls -la /home/david/.xinitrc (file, works)
ls -la /home/david/.e (directory, works)
ls -la /home/david (loops forever on all directory entries until memory 
is exhausted and ls aborts)

Some things I've noted:

- not all directory entries are repeated, some only appear once and 
never again.
- ls only does this on the mount point of the nfs mounted directory, all 
other directories are fine

GLIBC 2.3.1, underlying filesystems are reiserfs.

Client:
nfsserver:/home/david on /home/david type nfs 
(rw,bg,hard,intr,timeo=7,rsize=16384,wsize=16384,addr=10.0.0.5)

Server (/var/lib/nfs/etab):
/raid/home/david        
hb.blue-labs.org(rw,async,wdelay,hide,secure,no_root_squash,no_all_squash,subtree_check,secure_locks,mapping=identity,anonuid=-2,anongid=-2)


David



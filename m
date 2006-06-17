Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWFQRPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWFQRPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 13:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWFQRPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 13:15:52 -0400
Received: from mx.laposte.net ([81.255.54.11]:49687 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750730AbWFQRPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 13:15:52 -0400
From: sebastien cabaniols <sebastien.cabaniols@laposte.net>
Reply-To: sebastien.cabaniols@laposte.net
Organization: nolit a sinargo
To: linux-kernel@vger.kernel.org
Subject: Need to format twice /dev/ramX with reiserfs to be able to mount it ?
Date: Sat, 17 Jun 2006 19:15:50 +0200
User-Agent: KMail/1.7.2
References: <20060616181419.GA15734@dmt> <il57929b81lja4bb24sj77575vqibu19ev@4ax.com> <20060617071000.GA23498@1wt.eu>
In-Reply-To: <20060617071000.GA23498@1wt.eu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606171915.50843.sebastien.cabaniols@laposte.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I am trying to format with reiserfs a ramdrive /dev/ramX (I want to nfs export 
it, so tmpfs is not an option and ext2/ext3 is not an option for other 
reasons)

After formating is okay I can't mount it, but If I reformat it, I usually can 
mount it. I have also tried after first formating to dump it to a file and to 
loopback mount the file, this works:  I am puzzled.

Here is the sample session:

opteron:/home/seb # mkreiserfs -q /dev/ram8
mkreiserfs 3.6.18 (2003 www.namesys.com)

opteron:/home/seb # mount /dev/ram8 /tmp/mountpoint/
mount: wrong fs type, bad option, bad superblock on /dev/ram8,
       missing codepage or other error
       In some cases useful info is found in syslog - try
       dmesg | tail  or so

opteron:/home/seb # mkreiserfs -q /dev/ram8
mkreiserfs 3.6.18 (2003 www.namesys.com)

opteron:/home/seb # mount /dev/ram8 /tmp/mountpoint/

opteron:/home/seb # df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda5              18G  4.1G   13G  24% /
tmpfs                1004M   12K 1004M   1% /dev/shm
/dev/sda2              79G  9.9G   65G  14% /home
/dev/sda6              18G  2.5G   15G  15% /sys2
/dev/sda7              18G  2.5G   15G  15% /sys3
/dev/sda8              18G  129M   17G   1% /sys4
athlon:/data          111G  103G  1.6G  99% /data
/dev/ram8             125M   33M   93M  26% /tmp/mountpoint
opteron:/home/seb #

The filesystem looks usable (I have copied data into it and used it... it 
looks functionnal)

I tried on several configurations:

32bit kernel 2.6.13-15.10 from SUSE 10 on a centrino laptop.
64bit kernel 2.6.13-15.10 from SUSE 10 on an opteron box.
64bit kernel 2.6.16 from kernel.org on an EMT64 box.

and when mount fails, dmesg tells me the following:

ReiserFS: ram8: warning: sh-2011: read_super_block: can't find a reiserfs 
filesystem on (dev ram8, block 16, size 4096)

ReiserFS: ram8: warning: sh-2021: reiserfs_fill_super: can not find reiserfs 
on ram8
ReiserFS: ram8: found reiserfs format "3.6" with standard journal
ReiserFS: ram8: using ordered data mode
ReiserFS: ram8: journal params: device ram8, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: ram8: checking transaction log (ram8)
ReiserFS: ram8: Using r5 hash to sort names
ReiserFS: ram8: warning: Created .reiserfs_priv on ram8 - reserved for xattr 
storage.

Thanks for any suggestion/idea.

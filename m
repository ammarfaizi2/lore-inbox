Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTH1Q4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbTH1Q4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 12:56:53 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:8564 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263737AbTH1Q4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 12:56:51 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Steven Cole <elenstev@mesatop.com>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, Oleg Drokin <green@namesys.com>,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, demidov <demidov@namesys.com>,
       god@namesys.com
In-Reply-To: <20030828114654.GA1361@backtop.namesys.com>
References: <20030826102233.GA14647@namesys.com>
	 <1061922037.1670.3.camel@spc9.esa.lanl.gov> <3F4BA9E9.4090108@namesys.com>
	 <20030826184114.GP5448@backtop.namesys.com>
	 <1061925286.1666.31.camel@spc9.esa.lanl.gov>
	 <20030828114654.GA1361@backtop.namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062083569.1670.141.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 28 Aug 2003 09:12:49 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 05:46, Alex Zarochentsev wrote:
[snipped]
> > [root@spc1 /]# mount -t reiser4 /dev/hda11 /share_r4
> > [root@spc1 /]# df -T
> > Filesystem    Type   1K-blocks      Used Available Use% Mounted on
> > /dev/hda1     ext3      241116     89449    139219  40% /
> > /dev/hda9     ext3    20556656  16526188   4030468  81% /home
> > none         tmpfs      126784         0    126784   0% /dev/shm
> > /dev/hda8     ext3      241116      4711    223957   3% /tmp
> > /dev/hda6     ext3     3012204   2507596    351592  88% /usr
> > /dev/hda7     ext3      489992     70721    393971  16% /var
> > df: `/share_r4': Value too large for defined data type
> 
> I can't reproduce that.  Do you see df errors each time you mount just created
> reiser4 fs?  Can you provide additional information about your system:
> distro, libc which you used?  
> 
Yes, each time that /dev/hda11 is reiser4 and mounted, I get that error.
Other fs report OK, tested were ext2, ext3, reiserfs, jfs, xfs.  Size
is about 4G.  At some point in the past, around 2.5.60, I tested the
reiser4 snapshot, and this problem did not exist.  Unfortunately, I
don't remember what the base distro was for those tests.

Distro is Red Hat Severn (the latest RH beta).
df --version reports df (coreutils) 5.0
/lib/libc.so.6 reports 2.3.2
gcc is 3.3
kernel is 2.6.0-test4 of course.
reiser4progs is 0.4.12

> My hypothesysis is that libc statfs or df itself want to convert "free inodes"
> result parameter which is __u64 to shorter data type.  reiser4_statfs() sets
> kstatfs->f_ffree to a large value which is close to 2^64.

I also tried a copy of df version 4.5.7 from a Mandrake 9.1 system, with
exactly the same results as above.

Let me know if you have further questions.

Steven



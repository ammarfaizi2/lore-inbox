Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTH1NJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTH1NJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:09:43 -0400
Received: from ns1.beeonline.ru ([195.58.40.10]:56072 "EHLO
	bolsmtpdns1.beeonline.internal") by vger.kernel.org with ESMTP
	id S264072AbTH1NJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:09:39 -0400
Date: Thu, 28 Aug 2003 15:46:55 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Hans Reiser <reiser@namesys.com>, Oleg Drokin <green@namesys.com>,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, demidov <demidov@namesys.com>,
       god@namesys.com
Subject: Re: reiser4 snapshot for August 26th.
Message-ID: <20030828114654.GA1361@backtop.namesys.com>
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <3F4BA9E9.4090108@namesys.com> <20030826184114.GP5448@backtop.namesys.com> <1061925286.1666.31.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061925286.1666.31.camel@spc9.esa.lanl.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 01:14:46PM -0600, Steven Cole wrote:
> On Tue, 2003-08-26 at 12:41, Alex Zarochentsev wrote:
> > On Tue, Aug 26, 2003 at 10:41:45PM +0400, Hans Reiser wrote:
> > > Mr. Demidov, if you put code that does not compile into our tree you 
> > > need to make the config option for it be invisible.
> > 
> > There is such an option already, CONFIG_REISER4_FS_SYSCALL, 
> > seems it is off by default.
> 
> Yes, but I the simple minded user that I am turned it on without reading
> the Kconfig help carefully.  Now, it's off, and it compiles.
> 
> But, now for more interesting stuff:
> 
> [root@spc1 steven]# cd /
> [root@spc1 /]# mkdir share_r4
> [root@spc1 /]# mount -t reiser4 /dev/hda11 /share_r4
> [root@spc1 /]# df -T
> Filesystem    Type   1K-blocks      Used Available Use% Mounted on
> /dev/hda1     ext3      241116     89449    139219  40% /
> /dev/hda9     ext3    20556656  16526188   4030468  81% /home
> none         tmpfs      126784         0    126784   0% /dev/shm
> /dev/hda8     ext3      241116      4711    223957   3% /tmp
> /dev/hda6     ext3     3012204   2507596    351592  88% /usr
> /dev/hda7     ext3      489992     70721    393971  16% /var
> df: `/share_r4': Value too large for defined data type

I can't reproduce that.  Do you see df errors each time you mount just created
reiser4 fs?  Can you provide additional information about your system:
distro, libc which you used?  

My hypothesysis is that libc statfs or df itself want to convert "free inodes"
result parameter which is __u64 to shorter data type.  reiser4_statfs() sets
kstatfs->f_ffree to a large value which is close to 2^64.

> 
> I have recently run mkfs.reiser4 on /dev/hda11 with no options.
> The reiser4progs version is 0.4.12.
> 
> I made a local clone of the 2.6-test bk tree on the new reiser4
> file system and that worked OK.
> 
> I then did a "time bk -r check -acv", twice for both reiser4 and ext3.
> Here are the results for the second run for each (I neglected to
> preserve the results for the initial bk -r check -acv):
> 
> Reiser4:
> real    1m27.774s
> user    0m33.685s
> sys     0m16.059s
> 
> Ext3:
> real    2m55.179s
> user    0m32.752s
> sys     0m5.835s
> 
> Nice work.  I'll try to break Reiser4 now.
> 
> Steven
> 
> 
> 
> 

-- 
Alex.

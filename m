Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVIQPWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVIQPWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIQPWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:22:48 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:52813 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1751116AbVIQPWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:22:47 -0400
Date: Sat, 17 Sep 2005 17:22:45 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
In-Reply-To: <20050916.155919.41629794.davem@redhat.com>
Message-ID: <Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
 <20050915.133026.21581824.davem@davemloft.net> <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
 <20050916.155919.41629794.davem@redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1769643842-1126970565=:5000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1769643842-1126970565=:5000
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 16 Sep 2005, David S. Miller wrote:

> From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
> Date: Fri, 16 Sep 2005 14:42:56 +0200 (CEST)
>
>> On Thu, 15 Sep 2005, David S. Miller wrote:
>>
>>> I wonder if the NFS daemon code needs to have some limits put on
>>> how much cpu it consumes handling requests before it gives up the
>>> cpu.  Perhaps, it has such throttling already, I don't know.
>>
>> But this not case NFS server but NSF client. During this lookups I observe
>> rpciod takes 90-99% time of single processor. Load is between 10 and 20.
>
> After studying some code yesterday, NFS client has the same
> exact problem as NFS daemon, namely that if you give it enough
> work it will never give up the cpu so that other tasks can
> be scheduled.
>
> This is a serious bug, and can easily trigger those soft lockup
> messages.  Based upon some other reports seen on linux-kernel
> and elsewhere, things like the raid1 kernel daemon have a similar
> issue as well.
>
> I think you can help things _enormusly_ by turning off SLAB
> poisioning, as I said that debugging feature is _VERY_ expensive.

I'll try.

Now I have next call trace catched during reboot system after perform full 
backup on NFS volume (during this as previouse was tons of lookups). This 
case was during umounting NFS volumes (on system shutdown). Below call 
trace may have some typos because I read tem from screen and write on 
paper:

Badness in interruptible_sleep_on_timeout at kernel/shed.c: 3403 (Not tainted)
Call trace:
[00000000021c3cf8] nfs_kill_super+0x8c/0xbc [nfs]
[00000000004962d4] deactivate_super+0x58/0x7c
[00000000004ac5cc] sys_umount+0x2f8/0x308
[0000000000410fd4] linux_sparc_syscall32_0x34/0x40
[0000000000011ebc] 0x11ebc

Above may be is some resoult corrupting something during soft lookupus but 
if not probably may be usefull on finding bugs.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1769643842-1126970565=:5000--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbSJBKnm>; Wed, 2 Oct 2002 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbSJBKnm>; Wed, 2 Oct 2002 06:43:42 -0400
Received: from stingr.net ([212.193.32.15]:17673 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S263033AbSJBKnl>;
	Wed, 2 Oct 2002 06:43:41 -0400
Date: Wed, 2 Oct 2002 14:48:59 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021002104859.GD6318@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20021001204330.GO3000@clusterfs.com>
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Andreas Dilger:
> Why do you think data=writeback is better than data=journal?  If the
> files have no data then it should not make a difference.

It is better than default data=ordered I think :)

Thanks for detailed explanation - it saved much time for me and
accortind to yours directions I have recalculated my test. Now ext3 is
better :)

e3
create		2m49.545s	0m4.162s	2m20.766s
delete		2m8.155s	0m3.614s	1m34.945s

reiser
create		3m13.577s	0m4.338s	2m54.026s
delete		4m39.249s	0m3.968s 	4m16.297s

e3
create		2m50.766s	0m4.024s	2m21.197s
delete		2m8.755s	0m3.501s	1m35.737s

reiser
create		3m13.015s	0m4.432s	2m53.412s
delete		4m41.011s	0m3.893s	4m16.845s


this is two typical runs. Now I creating ext3 with
mke2fs -j -O dir_index -J size=192 -T news /dev/sda4

as you can see, this improves performance by 1/4

Unfortunately, there still one issue in ext3. It called "inode limit".
Initially I wanted to run this test on 1000000 files but ... I hit
inode limit and don't want to increase it artificially yet.

Reiserfs worked fine because it don't have such kind of limit ...

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)

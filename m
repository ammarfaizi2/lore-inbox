Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJ1ACc>; Sun, 27 Oct 2002 19:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSJ1ACc>; Sun, 27 Oct 2002 19:02:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:33253 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262214AbSJ1ACb>;
	Sun, 27 Oct 2002 19:02:31 -0500
Message-ID: <3DBC800C.D474D9A3@digeo.com>
Date: Sun, 27 Oct 2002 16:08:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gregory K. Ade" <gregory@castandcrew.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bizzare slowdowns and hangs w/ 2.4.18, 2.4.19
References: <1035762024.3397.53.camel@gopher>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2002 00:08:44.0447 (UTC) FILETIME=[2DE9C2F0:01C27E16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gregory K. Ade" wrote:
> 
> 8GB RAM
> ...
> `find /` will drag it to it's knees
>

Run `grep inode /proc/slabinfo' and `cat /proc/meminfo'.  You're
probably running into the problem wherein all of lowmem is full
of inodes which are pinned by highmem pagecache.

If so then this:
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc5aa1/10_inode-highmem-2
will fix it.

Please test it and send a report.  It's time to get that into
Marcelo.

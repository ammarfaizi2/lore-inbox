Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265224AbSJWUiX>; Wed, 23 Oct 2002 16:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSJWUiW>; Wed, 23 Oct 2002 16:38:22 -0400
Received: from packet.digeo.com ([12.110.80.53]:3053 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265224AbSJWUiV>;
	Wed, 23 Oct 2002 16:38:21 -0400
Message-ID: <3DB70A2A.A09270A9@digeo.com>
Date: Wed, 23 Oct 2002 13:44:26 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball comparedforvarious  
 fs.
References: <3DB6FF24.9B50A7C0@digeo.com> <1035405140.13083.268.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2002 20:44:26.0458 (UTC) FILETIME=[F9EE13A0:01C27AD4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> ...
> OK, here is the ext2 data.  This was done on my /tmp partition.
> 
> For ext2, the variation between runs was as much as between
> mm3 and ac2.  This data is from the first of 4 runs as before.
> 
> Steven
> 
> ext2
> tar zxf linux-2.5.44.tar.gz     2.5.44-mm3      2.5.44-ac2
> user                            4.17            4.16
> system                          2.76            2.7
> elapsed                         00:08.39        00:08.05
> % CPU                           82              85
> 

OK, so I assume what's happening here is that the entire uncompressed
kernel fits into 40% of your memory.

So we see 4 seconds user time from doing the gzip decompression
and three seconds system time; a little from reading the
tarball and most of it is creating a ton of dirty pagecache.

But most of the real cost has not been measured: getting that
dirty pagecache onto disk.  It has to happen sometime...

If you include a "sync" in the timing then you'll see the
benefit from the Orlov allocator.  You'll get that kernel
tree onto disk in half the time.

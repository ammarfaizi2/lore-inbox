Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281004AbRKLVpX>; Mon, 12 Nov 2001 16:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281017AbRKLVpO>; Mon, 12 Nov 2001 16:45:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58892 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281004AbRKLVpF>; Mon, 12 Nov 2001 16:45:05 -0500
Message-ID: <3BF04289.8FC8B7B7@zip.com.au>
Date: Mon, 12 Nov 2001 13:43:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF03402.87D44589@zip.com.au>,
		<3BF02702.34C21E75@zip.com.au>,
		<00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
		<3BEFF9D1.3CC01AB3@zip.com.au>
		<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> 
		<3BF02702.34C21E75@zip.com.au>
		<1005595583.13307.5.camel@jen.americas.sgi.com> 
		<3BF03402.87D44589@zip.com.au> <1005600431.13303.10.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> ...
> 
> I tried an experiment which puzzled me somwhat:
> 
> >  mount /xfs
> >  cd /xfs/lord/xfs-linux
> >  time tar cf /dev/null linux
> 
> real    0m7.743s
> user    0m0.510s
> sys     0m1.380s
> 
> > hdparm -t /dev/sda5
> 
> /dev/sda5:
>  Timing buffered disk reads:  64 MB in  3.76 seconds = 17.02 MB/sec
> 
> > du -sk linux
> 173028  linux
> 
> The tar got ~21 Mbytes/sec.
>

It's tar.  It cheats.  It somehow detects that the
output is /dev/null, and so it doesn't read the input files.
I think.

akpm-1:/opt> l
total 562884
-rw-r--r--    1 akpm     akpm     575785370 Apr  8  2001 backup

akpm-1:/opt> time tar cf /dev/null backup
tar cf /dev/null backup  0.02s user 0.00s system 4% cpu 0.422 total

That's 570 megs in 0.4 seconds.  Impressive.

So I just use
	time (find dir -type f | xargs cat > /dev/null)

> In our cvs tree cmd/xfsprogs/tests/src/fsstress.c

OK, thanks.

-

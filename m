Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263751AbSJHUhg>; Tue, 8 Oct 2002 16:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263725AbSJHUh3>; Tue, 8 Oct 2002 16:37:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:17131 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263751AbSJHUgt>;
	Tue, 8 Oct 2002 16:36:49 -0400
Message-ID: <3DA34330.7D170231@digeo.com>
Date: Tue, 08 Oct 2002 13:42:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Chris Wedgwood <cw@f00f.org>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org> <20021008195332.GA2313@citd.de> <3DA339FF.4DCEF31E@digeo.com> <20021008203433.GA2576@citd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 20:42:24.0136 (UTC) FILETIME=[34D2F880:01C26F0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> 
> ...
> I use a program called VDR. This is for recording digital-TV-program
> from satallite.
> 
> After a recording is finished i cut the recordings. I my case i "stream"
> the input-data via NFS from the recording machine(s) through a converter
> into the local temporary directory. After i have enough files i create
> ISO-images of the files. When i create an ISO-images i "stream" the
> files from HDD1 to HDD2 because otherwise it would completly kill the
> performance. Then i burn the ISO-Image onto a DVD-R.
> 
> Every single part in the whole process trashes the cache.

Right.  You dont have O_DIRECT for NFS and you control the
application.  You need O_STREAMING.  Or posix_fadvise(), which
would be significantly harder to use and is not really implementable
in 2.4.

Any magical kernel voodoo which reads your mind and drops that
cache early would probably help, but there's no way in which it
can be as effective as an explicit hint.

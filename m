Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263543AbSJHT7D>; Tue, 8 Oct 2002 15:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbSJHT57>; Tue, 8 Oct 2002 15:57:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:37865 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262676AbSJHT5g>;
	Tue, 8 Oct 2002 15:57:36 -0400
Message-ID: <3DA339FF.4DCEF31E@digeo.com>
Date: Tue, 08 Oct 2002 13:03:11 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: Chris Wedgwood <cw@f00f.org>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy> <20021008190513.GA4728@tapu.f00f.org> <20021008195332.GA2313@citd.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 20:03:11.0495 (UTC) FILETIME=[BA8A7170:01C26F05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> 
> ...
> I only have 3 GB of RAM, and creating and writing trashes the whole
> cache twice.

That's actually something completely dumb and irritating which
Linux has done for ever ;)

What we need is to detect the situation where someone is linearly
walking through a file which is preposterously too large to cache,
and just start dropping it.

It's not hard to implement the lower machinery to do that - it would
basically be an internal call to posix_fadvise(), which we don't
have but could and perhaps should...

The tricky part is designing the algorithm which decides when to
pull the trigger.

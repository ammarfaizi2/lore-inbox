Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRK1V2E>; Wed, 28 Nov 2001 16:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRK1V1y>; Wed, 28 Nov 2001 16:27:54 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13068 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280718AbRK1V1o>; Wed, 28 Nov 2001 16:27:44 -0500
Message-ID: <3C05569F.7A712167@zip.com.au>
Date: Wed, 28 Nov 2001 13:26:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Andreas Dilger <adilger@turbolabs.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C05533D.98DCE6D1@zip.com.au> <Pine.LNX.4.21.0111281802280.15737-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> > ...
> > But so little code is actually using READA at this stage that I didn't
> > bother - I first need to go through those paths and make sure that they
> > are in fact complete, working and useful...
> 
> I've done some experiments in the past which have shown that doing this
> will cause us to almost _never_ do readahead on IO intensive workloads,
> which ended up decreasing performance instead increasing it.

Interesting.  Thanks.

One _could_ make the first readahead page non-READA, and then
make the rest READA.  That way, all block-contiguous requests
will be merged, and any non-contiguous requests will be dropped on
the floor if the request queue is full.  Which is probably what
we want to happen anyway.

Of course the alternative is to slot a little bmap() call into
the readhead logic :)

> Please make sure to extensively test the propagation of READA through the
> pagecache when you do so...

Extensivelytest is my middle name.

-

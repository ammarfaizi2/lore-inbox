Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290669AbSBOTVf>; Fri, 15 Feb 2002 14:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290666AbSBOTVa>; Fri, 15 Feb 2002 14:21:30 -0500
Received: from peace.netnation.com ([204.174.223.2]:8894 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S290669AbSBOTVQ>; Fri, 15 Feb 2002 14:21:16 -0500
Date: Fri, 15 Feb 2002 11:21:11 -0800
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: fsync delays for a long time.
Message-ID: <20020215192111.GB9925@netnation.com>
In-Reply-To: <Pine.SGI.4.31.0202140951330.3076325-100000@fsgi03.fnal.gov> <E16bPqi-0000c5-00@the-village.bc.nu> <3C6C2342.5044B738@zip.com.au> <20020215172436.GA6842@netnation.com> <3C6D5C6E.78047200@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6D5C6E.78047200@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 11:07:26AM -0800, Andrew Morton wrote:

> Simon Kirby wrote:
> > 
> > Not sure if this is related, but I still can't get 2.4 or 2.5 kernels to
> > actually read and write at the same time during a large file copy between
> > two totally separate devices (eg: from hda1 to hdc1).  "vmstat 1" shows
> > reads with no writing for about 6-8 seconds followed by writes with no
> > reading for about 5-6 seconds, repeat.
> 
> That's different.
> 
> It tends to be the case that when the dirty-data-generator hits
> a particular threshold, it blocks while we write out vast amounts
> of data.  So the throughput is very lumpy.
> 
> It's probable that it can be tamed a bit by fiddling with the
> /proc/sys/vm/bdflush parameters. 

I did try fiddling with bdflush, and I was able to get them to read and
write at what looked like the same time, but the resolution of "vmstat 1"
wasn't really good enough to see.  Also, I think the overall throughput
was the same, where as it should be roughly twice as high (shouldn't it
be possible to read and write as fast as the lowest speed of both
drives?).

> > Is there a patch available that could fix this?
> 
> The -aa patches fiddle extensively with the bdflush thresholds and logic.
> There's stuff in there which might addresses this.

I'll take a look at this.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

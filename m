Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSGQTZB>; Wed, 17 Jul 2002 15:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSGQTZB>; Wed, 17 Jul 2002 15:25:01 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:14782 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316579AbSGQTZA>;
	Wed, 17 Jul 2002 15:25:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Lincoln Dale <ltd@cisco.com>
Subject: Re: ext2 performance in 2.5.25 versus 2.4.19pre8aa2
Date: Wed, 17 Jul 2002 21:22:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, Steve Lord <lord@sgi.com>,
       linux-kernel@vger.kernel.org
References: <3D2CFF48.9EFF9C59@zip.com.au> <5.1.0.14.2.20020714202539.022c4270@mira-sjcm-3.cisco.com> <3D325DEB.A9920C12@zip.com.au>
In-Reply-To: <3D325DEB.A9920C12@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UuNL-0004P5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 July 2002 07:30, Andrew Morton wrote:
> Lincoln Dale wrote:
> > 
> > Andrew Morton wanted me to do some benchmarking of large files on ext2
> > filesystems rather than the usual block-device testing
> > i've had some time to do this, here are the results.
> > 
> > one-line summary is that some results are better, some are worse; CPU
> > usage is better in 2.5.25, but thoughput is sometimes worse.
> 
> Well thanks for doing this.  All rather strange though.

One result that seems pretty consistent in these tests is that avoiding the 
page cache is good for about 20% overall throughput improvement.  Which is 
significant, but less than I would have thought if bus bandwidth is the only 
major bottleneck.  Something in the vfs/filesystem/blockio path is still 
eating too much cpu.

Another observation: though only one of the tests hit 100% CPU, total 
throughput is still shows consistent improvement as a result of reducing CPU. 
This should not be, it means there is excessive latency between submission of 
requests, that is, the IO pipes are not being kept full.

-- 
Daniel

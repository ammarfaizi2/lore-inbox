Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUCRUro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUCRUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:47:44 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:46502 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262943AbUCRUrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:47:41 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Chris Mason <mason@suse.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079642001.11057.7.camel@watt.suse.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
	 <1079641026.2447.327.camel@abyss.local>
	 <1079642001.11057.7.camel@watt.suse.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079642801.2447.369.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 18 Mar 2004 12:46:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 12:33, Chris Mason wrote:

> Some suse 8.2 kernels had write barriers for IDE, some did not.  If
> you're running any kind of recent suse kernel, you're doing cache
> flushes on fsync with ext3.

I have this kernel:


Linux abyss 2.4.20-4GB #1 Sat Feb 7 02:07:16 UTC 2004 i686 unknown
unknown GNU/Linux

I believe it is reasonably  recent one from Hubert's kernels.

The thing is the performance is different if file grows or it does not.
If it does - we have some 25 fsync/sec. IF we're writing to existing
one, we have some 1600 fsync/sec 

In the former case cache is surely not flushed. 

> > I use 2.6.3 kernel for tests now (It is not the latest I know) 
> > EXT3 file system.
> > 
> > 3WARE has writeback cache setting in both cases. 
> 
> Then it sounds like your 2.4 is doing flushes.  I'd expect this test to
> run very quickly without them.

2.4 does flush in one case but not in other. 2.6 does not do it in ether
case.

I was also surprised to see this simple test case has so different
performance with default and "deadline" IO scheduler   -  1.6 vs 0.5 sec
per 1000 fsync's.




-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCBU5R>; Fri, 2 Mar 2001 15:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129498AbRCBU5I>; Fri, 2 Mar 2001 15:57:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24080 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129495AbRCBU5C>; Fri, 2 Mar 2001 15:57:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: scsi vs ide performance on fsync's
Date: 2 Mar 2001 12:56:52 -0800
Organization: Transmeta Corporation
Message-ID: <97p1ek$10t$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L2.0103021241550.14586-200000@srv2.ecropolis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33L2.0103021241550.14586-200000@srv2.ecropolis.com>,
Jeremy Hansen  <jeremy@xxedgexx.com> wrote:
>
>The SCSI adapter on the raid array is an Adaptec 39160, the raid
>controller is a CMD-7040.  Kernel 2.4.0 using XFS for the filesystem on
>the raid array, kernel 2.2.18 on ext2 on the IDE drive.  The filesystem is
>not the problem, as I get almost the exact same results running this on
>ext2 on the raid array.

Did you try a 2.4.x kernel on both?

2.4.0 has a bad elevator, which may show problems, so please check 2.4.2
if the numbers change. Also, "fsync()" is very different indeed on 2.2.x
and 2.4.x, and I would not be 100% surprised if your IDE drive does
asynchronous write caching and your RAID does not... That would not show
up in bonnie.

Also note how your bonnie file remove numbers for IDE seem to be much
better than for your RAID array, so it is not impossible that your RAID
unit just has a _huge_ setup overhead but good throughput, and that the
IDE numbers are better simply because your IDE setup is much lower
latency. Never mistake throughput for _speed_.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261878AbSJNIaf>; Mon, 14 Oct 2002 04:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261879AbSJNIae>; Mon, 14 Oct 2002 04:30:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:53933 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261878AbSJNIac>;
	Mon, 14 Oct 2002 04:30:32 -0400
Message-ID: <3DAA8200.2AF20C5C@digeo.com>
Date: Mon, 14 Oct 2002 01:36:16 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
CC: linux-audio-dev@music.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] latency performance of 2.4 and 2.5...
References: <3DA6C8A3.2892656@folkwang-hochschule.de> <3DAA7E8F.36B03682@folkwang-hochschule.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 08:36:17.0395 (UTC) FILETIME=[C3805C30:01C2735C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joern Nettingsmeier wrote:
> 
> some new interesting results with 2.5.42:
> 
> http://spunk.dnsalias.org/latencytest/2.5.42/2x256.html
> 
> overall much worse, *but* greatly reduced latency peaks (max. 6 ms) as
> compared to 2.5.41:
> 
> http://spunk.dnsalias.org/latencytest/2.5.41/2x256.html
> 
> here the peaks easily reach 13 ms.

Rather depends on the filesystem.  ext3 does its own write scheduling,
and does stuff inside lock_kernel().  It needs a couple of scheduling
points I guess.

I'd expect ext2 to work OK with preemption, but nobody has really
looked yet.  Unless you're using ftruncate() (grr.)

> i'm not really sure what to make of this....
> can someone explain ?
> 
> andrew, it seems part of your mm patch was merged - is there an updated
> patch around that will add the missing hunks ?

Well 2.5.41 had the big change to the truncate code, which was
a rather important part of this whole effort.  I can't immediately
think of a 2.5.42 change which would do this...

But nobody has really got down and dug out the toolkit on
2.5 scheduling latency.  I guess I should do that soon.

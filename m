Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285150AbRLMTwB>; Thu, 13 Dec 2001 14:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285148AbRLMTvw>; Thu, 13 Dec 2001 14:51:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:28432 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285146AbRLMTvj>; Thu, 13 Dec 2001 14:51:39 -0500
Message-ID: <3C19065C.A0B375B3@zip.com.au>
Date: Thu, 13 Dec 2001 11:49:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Needham, Douglas" <douglas.needham@lmco.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel performance issues 2.4.7 -> 2.4.17-pre8
In-Reply-To: <1B7FCD9C07D3D4118FC500508BDF42E80457DFB1@emss09m02.ems.lmco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Needham, Douglas" wrote:
> 
> ...
>         Overall I discovered that the Red Hat modified kernel beat the stock
> kernel hands down in throughput.  Both the base Red Hat 7.2 kernel and the
> 7.2 update kernel (2.4.7-9, 2.4.9-13 respectively) had far better throughput
> than the .10, .15, .14, .16, and .17-pre8 kernels.
> 

The 60% drop in bonnie throughput going from 2.4.9 to 2.4.10 indicates that
something strange has happened.  This hasn't been observed by others.

My suspicion would be that something is wrong with the IDE tuning in your
builds of later kernels.  Please check this with `hdparm -t /dev/hda1' - make
sure that these numbers are consistent across kernel versions before you
even start.

Note: before running the hdparm test on hda1, you should mount a 4k blocksize
filesystem onto hda1.  This changes the softblocksize for the device from 1k
to 4k and, for some devices, speeds up access to the block device by
a factor of thirty.  This is some bizarro kooky brokenness which the
2.4.10 patch exposed and I'm still investigating...

For dbench, errr, just don't bother using it, unless you're using
a large number of clients - 64 or more.  At lower client numbers,
throughput is enormously dependent upon tiny changes in kernel
behaviour.   Try this:

	echo 70 64 64 256 30000 3000 80 0 0 > /proc/sys/vm/bdflush

and see the numbers go up greatly.

-

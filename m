Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSJHJQp>; Tue, 8 Oct 2002 05:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSJHJQp>; Tue, 8 Oct 2002 05:16:45 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:26578 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S261565AbSJHJQo>; Tue, 8 Oct 2002 05:16:44 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: experiences with 2.5.40 on a busy usenet news server
Date: Tue, 8 Oct 2002 10:22:33 +0100
User-Agent: KMail/1.4.7
References: <anu60s$oev$1@ncc1701.cistron.net>
In-Reply-To: <anu60s$oev$1@ncc1701.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210081022.33946.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 9:46 am, Miquel van Smoorenburg wrote:
> Just FYI:
>
> So I booted 2.5.40 with the raid0 fix on our usenet news peering
> server yesterday. It is a box that exchanges binary feeds with
> about 40 peers, 400 GB/day in, 600 GB/day out.
>
> It's a dual PIII/450, 1 GB RAM, 4x18 GB article spool directly
> on partitions (not raw, but normal partitions). INN-2.4/CNFS.
>
> With 2.4.19, it runs fine. With 2.5.40, it goes wildly into
> swap. I'm assuming the I/O is pushing the newsserver binaries
> and database mappings into swap.
>
> # free
>              total       used       free     shared    buffers     cached
> Mem:       1033308    1027316       5992          0     836884      29776
> -/+ buffers/cache:     160656     872652
> Swap:       976888     364032     612856
>
> No need to swap 364 MB when there's 872 MB still free...
> This makes the machine dogslow. An 'expire' process that
> runs every night normally takes 15 minutes to finish now
> has been running for 10 hours and its still not finished.
>
> Article acceptance rate has halved, the machine can't keep up
> with the binaries it is fed.
>
> I'm going to risk corrupting the databases and reboot back
> to 2.4.19 now.
>
You might want to try 2.5.40-mm2

[snip]
- Started work on /proc/sys/vm/swappiness.  Setting it to 100% gives
  you current 2.5 behaviour.  Setting it to 0 feels pretty similar to
  2.4.19.
[snip]

then you would be able to test different swap behaviours

i.e echo 0 > /proc/sys/vm/swappiness for 2.4.19 behaviour

Nick

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSJPLOq>; Wed, 16 Oct 2002 07:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264648AbSJPLOq>; Wed, 16 Oct 2002 07:14:46 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:58119 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S262395AbSJPLOp>;
	Wed, 16 Oct 2002 07:14:45 -0400
Date: Wed, 16 Oct 2002 20:09:00 +0900 (JST)
Message-Id: <20021016.200900.128068491.taka@valinux.co.jp>
To: neilb@cse.unsw.edu.au
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <15788.57476.858253.961941@notabene.cse.unsw.edu.au>
References: <15786.23306.84580.323313@notabene.cse.unsw.edu.au>
	<20021014.210144.74732842.taka@valinux.co.jp>
	<15788.57476.858253.961941@notabene.cse.unsw.edu.au>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > It will be effective on large scale SMP machines as all kNFSd shares
> > one NFS port. A udp socket can't send data on each CPU at the same
> > time while MSG_MORE/UDP_CORK options are set.
> > The UDP socket have to block any other requests during making a UDP frame.
> > 

> After thinking about this some more, I suspect it would have to be
> quite large scale SMP to get much contention.

I have no idea how much contention will happen. I haven't checked the
performance of it on large scale SMP yet as I don't have such a great
machines.

Does anyone help us?

> The only contention on the udp socket is, as you say, assembling a udp
> frame, and it would be surprised if that takes a substantial faction
> of the time to handle a request.

After assembling a udp frame, kNFSd may drive a NIC to transmit the frame.

> Presumably on a sufficiently large SMP machine that this became an
> issue, there would be multiple NICs.  Maybe it would make sense to
> have one udp socket for each NIC.  Would that make sense? or work?

Some CPUs often share one GbE NIC today as a NIC can handle much data
than one CPU can. I think that CPU seems likely to become bottleneck.
Personally I guess several CPUs will share one 10GbE NIC in the near
future even if it's a high end machine. (It's just my guess)

But I don't know how effective this patch works......

devem> Doesn't make much sense.
devem> 
devem> Usually we are talking via one IP address, and thus over
devem> one device.  It could be using multiple NICs via BONDING,
devem> but that would be transparent to anything at the socket
devem> level.
devem> 
devem> Really, I think there is real value to making the socket
devem> per-cpu even on a 2 or 4 way system.

I wish so.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSJWJdw>; Wed, 23 Oct 2002 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbSJWJdw>; Wed, 23 Oct 2002 05:33:52 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:30225 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S263281AbSJWJaf>;
	Wed, 23 Oct 2002 05:30:35 -0400
Date: Wed, 23 Oct 2002 18:29:25 +0900 (JST)
Message-Id: <20021023.182925.15272672.taka@valinux.co.jp>
To: habanero@us.ibm.com
Cc: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200210221616.23282.habanero@us.ibm.com>
References: <004d01c276bb$39b32980$2a060e09@beavis>
	<20021020.053424.41629995.taka@valinux.co.jp>
	<200210221616.23282.habanero@us.ibm.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > > Congestion avoidance mechanism of NFS clients might cause this
> > > > situation.  I think the congestion window size is not enough
> > > > for high end machines.  You can make the window be larger as a
> > > > test.

> I don't think it is a client congestion issue at this point.  I can run the 
> test with just one client on UDP and achieve 11.2 MB/sec with just one mount 
> point.  The client has 100 Mbit Ethernet, so should be the upper limit (or 
> really close).  In the 40 client read test, I have only achieved 2.875 MB/sec 
> per client.  That and the fact that there are never more than 2 nfsd threads 
> in a run state at one time (for UDP only) leads me to believe there is still 
> a scaling problem on the server for UDP.  I will continue to run the test and 
> poke a prod around.  Hopefully something will jump out at me.  Thanks for all 
> the input!

Can You check /proc/net/rpc/nfsd which shows how many NFS requests have
been retransmitted ?

# cat /proc/net/rpc/nfsd
rc 0 27680 162118
  ^^^
This field means the clinents have retransmitted pakeckets.
The transmission ratio will slow down if it have happened once.
It may occur if the response from the server is slower than the
clinents expect.

And you can use older version - e.g. linux-2.4 series - for clients
and see what will happen as older versions don't have any intelligent
features.

Thank you,
Hirokazu Takahashi.

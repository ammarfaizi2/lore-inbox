Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSJSUfp>; Sat, 19 Oct 2002 16:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSJSUfp>; Sat, 19 Oct 2002 16:35:45 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:16140 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S265670AbSJSUfo>;
	Sat, 19 Oct 2002 16:35:44 -0400
Date: Sun, 20 Oct 2002 05:34:24 +0900 (JST)
Message-Id: <20021020.053424.41629995.taka@valinux.co.jp>
To: habanero@us.ibm.com
Cc: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <004d01c276bb$39b32980$2a060e09@beavis>
References: <shs8z0w1f3k.fsf@charged.uio.no>
	<20021018.161952.41628057.taka@valinux.co.jp>
	<004d01c276bb$39b32980$2a060e09@beavis>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Congestion avoidance mechanism of NFS clients might cause this
> > situation.  I think the congestion window size is not enough
> > for high end machines.  You can make the window be larger as a
> > test.

> Is this a concern on the client only?  I can run a test with just one client
> and see if I can saturate the 100Mbit adapter.  If I can, would we need to
> make any adjustments then?  FYI, at 115 MB/sec total throughput, that's only
> 2.875 MB/sec for each of the 40 clients.  For the TCP result of 181 MB/sec,
> that's 4.525 MB/sec, IMO, both of which are comfortable throughputs for a
> 100Mbit client.

I think it's a client issue. NFS servers don't care about cogestion of UDP
traffic and they will try to response to all NFS requests as fast as they can.

You can try to increase the number of clients or the number of mount points
for a test. It's easy to mount the same directory of the server on some
directries of the client so that each of them can work simultaneously.
   # mount -t nfs server:/foo   /baa1
   # mount -t nfs server:/foo   /baa2
   # mount -t nfs server:/foo   /baa3

Thank you,
Hirokazu Takahashi.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbSJVVKR>; Tue, 22 Oct 2002 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSJVVKR>; Tue, 22 Oct 2002 17:10:17 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:49853 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264860AbSJVVKJ> convert rfc822-to-8bit; Tue, 22 Oct 2002 17:10:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Date: Tue, 22 Oct 2002 16:16:23 -0500
User-Agent: KMail/1.4.3
Cc: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, davem@redhat.com,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <shs8z0w1f3k.fsf@charged.uio.no> <004d01c276bb$39b32980$2a060e09@beavis> <20021020.053424.41629995.taka@valinux.co.jp>
In-Reply-To: <20021020.053424.41629995.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210221616.23282.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 October 2002 15:34, Hirokazu Takahashi wrote:
> Hello,
>
> > > Congestion avoidance mechanism of NFS clients might cause this
> > > situation.  I think the congestion window size is not enough
> > > for high end machines.  You can make the window be larger as a
> > > test.
> >
> > Is this a concern on the client only?  I can run a test with just one
> > client and see if I can saturate the 100Mbit adapter.  If I can, would we
> > need to make any adjustments then?  FYI, at 115 MB/sec total throughput,
> > that's only 2.875 MB/sec for each of the 40 clients.  For the TCP result
> > of 181 MB/sec, that's 4.525 MB/sec, IMO, both of which are comfortable
> > throughputs for a 100Mbit client.
>
> I think it's a client issue. NFS servers don't care about cogestion of UDP
> traffic and they will try to response to all NFS requests as fast as they
> can.
>
> You can try to increase the number of clients or the number of mount points
> for a test. It's easy to mount the same directory of the server on some
> directries of the client so that each of them can work simultaneously.
>    # mount -t nfs server:/foo   /baa1
>    # mount -t nfs server:/foo   /baa2
>    # mount -t nfs server:/foo   /baa3

I don't think it is a client congestion issue at this point.  I can run the 
test with just one client on UDP and achieve 11.2 MB/sec with just one mount 
point.  The client has 100 Mbit Ethernet, so should be the upper limit (or 
really close).  In the 40 client read test, I have only achieved 2.875 MB/sec 
per client.  That and the fact that there are never more than 2 nfsd threads 
in a run state at one time (for UDP only) leads me to believe there is still 
a scaling problem on the server for UDP.  I will continue to run the test and 
poke a prod around.  Hopefully something will jump out at me.  Thanks for all 
the input!

Andrew Theurer

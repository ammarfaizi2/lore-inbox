Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265485AbSJXPTn>; Thu, 24 Oct 2002 11:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSJXPTn>; Thu, 24 Oct 2002 11:19:43 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:63414 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S265485AbSJXPTj>; Thu, 24 Oct 2002 11:19:39 -0400
Message-ID: <00a201c27b72$83ab8760$2a060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Hirokazu Takahashi" <taka@valinux.co.jp>
Cc: <trond.myklebust@fys.uio.no>, <neilb@cse.unsw.edu.au>, <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>, <nfs@lists.sourceforge.net>
References: <004d01c276bb$39b32980$2a060e09@beavis><20021020.053424.41629995.taka@valinux.co.jp><200210221616.23282.habanero@us.ibm.com> <20021023.182925.15272672.taka@valinux.co.jp>
Subject: Re: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Date: Thu, 24 Oct 2002 10:32:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't think it is a client congestion issue at this point.  I can run
the
> > test with just one client on UDP and achieve 11.2 MB/sec with just one
mount
> > point.  The client has 100 Mbit Ethernet, so should be the upper limit
(or
> > really close).  In the 40 client read test, I have only achieved 2.875
MB/sec
> > per client.  That and the fact that there are never more than 2 nfsd
threads
> > in a run state at one time (for UDP only) leads me to believe there is
still
> > a scaling problem on the server for UDP.  I will continue to run the
test and
> > poke a prod around.  Hopefully something will jump out at me.  Thanks
for all
> > the input!
>
> Can You check /proc/net/rpc/nfsd which shows how many NFS requests have
> been retransmitted ?
>
> # cat /proc/net/rpc/nfsd
> rc 0 27680 162118
>   ^^^
> This field means the clinents have retransmitted pakeckets.
> The transmission ratio will slow down if it have happened once.
> It may occur if the response from the server is slower than the
> clinents expect.

/proc/net/rpc/nfsd
rc 0 1 1025221

> And you can use older version - e.g. linux-2.4 series - for clients
> and see what will happen as older versions don't have any intelligent
> features.

Actually all of the clients are 2.4 (RH 7.0).  I could change them out to
2.5, but it may take me a little while.

Let me do a little digging around.  I seem to recall an issue I had earlier
this year when waking up the nfsd threads and having most of them just go
back to sleep.  I need to go back to that code and understand it a little
better.   Thanks for all of your help.

Andrew Theurer


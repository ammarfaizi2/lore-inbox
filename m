Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317167AbSFKQgy>; Tue, 11 Jun 2002 12:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317168AbSFKQgx>; Tue, 11 Jun 2002 12:36:53 -0400
Received: from [205.214.34.82] ([205.214.34.82]:43791 "EHLO mail.paxonet.com")
	by vger.kernel.org with ESMTP id <S317167AbSFKQgw>;
	Tue, 11 Jun 2002 12:36:52 -0400
Message-Id: <4.3.1.2.20020611092415.031616a0@coremail>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Tue, 11 Jun 2002 09:28:41 -0700
To: Trond Myklebust <trond.myklebust@fys.uio.no>
From: Simon Matthews <simon@paxonet.com>
Subject: Re: NFS Client mis-behaviour?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <shs8z5lanvf.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

I realize that the transport is hidden to NFS. However, in the situation I 
described, the NFS client did not behave well: it seemed to lock up totally 
for a period of 10-15 minutes.

Other packets were able to make it into and out of the machine: I could 
telnet/ssh/rlogin. The user could not interrupt the process, despite the 
fact that the mount options included "intr".

My point is that the use of half-duplex may prevent the NFS client from 
sending or receiving (probably sending) some packets. But, since the 
processes that caused the load had stopped doing anything and other packets 
were passing in and out, the NFS client should have been able to recover 
earlier.

Simon


At 04:31 PM 6/11/02 +0200, Trond Myklebust wrote:
> >>>>> " " == Simon Matthews <simon@paxonet.com> writes:
>
>      > Solution: the Ethernet interface was connected to a switch that
>      > only supports half-duplex connecting to a full-duplex switch
>      > solved the problem. However, it does seem that the NFS client
>      > was not handling the situation well.
>
>The NFS client neither knows nor cares what is going on down in the
>ethernet layer. As far as it is concerned, you might as well be using
>semaphore to pass messages between the computers.
>
>All the NFS client needs to know is that it should retry the socket
>sendmsg() operation when a certain (user defined) timeout value is
>reached.
>
>Cheers,
>   Trond


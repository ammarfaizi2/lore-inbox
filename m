Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314516AbSDSDWk>; Thu, 18 Apr 2002 23:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314524AbSDSDWj>; Thu, 18 Apr 2002 23:22:39 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:51463 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314516AbSDSDWi>;
	Thu, 18 Apr 2002 23:22:38 -0400
Date: Fri, 19 Apr 2002 12:21:42 +0900 (JST)
Message-Id: <20020419.122142.85422229.taka@valinux.co.jp>
To: trond.myklebust@fys.uio.no
Cc: jakob@unthought.net, davem@redhat.com, ak@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <shspu0x2xro.fsf@charged.uio.no>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>      > Hi, I've been thinking about your comment, and I realized it
>      > was a good suggestion.  There are no problem with the zerocopy
>      > NFS, but If you want to use UDP sendfile for streaming or
>      > something like that, you wouldn't get good performance.
> 
> Surely one can work around this in userland without inventing a load
> of ad-hoc schemes in the kernel socket layer?
> 
> If one doesn't want to create a pool of sockets in order to service
> the different threads, one can use generic methods such as
> sys_readahead() in order to ensure that the relevant data gets paged
> in prior to hogging the socket.

That makes sense.
It would work good enough in many cases, though it would be hard to
make sure that it really exists in core before sendfile().

> There is no difference between UDP and TCP sendfile() in this respect.

Yes.
And it seems to be more important on UDP sendfile().
processes or threads sharing the same UDP socket would affect each other,
while processes or threads on TCP sockets don't care about it as TCP
connection is peer to peer.

Thank you,
Hirokazu Takahashi.

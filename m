Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314575AbSDTHs2>; Sat, 20 Apr 2002 03:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314576AbSDTHs1>; Sat, 20 Apr 2002 03:48:27 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:45577 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314575AbSDTHs1>;
	Sat, 20 Apr 2002 03:48:27 -0400
Date: Sat, 20 Apr 2002 16:47:22 +0900 (JST)
Message-Id: <20020420.164722.90116338.taka@valinux.co.jp>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <E16yUXe-0004qj-00@charged.uio.no>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > And it seems to be more important on UDP sendfile().
> > processes or threads sharing the same UDP socket would affect each other,
> > while processes or threads on TCP sockets don't care about it as TCP
> > connection is peer to peer.
> 
> No. It is not the lack of peer-to-peer connections that gives rise to the 
> bottleneck, but the idea of several threads multiplexing sendfile() through a 
> single socket. Given a bad program design, it can be done over TCP too.
> 
> The conclusion is that the programmer really ought to choose a different 
> design. For multimedia streaming, for instance, it makes sense to use 1 UDP 
> socket per thread rather than to multiplex the output through one socket.

You mean, create UDP sockets which have the same port number? 
Yes we can if we use setsockopt(SO_REUSEADDR).
And it could lead less contention between CPUs.
Sounds good!

Thank you,
Hirokazu Takahashi.

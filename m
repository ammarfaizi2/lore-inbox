Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSDSJTE>; Fri, 19 Apr 2002 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311960AbSDSJTD>; Fri, 19 Apr 2002 05:19:03 -0400
Received: from mons.uio.no ([129.240.130.14]:62860 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S311936AbSDSJTC>;
	Fri, 19 Apr 2002 05:19:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo
To: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH] zerocopy NFS updated
Date: Fri, 19 Apr 2002 11:18:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020416034120.R18116@unthought.net> <shspu0x2xro.fsf@charged.uio.no> <20020419.122142.85422229.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16yUXe-0004qj-00@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19. April 2002 05:21, Hirokazu Takahashi wrote:

> And it seems to be more important on UDP sendfile().
> processes or threads sharing the same UDP socket would affect each other,
> while processes or threads on TCP sockets don't care about it as TCP
> connection is peer to peer.

No. It is not the lack of peer-to-peer connections that gives rise to the 
bottleneck, but the idea of several threads multiplexing sendfile() through a 
single socket. Given a bad program design, it can be done over TCP too.

The conclusion is that the programmer really ought to choose a different 
design. For multimedia streaming, for instance, it makes sense to use 1 UDP 
socket per thread rather than to multiplex the output through one socket.

Cheers,
   Trond

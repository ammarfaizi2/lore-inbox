Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbSJNMHL>; Mon, 14 Oct 2002 08:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261602AbSJNMHL>; Mon, 14 Oct 2002 08:07:11 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:27396 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S261598AbSJNMHL>;
	Mon, 14 Oct 2002 08:07:11 -0400
Date: Mon, 14 Oct 2002 21:01:44 +0900 (JST)
Message-Id: <20021014.210144.74732842.taka@valinux.co.jp>
To: neilb@cse.unsw.edu.au
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <15786.23306.84580.323313@notabene.cse.unsw.edu.au>
References: <20020918.171431.24608688.taka@valinux.co.jp>
	<15786.23306.84580.323313@notabene.cse.unsw.edu.au>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Neil

> > I ported the zerocopy NFS patches against linux-2.5.36.
> 
> hi,
>  I finally got around to looking at this.
>  It looks good.

Thanks!

>  However it really needs the MSG_MORE support for udp_sendmsg to be
>  accepted before there is any point merging the rpc/nfsd bits.
> 
>  Would you like to see if davem is happy with that bit first and get
>  it in?  Then I will be happy to forward the nfsd specific bit.

Yes.

>  I'm bit I'm not very sure about is the 'shadowsock' patch for having
>  several xmit sockets, one per CPU.  What sort of speedup do you get
>  from this?  How important is it really?

It's not so important.

davem> Personally, it seems rather essential for scalability on SMP.

Yes.
It will be effective on large scale SMP machines as all kNFSd shares
one NFS port. A udp socket can't send data on each CPU at the same
time while MSG_MORE/UDP_CORK options are set.
The UDP socket have to block any other requests during making a UDP frame.


Thank you,
Hirokazu Takahashi.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSKZNqM>; Tue, 26 Nov 2002 08:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSKZNqM>; Tue, 26 Nov 2002 08:46:12 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:21379 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S265402AbSKZNqL>;
	Tue, 26 Nov 2002 08:46:11 -0500
Date: Tue, 26 Nov 2002 14:53:22 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ncpfs seems to need the timer init
Message-ID: <20021126135322.GA30362@vana>
References: <200211260411.gAQ4BUo24135@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211260411.gAQ4BUo24135@hera.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 02:12:52AM +0000, Linux Kernel Mailing List wrote:

Linus, please revert this. It is changeset 

alan@lxorguk.ukuu.org.uk|ChangeSet|20021126021252|43411

Timer is already initialized few lines above in the code. If you'll look
through fs/ncpfs/inode.c history, you'll find that I already asked once
for removing this redundant timer initialization, but unfortunately it
found its way to the tree again :-(

I prefer having init_timer() and timeout_tm setup separate, as now
I can safely call del_timer in shutdown without having to test
whether I'm in UDP or TCP code...

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

> ChangeSet 1.842.42.99, 2002/11/25 18:12:52-08:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] ncpfs seems to need the timer init
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.842.42.98 -> 1.842.42.99
> #	    fs/ncpfs/inode.c	1.36    -> 1.37   
> #
> 
>  inode.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> 
> diff -Nru a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
> --- a/fs/ncpfs/inode.c	Mon Nov 25 20:11:32 2002
> +++ b/fs/ncpfs/inode.c	Mon Nov 25 20:11:32 2002
> @@ -575,6 +575,7 @@
>  	} else {
>  		INIT_WORK(&server->rcv.tq, ncpdgram_rcv_proc, server);
>  		INIT_WORK(&server->timeout_tq, ncpdgram_timeout_proc, server);
> +		init_timer(&server->timeout_tm);
>  		server->timeout_tm.data = (unsigned long)server;
>  		server->timeout_tm.function = ncpdgram_timeout_call;
>  	}

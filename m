Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288256AbSAVRcq>; Tue, 22 Jan 2002 12:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288780AbSAVRcg>; Tue, 22 Jan 2002 12:32:36 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:29701 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288256AbSAVRcW>; Tue, 22 Jan 2002 12:32:22 -0500
Date: Tue, 22 Jan 2002 12:32:20 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Fwd: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Message-ID: <20020122123220.A27968@devserv.devel.redhat.com>
In-Reply-To: <200201171351.g0HDpdK05456@bliss.uni-koblenz.de.suse.lists.linux.kernel> <mailman.1011289920.22682.linux-kernel2news@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <mailman.1011289920.22682.linux-kernel2news@redhat.com>; from ak@suse.de on Thu, Jan 17, 2002 at 06:49:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andi Kleen <ak@suse.de>
> Newsgroups: linux-kernel
> Date: 17 Jan 2002 18:49:53 +0100

> --- linux-work/net/sunrpc/xprt.c-o	Mon Oct  8 21:36:07 2001
> +++ linux-work/net/sunrpc/xprt.c	Thu Jan 17 18:44:05 2002
> @@ -1507,6 +1507,13 @@
>  
>  	memset(&myaddr, 0, sizeof(myaddr));
>  	myaddr.sin_family = AF_INET;
> +#define SUNRPC_NONSECURE_PORT 1
> +#ifdef SUNRPC_NONSECURE_PORT
> +	err =  sock->ops->bind(sock, (struct sockaddr *) &myaddr,
> +						sizeof(myaddr));
> +	if (err < 0) 
> +		printk("RPC: cannot bind to a port\n"); 
> +#else 
>  	port = 800;
>  	do {
>  		myaddr.sin_port = htons(port);
> @@ -1516,6 +1523,9 @@
>  
>  	if (err < 0)
>  		printk("RPC: Can't bind to reserved port (%d).\n", -err);
> +
> +#endif
> +
>  
>  	return err;
>  }

Andi, the patch above begs two questions in my mind:

1. Why to bind to 0 (INADDR_ANY) explicitly? My patch does not bind
at all and expects connect() to bind automatically. It is how
userland works and it seems to work here as well.

2. What did you do to increase the number of unnamed devices?
You said the patch "should" work, did that mean you did not test it?

-- Pete

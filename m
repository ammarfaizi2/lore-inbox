Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSJCXUg>; Thu, 3 Oct 2002 19:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJCXUg>; Thu, 3 Oct 2002 19:20:36 -0400
Received: from pina.terra.com.br ([200.176.3.17]:51604 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S261246AbSJCXUe>;
	Thu, 3 Oct 2002 19:20:34 -0400
Date: Thu, 3 Oct 2002 20:26:02 -0300
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021003202602.M3869@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <shsy99f16np.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shsy99f16np.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Fri, Oct 04, 2002 at 12:47:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 12:47:38AM +0200, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > When this happens, there is always a file left in
>      > /var/lib/nfs/sm (normally there are no files in there for none
>      > of the clients, even when they are on) for the hanging box. Is
>      > this normal?
> 
> It means that rpc.statd did not manage to unmonitor the NFS locks
> before it shut down. The reasons for this could be multiple, such as
> for instance if the client crashed and/or rebooted. It might also
> indicate that the server could not be contacted in order to unmonitor
> the lock.

Yes, these hangs only happen with boxes that crash frequently (they
crash because of a wierd and unrelated bug in X, which forces a reboot
usually). 

>      >     kernel:Aug 10 17:39:22 anthem kernel: lockd: cannot monitor
>      >     192.168.99.7
> 
> Means that the kernel was unable to contact rpc.statd, or that was
> unable to contact the server's rpc.statd for some reason.

Hmmm, I wonder if I understand properly. Is the following flow correct
for the RPC request?

    Client Kernel -> Client rpc.statd -> Server rpc.statd -> Server Kernel

> 
> There is nothing in the above to suggest that this must be a kernel
> problem. The fact that you are seeing files in /var/lib/nfs/sm
> in these cases rather suggests that the problem lies with rpc.statd.
> Can you see any reason in your setup why it should be failing?

Not really. The clients run rpc.statd 1.0 and the server, 1.0.1. Should
I start gdbing it to see what is going wrong?

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL

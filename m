Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSJCWmp>; Thu, 3 Oct 2002 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSJCWmp>; Thu, 3 Oct 2002 18:42:45 -0400
Received: from mons.uio.no ([129.240.130.14]:46017 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261387AbSJCWmm>;
	Thu, 3 Oct 2002 18:42:42 -0400
To: Christian Reis <kiko@async.com.br>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
References: <20021003184418.K3869@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Oct 2002 00:47:38 +0200
In-Reply-To: <20021003184418.K3869@blackjesus.async.com.br>
Message-ID: <shsy99f16np.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > When this happens, there is always a file left in
     > /var/lib/nfs/sm (normally there are no files in there for none
     > of the clients, even when they are on) for the hanging box. Is
     > this normal?

It means that rpc.statd did not manage to unmonitor the NFS locks
before it shut down. The reasons for this could be multiple, such as
for instance if the client crashed and/or rebooted. It might also
indicate that the server could not be contacted in order to unmonitor
the lock.

     > We also occasionally get a log message in the server for this
     > box like:

     >     kernel:Aug 10 17:39:22 anthem kernel: lockd: cannot monitor
     >     192.168.99.7

Means that the kernel was unable to contact rpc.statd, or that was
unable to contact the server's rpc.statd for some reason.

     > Trond, can I get you more troubleshooting information, or
     > should I try 2.4.20-pre on server *and* clients? This is a bit
     > wierd, but since I don't know a lot of what went on in the last
     > changes, I'm not sure where to start looking.

There is nothing in the above to suggest that this must be a kernel
problem. The fact that you are seeing files in /var/lib/nfs/sm
in these cases rather suggests that the problem lies with rpc.statd.
Can you see any reason in your setup why it should be failing?

Cheers,
  Trond

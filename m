Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266251AbRHAJxh>; Wed, 1 Aug 2001 05:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266321AbRHAJxR>; Wed, 1 Aug 2001 05:53:17 -0400
Received: from mons.uio.no ([129.240.130.14]:33680 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266251AbRHAJxJ> convert rfc822-to-8bit;
	Wed, 1 Aug 2001 05:53:09 -0400
To: Ragnar =?iso-8859-1?q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: NFS locking bug
In-Reply-To: <20010801040256.H9254@vestdata.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 01 Aug 2001 11:53:08 +0200
In-Reply-To: Ragnar =?iso-8859-1?q?Kj=F8rstad's?= message of "Wed, 1 Aug 2001 04:02:56 +0200"
Message-ID: <shs1ymw14zf.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Ragnar Kjørstad <kernel@ragnark.vestdata.no> writes:

     > This is what I do:
     > * mount NFS filesystem on client1
     > * mount NFS filesystem on client2
     > * lock file on client1
     > * verify that I can not lock the same file on client2
     > * reboot the NFS-server
     > * When I start statd on the nfs-server, I see the following
     >   in the logfiles for the clients:

     >   Jul 31 18:33:55 client rpc.statd[455]: recv_rply: [127.0.0.1]
     >   RPC status 3 Jul 31 18:33:55 client kernel: svc: unknown
     >   procedure (24) Jul 31 18:34:01 client kernel: svc: unknown
     >   procedure (24) Jul 31 18:34:01 client rpc.statd[455]:
     >   recv_rply: [127.0.0.1] RPC status 3 Jul 31 18:34:07 client
     >   kernel: svc: unknown procedure (24) Jul 31 18:34:07 client
     >   rpc.statd[455]: recv_rply: [127.0.0.1] RPC status 3 Jul 31
     >   18:34:13 client kernel: svc: unknown procedure (24) Jul 31
     >   18:34:13 client rpc.statd[455]: recv_rply: [127.0.0.1] RPC
     >   status 3 Jul 31 18:34:19 client rpc.statd[455]: Can't
     >   callback client (100021,1), giving up.

     > * I can no lock the file on client2, even if the client1 still thinks
     >   the file is locked.

     > Is this a bug?

The NLM lock reclaiming code in the stock 2.4.x kernel is
incomplete. Please apply the patch on

   http://www.fys.uio.no/~trondmy/src/2.4.7/linux-2.4.7-reclaim.dif

Cheers,
   Trond

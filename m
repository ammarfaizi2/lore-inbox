Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265044AbRFURFj>; Thu, 21 Jun 2001 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265046AbRFURF3>; Thu, 21 Jun 2001 13:05:29 -0400
Received: from mons.uio.no ([129.240.130.14]:16840 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265043AbRFURFM>;
	Thu, 21 Jun 2001 13:05:12 -0400
To: Blesson Paul <blessonpaul@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RPC vs Socket
In-Reply-To: <20010621052321.24581.qmail@nw171.netaddress.usa.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Jun 2001 15:37:01 +0200
In-Reply-To: Blesson Paul's message of "20 Jun 2001 23:23:21 MDT"
Message-ID: <shsithqx8ci.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Blesson Paul <blessonpaul@usa.net> writes:

     > hi all
     >                       I am in the way of building a new remote
     >                       file system.
     > Presently I decided to use sockets for remote
     > communication. Lately I understood that RPC is used in coda and
     > nfs file systems(is it so).  I want to know the fessibility in
     > using RPC in the new file system.

Should be no problem. The RPC layer is not tied to any particular
filesystem.

On the client, you need to set up struct rpc_procinfo with the
necessary RPC XDR routines, which you then declare to the RPC layer
using a struct rpc_program and a call to rpc_create_client(). See
for instance linux/fs/lockd/mon.c, or linux/fs/nfs/mount_clnt.c...

For the server, things are likely to be a bit more complex in that you
need to declare the routines using structs svc_program, svc_version
and rpc_procinfo (again) and then set up a daemon process. Examples of
use include linux/fs/lockd/svc.c and linux/fs/nfsd/nfssvc.c...

Cheers,
  Trond

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269595AbRHACDM>; Tue, 31 Jul 2001 22:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269597AbRHACDC>; Tue, 31 Jul 2001 22:03:02 -0400
Received: from stine.vestdata.no ([195.204.68.10]:10766 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S269595AbRHACCt>; Tue, 31 Jul 2001 22:02:49 -0400
Date: Wed, 1 Aug 2001 04:02:56 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: NFS locking bug
Message-ID: <20010801040256.H9254@vestdata.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Let me first ask if I've understood this correctly:
Is statd on the NFS-server supposed to keep track of all NFS-clients
that have locks on the server?
And if the NFS-server gets restarted, statd look at the list of clients
that held locks, and notify them about the restart?
And then statd/lockd on the clientside will relock the files, to make
sure no other clients can lock the same file?


This is what I do:
* mount NFS filesystem on client1
* mount NFS filesystem on client2
* lock file on client1
* verify that I can not lock the same file on client2
* reboot the NFS-server
* When I start statd on the nfs-server, I see the following
  in the logfiles for the clients:

  Jul 31 18:33:55 client rpc.statd[455]: recv_rply: [127.0.0.1] RPC status 3 
  Jul 31 18:33:55 client kernel: svc: unknown procedure (24)
  Jul 31 18:34:01 client kernel: svc: unknown procedure (24)
  Jul 31 18:34:01 client rpc.statd[455]: recv_rply: [127.0.0.1] RPC status 3 
  Jul 31 18:34:07 client kernel: svc: unknown procedure (24)
  Jul 31 18:34:07 client rpc.statd[455]: recv_rply: [127.0.0.1] RPC status 3 
  Jul 31 18:34:13 client kernel: svc: unknown procedure (24)
  Jul 31 18:34:13 client rpc.statd[455]: recv_rply: [127.0.0.1] RPC status 3 
  Jul 31 18:34:19 client rpc.statd[455]: Can't callback client (100021,1), giving up.

* I can no lock the file on client2, even if the client1 still thinks
  the file is locked.

Is this a bug?


-- 
Ragnar Kjorstad
Big Storage


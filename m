Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129462AbRBEWhN>; Mon, 5 Feb 2001 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129665AbRBEWhD>; Mon, 5 Feb 2001 17:37:03 -0500
Received: from winds.org ([207.48.83.9]:22532 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129462AbRBEWgu>;
	Mon, 5 Feb 2001 17:36:50 -0500
Date: Mon, 5 Feb 2001 17:35:19 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: NFS stop/start problems (related to datagram shutdown bug?)
Message-ID: <Pine.LNX.4.21.0102051728340.1460-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems recently, on both redhat 6.1 and 7.0 using kernel 2.4.1-ac3, I
ran into this problem:

Stopping NFS says the following in the kernel logs:

nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
nfsd: terminating on signal 9
svc: server socket destroy delayed

And restarting NFS has the following error message:

root:~> /etc/rc.d/init.d/nfs start
Starting NFS services:                                     [  OK  ]
Starting NFS quotas:                                       [  OK  ]
Starting NFS mountd:                                       [  OK  ]
Starting NFS daemon: nfssvc: Address already in use
                                                           [FAILED]

>From that moment forward, the NFS server is completely broken until the system
is rebooted, and other machines respond during a 'mount' by saying,

nfs: server xxx not responding, still trying

When I tried this, the remote computer had unmounted this NFS-served partition
prior to shutting NFS down with '/etc/rc.d/init.d/nfs stop'. I was wondering if
this could be related to that datagram shutdown bug, and maybe if there's a
quick solution in the meantime to kill the socket so that I can restart NFS
without rebooting.

Thanks,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

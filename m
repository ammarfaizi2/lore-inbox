Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293361AbSCJWj7>; Sun, 10 Mar 2002 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293367AbSCJWjt>; Sun, 10 Mar 2002 17:39:49 -0500
Received: from pat.uio.no ([129.240.130.16]:34784 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S293361AbSCJWjk>;
	Sun, 10 Mar 2002 17:39:40 -0500
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <20020309131956.77ebf679.skraw@ithnet.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Mar 2002 23:39:34 +0100
In-Reply-To: <20020309131956.77ebf679.skraw@ithnet.com>
Message-ID: <shswuwkujx5.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:

     > Hello all, I just upgraded a host from 2.2.19 to 2.2.21-pre3
     > and discovered a problem with kernel nfs. Setup is this:

     > knfs-server is 2.4.19-pre2 knfs-client is 2.2.21-pre3

     > First mount some fs (mountpoint /backup). Then go and mount
     > some other fs from the same server (mountpoint /mnt), do some
     > i/o on the latter and umount it again. Now try to access
     > /backup. You see:
     > 1) /backup (as a fs) vanished, you get a stale nfs handle.
     > 2) umount /backup; mount /backup does not work. client tells
     >    "permission denied". server tells "rpc.mountd: getfh failed:
     >    Operation not permitted"

By 'some fs' do you mean ext2?

Not all filesystems work well with knfsd when things start to drop out
of the (d|i)caches. In particular things like /backup == VFAT might
give the above behaviour, since VFAT does not know how to map the NFS
file handles into on-disk inodes.

Cheers,
  Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWCDMSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWCDMSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWCDMSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:18:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39631 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751210AbWCDMSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:18:42 -0500
Date: Sat, 4 Mar 2006 04:16:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #3]
Message-Id: <20060304041647.6894ca62.akpm@osdl.org>
In-Reply-To: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
References: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> These patches make it possible to share NFS superblocks between related mounts,
>  where "related" means on the same server.

On an FC1 machine during initscripts these patches give:


EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 336k freed
Write protecting the kernel read-only data: 787k
VFS: Busy inodes after unmount of nfsd. Self-destruct in 5 seconds.  Have a nice day...
VFS: Busy inodes after unmount of nfsd. Self-destruct in 5 seconds.  Have a nice day...
VFS: Busy inodes after unmount of nfsd. Self-destruct in 5 seconds.  Have a nice day...
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period
VFS: Busy inodes after unmount of nfsd. Self-destruct in 5 seconds.  Have a nice day...

The same happens with just #1 and #2 applied.  The .config is at
http://www.zip.com.au/~akpm/linux/patches/stuff/config-vmm.

The kernel won't compile with just patch #1 applied.  Patches shouldn't go
into git in that manner.


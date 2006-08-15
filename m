Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWHORsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWHORsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWHORsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:48:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030401AbWHORsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:48:40 -0400
Date: Tue, 15 Aug 2006 10:48:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060815104813.7e3a0f98.akpm@osdl.org>
In-Reply-To: <29717.1155662998@warthog.cambridge.redhat.com>
References: <20060815065035.648be867.akpm@osdl.org>
	<20060814143110.f62bfb01.akpm@osdl.org>
	<20060813133935.b0c728ec.akpm@osdl.org>
	<20060813012454.f1d52189.akpm@osdl.org>
	<10791.1155580339@warthog.cambridge.redhat.com>
	<918.1155635513@warthog.cambridge.redhat.com>
	<29717.1155662998@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 18:29:58 +0100
David Howells <dhowells@redhat.com> wrote:

> 
> Next thing to try: Can you do the following:
> 
> 	echo $((0x0200)) >/proc/sys/sunrpc/nfs_debug
> 	ls -l /net/bix
> 	umount /net/bix
> 
> That should print some information about the client and server setup procedure
> into the kernel dmesg log which can then be captured.

SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
--> nfs_init_server()
--> nfs_get_client(bix,192.168.2.33:264,3)
--> nfs_get_client() = ea22d000 [new]
<-- nfs_init_server() = 0 [new ea22d000]
--> nfs_probe_fsinfo()
<-- nfs_probe_fsinfo() = 0
Server FSID: 802:0
SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
--> nfs_free_server()
--> nfs_put_client({1})
--> nfs_free_client(3)
<-- nfs_free_client()
<-- nfs_free_server()

> If you follow that up with:
> 
> 	echo $((0x0201)) >/proc/sys/sunrpc/nfs_debug
> 	ls -l /net/bix
> 	umount /net/bix
> 
> That'll dump information from the VFS interaction also.  It'll be a lot more
> information, and it might overrun your dmesg buffer, hence why I'm asking you
> to do the client-only debugging separately.

--> nfs_init_server()
--> nfs_get_client(bix,192.168.2.33:264,3)
--> nfs_get_client() = ebabd400 [new]
<-- nfs_init_server() = 0 [new ebabd400]
--> nfs_probe_fsinfo()
<-- nfs_probe_fsinfo() = 0
Server FSID: 802:0
NFS: nfs_fhget(0:15/0 ct=1)
NFS: nfs_fhget(0:15/2 ct=1)
SELinux: initialized (dev 0:15, type nfs), uses genfs_contexts
NFS: nfs_update_inode(0:15/2 ct=1 info=0x6)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: permission(0:15/2), mask=0x1, res=0
NFS: lookup(/usr)
NFS: permission(0:15/2), mask=0x3, res=0
NFS: dentry_delete(/usr, 0)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: permission(0:15/2), mask=0x1, res=0
NFS: lookup(/mnt)
NFS: permission(0:15/2), mask=0x3, res=0
NFS: dentry_delete(/mnt, 0)
NFS: nfs_update_inode(0:15/2 ct=1 info=0x6)
NFS: permission(0:15/2), mask=0x4, res=0
NFS: opendir(0:15/2)
NFS: readdir(/) starting at cookie 0
NFS: nfs_fhget(0:15/11 ct=1)
NFS: dentry_delete(/lost+found, 0)
NFS: nfs_fhget(0:15/65537 ct=1)
NFS: dentry_delete(/dev, 0)
NFS: dentry_delete(/usr, 8)
NFS: nfs_fhget(0:15/196609 ct=1)
NFS: dentry_delete(/var, 0)
NFS: nfs_fhget(0:15/245761 ct=1)
NFS: dentry_delete(/tmp, 0)
NFS: nfs_fhget(0:15/262145 ct=1)
NFS: dentry_delete(/etc, 0)
NFS: nfs_fhget(0:15/327681 ct=1)
NFS: dentry_delete(/root, 0)
NFS: nfs_fhget(0:15/753665 ct=1)
NFS: dentry_delete(/lib, 0)
NFS: nfs_fhget(0:15/851969 ct=1)
NFS: dentry_delete(/bin, 0)
NFS: nfs_fhget(0:15/983041 ct=1)
NFS: dentry_delete(/home, 0)
NFS: nfs_fhget(0:15/999425 ct=1)
NFS: dentry_delete(/initrd, 0)
NFS: dentry_delete(/mnt, 8)
NFS: nfs_fhget(0:15/1048577 ct=1)
NFS: dentry_delete(/opt, 0)
NFS: nfs_fhget(0:15/1064961 ct=1)
NFS: dentry_delete(/sbin, 0)
NFS: nfs_fhget(0:15/13811717 ct=1)
NFS: dentry_delete(/misc, 0)
NFS: nfs_fhget(0:15/12877854 ct=1)
NFS: dentry_delete(/.automount, 0)
NFS: nfs_fhget(0:15/9207876 ct=1)
NFS: dentry_delete(/tftpboot, 0)
NFS: nfs_fhget(0:15/12 ct=1)
NFS: dentry_delete(/.autofsck, 0)
NFS: nfs_fhget(0:15/49430 ct=1)
NFS: dentry_delete(/swap, 0)
NFS: nfs_fhget(0:15/13435097 ct=1)
NFS: dentry_delete(/rpms, 0)
NFS: nfs_fhget(0:15/14 ct=1)
NFS: dentry_delete(/.fonts.cache-1, 0)
NFS: readdir(/) returns 0
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/lost+found, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: lookup(/boot)
NFS: nfs_update_inode(0:15/2 ct=1 info=0x6)
NFS: nfs_fhget(0:15/32769 ct=1)
NFS: dentry_delete(/boot, 0)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/dev, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: lookup(/proc)
NFS: nfs_fhget(0:15/131073 ct=1)
NFS: dentry_delete(/proc, 0)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/usr, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/var, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/tmp, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/etc, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/root, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/lib, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/bin, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/home, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/initrd, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/mnt, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/opt, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/sbin, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/misc, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/tftpboot, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: lookup(/sys)
NFS: nfs_fhget(0:15/17842177 ct=1)
NFS: dentry_delete(/sys, 0)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/swap, 8)
NFS: permission(0:15/2), mask=0x1, res=0
NFS: dentry_delete(/rpms, 8)
NFS: readdir(/) starting at cookie 26
NFS: readdir(/) returns 0
--> nfs_free_server()
--> nfs_put_client({1})
--> nfs_free_client(3)
<-- nfs_free_client()
<-- nfs_free_server()


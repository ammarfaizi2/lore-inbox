Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752117AbWHOQzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbWHOQzf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWHOQzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:55:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55965 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752117AbWHOQzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:55:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1155595768.5656.26.camel@localhost> 
References: <1155595768.5656.26.camel@localhost>  <20060813012454.f1d52189.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 15 Aug 2006 17:55:19 +0100
Message-ID: <27792.1155660919@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Could you try pulling afresh from the NFS git tree? I've fixed up a couple
> of issues in which rpc_pipefs was corrupting the dcache,

Which patches hold those fixes?  I'm seeing:

	BUG: atomic counter underflow at:
	 [<c01d5b05>] _atomic_dec_and_lock+0x1d/0x30
	 [<c0169bd3>] dput+0x22/0x145
	 [<c8a2f726>] rpc_destroy_client+0xd9/0xee [sunrpc]
	 [<c8a2f89e>] rpc_shutdown_client+0xea/0xf1 [sunrpc]
	 [<c8a2f89e>] rpc_shutdown_client+0xea/0xf1 [sunrpc]
	 [<c886d842>] nfs_free_client+0x95/0xdd [nfs]
	 [<c886db38>] nfs_free_server+0xa9/0xd9 [nfs]
	 [<c8873fae>] nfs_kill_super+0xc/0x14 [nfs]
	 [<c015c033>] deactivate_super+0x4a/0x5d
	 [<c016df3e>] sys_umount+0x1d3/0x1f1
	 [<c016ac98>] destroy_inode+0x36/0x45
	 [<c0169bd3>] dput+0x22/0x145
	 [<c0157889>] __fput+0x146/0x170
	 [<c016cf48>] mntput_no_expire+0x11/0x59
	 [<c016df73>] sys_oldumount+0x17/0x1a
	 [<c0102b3f>] syscall_call+0x7/0xb
	 =======================

And I'm wondering if that's due to that problem.

I've applied the patch to fix the resource counting that's at the head of your
git tree.

David

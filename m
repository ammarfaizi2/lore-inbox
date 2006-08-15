Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWHORNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWHORNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWHORNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:13:44 -0400
Received: from pat.uio.no ([129.240.10.4]:17601 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030393AbWHORNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:13:42 -0400
Subject: Re: 2.6.18-rc4-mm1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>
In-Reply-To: <27792.1155660919@warthog.cambridge.redhat.com>
References: <1155595768.5656.26.camel@localhost>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <27792.1155660919@warthog.cambridge.redhat.com>
Content-Type: multipart/mixed; boundary="=-r5FLRelp9777Jlk6uC7v"
Date: Tue, 15 Aug 2006 13:13:29 -0400
Message-Id: <1155662009.5939.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.898, required 12,
	autolearn=disabled, AWL 0.59, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r5FLRelp9777Jlk6uC7v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-08-15 at 17:55 +0100, David Howells wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
> > Could you try pulling afresh from the NFS git tree? I've fixed up a couple
> > of issues in which rpc_pipefs was corrupting the dcache,
> 
> Which patches hold those fixes?  I'm seeing:
> 
> 	BUG: atomic counter underflow at:
> 	 [<c01d5b05>] _atomic_dec_and_lock+0x1d/0x30
> 	 [<c0169bd3>] dput+0x22/0x145
> 	 [<c8a2f726>] rpc_destroy_client+0xd9/0xee [sunrpc]
> 	 [<c8a2f89e>] rpc_shutdown_client+0xea/0xf1 [sunrpc]
> 	 [<c8a2f89e>] rpc_shutdown_client+0xea/0xf1 [sunrpc]
> 	 [<c886d842>] nfs_free_client+0x95/0xdd [nfs]
> 	 [<c886db38>] nfs_free_server+0xa9/0xd9 [nfs]
> 	 [<c8873fae>] nfs_kill_super+0xc/0x14 [nfs]
> 	 [<c015c033>] deactivate_super+0x4a/0x5d
> 	 [<c016df3e>] sys_umount+0x1d3/0x1f1
> 	 [<c016ac98>] destroy_inode+0x36/0x45
> 	 [<c0169bd3>] dput+0x22/0x145
> 	 [<c0157889>] __fput+0x146/0x170
> 	 [<c016cf48>] mntput_no_expire+0x11/0x59
> 	 [<c016df73>] sys_oldumount+0x17/0x1a
> 	 [<c0102b3f>] syscall_call+0x7/0xb
> 	 =======================
> 
> And I'm wondering if that's due to that problem.
> 
> I've applied the patch to fix the resource counting that's at the head of your
> git tree.

See attached mail. Alex confirmed that it fixes the corruption problems
he is seeing.

Cheers,
  Trond

--=-r5FLRelp9777Jlk6uC7v
Content-Disposition: inline
Content-Description: Attached message - Re: [PATCHv3] sunrpc/auth_gss: NULL
	pointer deref in gss_pipe_release()
Content-Type: message/rfc822

Subject: Re: [PATCHv3] sunrpc/auth_gss: NULL pointer deref in
	gss_pipe_release()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alex Polvi <polvi@google.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e561bacc0608141334i2a942ff5ua97b8c8db381fca1@mail.google.com>
References: <e561bacc0607310750p2cba1576m6564a356b94dd26c@mail.google.com>
	 <1154378242.13744.14.camel@localhost>
	 <e561bacc0608090827m45fc8f2fia02589be4efce178@mail.google.com>
	 <1155137983.5731.95.camel@localhost>
	 <e561bacc0608141232h164f86e2ub2a53061b52d1120@mail.google.com>
	 <e561bacc0608141334i2a942ff5ua97b8c8db381fca1@mail.google.com>
Content-Type: text/plain
Message-Id: <1155595592.5656.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Date: Mon, 14 Aug 2006 18:46:39 -0400
X-Evolution-Format: text/plain
X-Evolution-Account: 1149135252.7829.2@lade.trondhjem.org
X-Evolution-Transport: smtp://trondmy;auth=PLAIN@smtp.uio.no/;use_ssl=always
X-Evolution-Fcc: imap://trondmy@imap.uio.no/INBOX/Sent
X-Evolution-Source: imap://trondmy@imap.uio.no/
Content-Transfer-Encoding: 7bit

On Mon, 2006-08-14 at 16:34 -0400, Alex Polvi wrote:
> On 8/14/06, Alex Polvi <polvi@google.com> wrote:
> > Here is another fix. It is quite silly, but clnt->cl_auth is set to
> > NULL in rpc_destroy_client(), then eventually referenced in
> > gss_release_pipe() via rpc_rmdir(). Simply removing the clnt->cl_auth
> > = NULL from clnt.c fixes the issue. I'm still trying to understand the
> > subsystem, but it seems like rpc_rmdir is being correctly called to
> > clean up because of the weirdness with umount -l and the nfs server
> > being turned on and off. Does that seem correct? Or is this still just
> > covering up some other part of the code being sloppy cleaning up?
> 
> Also, I just want to make it clear that I do not think this is the
> proper fix. It is just pointing out that we intentionally set cl_auth
> to NULL, then reference it.

OK. I think I've finally managed to clean up the various interactions
with rpc_pipefs. I've uploaded a series of patches on the NFS client
website. See

  http://client.linux-nfs.org/Linux-2.6.x/2.6.18-rc4/

The relevant patches are

linux-2.6.18-006-fix_rpc_unlink.dif: 
        
        From: Trond Myklebust <Trond.Myklebust@netapp.com>
        
        SUNRPC: make rpc_unlink() take a dentry argument instead of a
        path
        
        Signe-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
        
linux-2.6.18-007-fix_rpc_rmdir.dif: 
        
        From: Trond Myklebust <Trond.Myklebust@netapp.com>
        
        NFS: clean up rpc_rmdir
        
        Make it take a dentry argument instead of a path
        
        Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
        
linux-2.6.18-008-fix_rpc_unlink_rmdir_2.dif: 
        
        From: Trond Myklebust <Trond.Myklebust@netapp.com>
        
        SUNRPC: rpc_unlink() must check for unhashed dentries
        
        A prior call to rpc_depopulate() by rpc_rmdir() on the parent
        directory may have already called simple_unlink() on this entry.
        Add the same check to rpc_rmdir(). Also remove a redundant call
        to rpc_close_pipes() in rpc_rmdir.
        
        Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
        
linux-2.6.18-009-fix_rpc_unlink_rmdir_3.dif: 
        
        From: Trond Myklebust <Trond.Myklebust@netapp.com>
        
        SUNRPC: Fix dentry refcounting issues with users of rpc_pipefs
        
        rpc_unlink() and rpc_rmdir() will dput the dentry reference for
        you.
        
        Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

----

In addition, there is one patch that is needed in order to fix up a
related issue in the function nfs_alloc_client(), which was introduced
by David Howells' NFS superblock sharing patches.

Cheers,
  Trond

--=-r5FLRelp9777Jlk6uC7v--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUAPMck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUAPMck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:32:40 -0500
Received: from thor.itep.ru ([194.85.69.254]:29412 "EHLO mail.itep.ru")
	by vger.kernel.org with ESMTP id S265390AbUAPMch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:32:37 -0500
Date: Fri, 16 Jan 2004 15:32:32 +0300
From: Roman Kagan <Roman.Kagan@itep.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [2.6] nfs_rename: target $file busy, d_count=2
Message-ID: <20040116123232.GA22836@panda.itep.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2004 at 05:01:12AM -0500, Mike Fedyk wrote:
> 1. nfs_rename: target $file busy, d_count=2
> 2. RPC request reserved 0 but used 40
> 
> Hi, I'm getting [1] in kernel log on the nfs client, and [2] on the nfs server.
> After that I get nfs stale file handles.

I started to get "RPC request reserved 0 but used X" where X ranged from
24 to 32900, when I switched from NFS over UDP to NFS over TCP.  Both
servers and clients are on vanilla 2.6.1, one of the servers exibiting
this does only readonly exports.  There are no apparent effects
associated with that message, however the comment in svc_sock_release()
in net/sunrpc/svcsock.c says that it's an indication of a bug.  I'll try
to run it with debugging enabled to see on which code path it happens.

I don't see your nfs_rename problem on the clients.  Nor do they get
stale NFS handles: there used to be some until I added no_subtree_check
export option.

> Both client and server are running the same 2.6.1-bk2 kernel with TCP-NFS.
> SMP, Highmem, & preempt.

In my case UP, no highmem, no preempt.

  Roman.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264675AbUEOI6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbUEOI6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 04:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEOI6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 04:58:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52898 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264675AbUEOI6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 04:58:21 -0400
Date: Sat, 15 May 2004 10:58:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: RPC request reserved 0 but used 96
Message-ID: <20040515085819.GS17326@suse.de>
References: <20040515083831.GR17326@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040515083831.GR17326@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15 2004, Jens Axboe wrote:
> Hi,
> 
> Seeing lots of these on a small server that hosts nfs shares (root and
> "normal").
> 
> router:~ # dmesg | tail -n5
> RPC request reserved 0 but used 96
> RPC request reserved 0 but used 96
> RPC request reserved 0 but used 140
> RPC request reserved 0 but used 140
> RPC request reserved 0 but used 96
> 
> I see nfs stalls on the client, doesn't seem to be directly related to
> when the above messages happen.

This went out a little early, lots of pieces missing.

The server is running 2.6.6-mm2, NFS options are as follows:

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y

The shares are exported async.

Client is running 2.4.26, mount options are nfsvers=3,tcp.

I'll be trying 2.6.6-BK on the server now.

-- 
Jens Axboe


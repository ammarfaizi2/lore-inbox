Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUA1SS1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUA1SS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:18:27 -0500
Received: from ns.suse.de ([195.135.220.2]:414 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266009AbUA1SSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:18:25 -0500
Date: Wed, 28 Jan 2004 19:00:16 +0100
From: Andi Kleen <ak@suse.de>
To: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: No timeout with no portmap
Message-Id: <20040128190016.0ea8334b.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried to mount a NFS file system on a system with no local portmap running.
mount ended up in an endless uninterruptible sleep in xprt_transmit.
It only recovered when I eventually started portmap

Shouldn't there be a shorter timeout for this? 

Happened on 2.6.2rc2 on AMD64.

That was the hanging mount:

mount         D 0000000045aaaf57     0  2012   2043                     (NOTLB)
0000010017b278b8 0000000000000006 0000010016d50448 ffffffff803601a2 
       0000010015670b30 000000000000001d ffffffff803ec4c0 0000010015670e68 
       0000000000000000 00000100191b2138 
Call Trace:<ffffffff803601a2>{xprt_transmit+1202} <ffffffff803630a0>{__rpc_execute+432} 
       <ffffffff80130900>{default_wake_function+0} <ffffffff8035e9ee>{rpc_call_sync+142} 
       <ffffffff803601d0>{xprt_timer+0} <ffffffff8035d8a0>{call_status+0} 
       <ffffffff80362020>{rpc_run_timer+0} <ffffffff803694be>{rpc_register+286} 
       <ffffffff80365094>{svc_register+148} <ffffffff801d4276>{nfs3_rpc_wrapper+118} 
       <ffffffff80365200>{svc_create+224} <ffffffff801ea086>{lockd_up+118} 
       <ffffffff801cd92c>{nfs_get_sb+2828} <ffffffff80328b13>{inet_recvmsg+51} 
       <ffffffff8017554b>{do_kern_mount+107} <ffffffff8018b527>{do_mount+1463} 
       <ffffffff801562b4>{__alloc_pages+164} <ffffffff80156634>{__get_free_pages+68} 
       <ffffffff8018b71b>{sys_mount+203} <ffffffff8010f704>{system_call+124} 
       

-Andi 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266417AbUAIC4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 21:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266418AbUAIC4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 21:56:34 -0500
Received: from FLA1Aak172.kng.mesh.ad.jp ([218.42.70.172]:6083 "EHLO
	yamt.dyndns.org") by vger.kernel.org with ESMTP id S266417AbUAIC4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 21:56:32 -0500
To: trond.myklebust@fys.uio.no
Cc: phil@fifi.org, theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] Re: [NFS client] NFS locks not released on abnormal process
 termination
In-Reply-To: Your message of "Thu, 8 Jan 2004 17:50:56 +0100 (CET)"
	<35311.68.42.103.198.1073580656.squirrel@webmail.uio.no>
References: <35311.68.42.103.198.1073580656.squirrel@webmail.uio.no>
X-Mailer: Cue version 0.6 (030717-1703/takashi)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Date: Fri, 09 Jan 2004 11:56:26 +0900
Message-Id: <1073616986.525187.4709.nullmailer@yamt.dyndns.org>
From: YAMAMOTO Takashi <yamamoto@valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> > i think it's problematic because you can't assume the lock was
> > granted on the server and the signaled process might not exit
> > immediately.
> 
> The point is that it is *worse* to assume the lock was not granted,
> since then it will never get cleared on the server.

yes.

> The RPC layer blocks all signals except SIGKILL, so the signalled
> process has no choice but to exit immediately if something gets
> through.

we're talking about interruptible mounts, aren't we?

are you referring to rpc_clnt_sigmask() ?
i think it isn't safe to assume sa_handler isn't changed during
blocking for lock.  consider CLONE_SIGHAND, for example.

YAMAMOTO Takashi


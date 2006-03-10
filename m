Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752116AbWCJC2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbWCJC2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWCJC2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:28:00 -0500
Received: from koto.vergenet.net ([210.128.90.7]:2461 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1752116AbWCJC2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:28:00 -0500
Date: Fri, 10 Mar 2006 11:24:46 +0900
From: Horms <horms@verge.net.au>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] NFS Client: remove supurflous goto from nfs_create_client()
Message-ID: <20060310022444.GB5435@verge.net.au>
References: <20060309092341.GA26949@verge.net.au> <4410D053.1000303@vilain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4410D053.1000303@vilain.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 02:03:15PM +1300, Sam Vilain wrote:
> Why not just move the label?
> 
> I think it is nicer if all of the exit points of a function are at the
> end, I've observed this to be a common convention and its success has
> actually made me jump off the 'goto=hell' bandwagon.
> 
> gcc might even be optimising those duplicate instructions to a single
> one, so the duplication would be good documentation.

Sure, I thought of doing that as well, and I wasn't sure which was the
best option. I actually prefer not to have a label if its just going to
return. But I'm not religious about it. Here is an alternate patch that 
does what you suggest.

NFS Client: Remove duplicate return in nfs_create_client()

Signed-Off-By: Horms <horms@verge.net.au>

 inode.c |    2 --
 1 file changed, 2 deletions(-)

65263bbdd17ed4ca75ac1c38165e5bd50eed146c
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a77ee95..14aa539 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -414,8 +414,6 @@ nfs_create_client(struct nfs_server *ser
 	clnt->cl_intr     = 1;
 	clnt->cl_softrtry = 1;
 
-	return clnt;
-
 out_fail:
 	return clnt;
 }

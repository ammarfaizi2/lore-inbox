Return-Path: <linux-kernel-owner+w=401wt.eu-S1751737AbXAPW2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXAPW2F (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbXAPW2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:28:05 -0500
Received: from pat.uio.no ([129.240.10.15]:44976 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbXAPW2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:28:03 -0500
Subject: Re: [PATCH] nfs: fix congestion control
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <1168985323.5975.53.camel@lappy>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	 <20070116135325.3441f62b.akpm@osdl.org>  <1168985323.5975.53.camel@lappy>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 17:27:46 -0500
Message-Id: <1168986466.6056.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=0.0, required=12.0, autolearn=disabled, none)
X-UiO-Scanned: 56D91E2C9961F47E5A7384AB54D99FDDE2F032D1
X-UiO-SPAM-Test: 129.240.10.9 spam_score 0 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2007-01-16 at 23:08 +0100, Peter Zijlstra wrote:
> Subject: nfs: fix congestion control
> 
> The current NFS client congestion logic is severely broken, it marks the
> backing device congested during each nfs_writepages() call and implements
> its own waitqueue.
> 
> Replace this by a more regular congestion implementation that puts a cap
> on the number of active writeback pages and uses the bdi congestion waitqueue.
> 
> NFSv[34] commit pages are allowed to go unchecked as long as we are under 
> the dirty page limit and not in direct reclaim.
> 
> 	A buxom young lass from Neale's Flat,
> 	Bore triplets, named Matt, Pat and Tat.
> 	"Oh Lord," she protested,
> 	"'Tis somewhat congested ...
> 	"You've given me no tit for Tat." 


What on earth is the point of adding congestion control to COMMIT?
Strongly NACKed.

Why 16MB of on-the-wire data? Why not 32, or 128, or ...
Solaris already allows you to send 2MB of write data in a single RPC
request, and the RPC engine has for some time allowed you to tune the
number of simultaneous RPC requests you have on the wire: Chuck has
already shown that read/write performance is greatly improved by upping
that value to 64 or more in the case of RPC over TCP. Why are we then
suddenly telling people that they are limited to 8 simultaneous writes?

Trond



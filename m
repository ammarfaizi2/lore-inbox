Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVIZWHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVIZWHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIZWHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:07:31 -0400
Received: from imap.gmx.net ([213.165.64.20]:37787 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932345AbVIZWHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:07:30 -0400
X-Authenticated: #20450766
Date: Tue, 27 Sep 2005 00:06:48 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [2.6.13] pktcdvd: IO-errors
In-Reply-To: <m3slvr1ugx.fsf@telia.com>
Message-ID: <Pine.LNX.4.60.0509262358020.6722@poirot.grange>
References: <Pine.LNX.4.60.0509242057001.4899@poirot.grange> <m3slvtzf72.fsf@telia.com>
 <Pine.LNX.4.60.0509252026290.3089@poirot.grange> <m34q873ccc.fsf@telia.com>
 <Pine.LNX.4.60.0509262122450.4031@poirot.grange> <m3slvr1ugx.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Peter Osterlund wrote:

> OK. Another option since you have one good and one bad kernel, is to
> try to find the point in time where it broke. If you are a git user,

No, I am not.

> you can use the "git bisect" method. If not, you can use -rc releases
> from ftp.kernel.org.

I think, I have an easier test - I just replaced the pktcdvd.[hc] in 
2.6.13.1 with respective files from 2.6.12, and it worked. The diff is 
pretty small, so, it should be possible to actually find the culprit 
there. E.g., here's the comment, that came in with 2.6.13:

- * - Optimize for throughput at the expense of latency. This means that streaming
- *   writes will never be interrupted by a read, but if the drive has to seek
- *   before the next write, switch to reading instead if there are any pending
- *   read requests.

In the worst case, one could just reverse the patch for 2.6.14 and until a 
solution to the problem is found.

Thanks
Guennadi
---
Guennadi Liakhovetski

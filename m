Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTKKEM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTKKEM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:12:58 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:59381 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S264258AbTKKEM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:12:56 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110195433.4331b75e.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068523328.25805.97.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 23:02:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 22:54, Andrew Morton wrote:
>  Eventually, the bottleneck disappears,
> > and the performance increases, but never substantially. 
> 
> It's not clear here what direction the data is being transferred in.  Is it
> mostly client->server, or mostly server->client?

Seems to be bidirectional.

> What filesystem is the server using?

ext3

> In which direction was the file transferred?  client to server or server to
> client?  What kernel was running on each?

The client is running AS2.1, RH's 2.4.9-e12. Server is RH AS 3.0, 2.4.22
stock, and 2.6.0-test9, 2.6.0-test9-bk11. Transfers in both directions.
> 
> As next steps I'd suggest that you log into the server and do
> 
> 	time (dd if=/dev/zero of=x bs=1M count=2048 ; sync)
> 
> and
> 
> 	time (dd if=x of=/dev/null bs=1M count=2048 ; sync)
> 
> (this assumes that the machine has less that 2G of memory, to avoid caching
> effects).

The raw file read/write is the ticket. The box tightens right up at 100% iowait.

I'd done bonnie++ i/o tests already, and except for an apparent NPTL issue on the per char,
the block i/o numbers were fine; no abnormal results whatsoever. In fact, block r/w
numbers were improved compared to 2.4.22. Now that I'm looking for it, however, I 
do note extremely elevated iowait numbers during a bonnie++ run. Something in the MPT
modules?

-Paul


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVCGFan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVCGFan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVCGFan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:30:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1285 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261629AbVCGFah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:30:37 -0500
Date: Mon, 7 Mar 2005 06:30:32 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ben Greear <greearb@candelatech.com>,
       Christian Schmid <webmaster@rapidforum.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-ID: <20050307053032.GA30052@alpha.home.local>
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422BE33D.5080904@yahoo.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 04:14:37PM +1100, Nick Piggin wrote:
 
> I think you would have better luck in reproducing this problem if you
> did the full sendfile thing.
> 
> I think it is becoming disk bound due to page reclaim problems, which
> is causing the slowdown.
> 
> In that case, writing the network only test would help to confirm the
> problem is not a networking one - so not useless by any means.

Not necessarily, Nick. I have written an HTTP testing tool which matches
the description of Ben's : non-blocking, single-threaded, no disk I/O,
etc... It works flawlessly under 2.4, and gives me random numbers in 2.6,
especially if I start some CPU activity on the system, I can get pauses
of up to 13 seconds without this tool doing anything !!! At first I
believed it was because of the scheduler, but it might also be related
to what is described here since I had somewhat the same setup (gigE, 1500,
thousands of sockets). I never had enough time to investigate more, so I
went back to 2.4.

It makes me think that for the problem described here, we have no
indication of CPU & I/O activity, which might help Ben try to reproduce.

Cheers,
Willy


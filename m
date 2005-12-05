Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVLEITh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVLEITh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLEITh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:19:37 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:35955 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932303AbVLEITg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:19:36 -0500
Date: Mon, 5 Dec 2005 00:19:35 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>
Subject: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051205081935.GI22168@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
seconds or less, and writing out the swap image took less than 5
seconds, so within 15 seconds of running my suspend script power was
off.

The downside was that after suspend, *everything* needed to be paged
back in, so all my apps were *very* slow for the first few interactions.
It would take about 15 or 20 seconds for Firefox to repaint the first
time I switched to its virtual desktop, and it was perceptibly slower
than normal for the next 5 or 10 minutes of use.

Now that I'm running 2.6.15-rc3-mm1, the page-in problem seems to be
largely gone; I don't notice a significant lagginess after resuming from
swsusp.

But the suspend process is *slow*.  It takes a good 20 or 30 seconds to
write out the image, which makes the overall suspend process take close
to a minute; it's writing about 400 MB, and my disk seems to only be
good for about 18 MB/sec according to hdparm -t.

And, the resume is about the same amount slower, too.

Certainly there's a tradeoff to be made, and I'm glad to lose the slow
re-paging after resume, but I'm hoping that some kind of improvement can
be made in the suspend/resume time.

Could we perhaps throw away *half* the cached memory rather than all of
it?  Or keep a lazy list of pages that need re-reading and page them in
asynchronously after restarting userland?

-andy

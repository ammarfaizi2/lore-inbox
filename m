Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTEWMHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTEWMHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:07:22 -0400
Received: from holomorphy.com ([66.224.33.161]:1683 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264030AbTEWMHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:07:21 -0400
Date: Fri, 23 May 2003 05:18:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Robert White <rwhite@casabyte.com>, Nick Piggin <piggin@cyberone.com.au>,
       elladan@eskimo.com, Rik van Riel <riel@imladris.surriel.com>,
       David Woodhouse <dwmw2@infradead.org>, ptb@it.uc3m.es,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       root@chaos.analogic.com
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <20030523121838.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Robert White <rwhite@casabyte.com>,
	Nick Piggin <piggin@cyberone.com.au>, elladan@eskimo.com,
	Rik van Riel <riel@imladris.surriel.com>,
	David Woodhouse <dwmw2@infradead.org>, ptb@it.uc3m.es,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, root@chaos.analogic.com
References: <3ECC4C3A.9000903@cyberone.com.au> <PEEPIDHAKMCGHDBJLHKGEEKJCMAA.rwhite@casabyte.com> <16077.52259.718519.389903@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16077.52259.718519.389903@laputa.namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 11:22:11AM +0400, Nikita Danilov wrote:
> and suppose they both are equally correct. Now, in (2) total amount of
> time &lock is held is smaller than in (1), but (2) will usually perform
> worse on SMP, because:
> . spin_lock() is an optimization barrier
> . taking even un-contended spin lock is an expensive operation, because
> of the cache coherency issues.

All good. Also, the arrival rate (i.e. frequency of lock acquisition)
is more important to lock contention than hold time, so they're actually
not being as friendly to big SMP as the comment from Robert White would
suggest. The arrival rate tends to be O(cpus) since whatever codepath
pounds on a lock on one cpu can be executed on all simultaneously.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbTIMRst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIMRst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 13:48:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50578 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261643AbTIMRsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 13:48:47 -0400
Date: Sat, 13 Sep 2003 18:48:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: rusty@linux.co.intel.com
Cc: riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
Message-ID: <20030913174825.GB7404@mail.jlokier.co.uk>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309120219.h8C2JANc004514@penguin.co.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Lynch wrote:
> Over the years I have encountered various usage needs where the standard
> oom_kill.c version of memory recovery was not the most ideal approach.
> For example, some times it is better to just restart the system and 
> let a front end load balancer hand off the server load to another system.
> Sometimes it might be worth the effort to write a very solution specific
> oom handler.

I would like to reboot a remote server when it is overloaded, or a
deterministic policy that kills off services starting with those
deemed less essential, but what is the best way to detect overload?

IMHO, the server is overloaded when tasks are no longer responding in
a reasonable time, due to excessive paging.

It isn't feasible to work out in advance how much swap this
corresponds to, because it depends how much swap is used by "idle"
pages, and how much is likely to be filled with working sets.

Too much swap, and it won't OOM even while it becomes totally
unresponsive for days and needs a manual reset.  Too little swap, and
valuable RAM is being wasted.

What I'd really like is some way to observe task response times,
and when they become too slow due to excessive paging, trigger the OOM
policy whatever it is.

Also, when the OOM condition is triggered I'd like the system to
reboot, but first try for a short while to unmount filesystems cleanly.

Any chance of those things?

Thanks in advance :)
-- Jamie

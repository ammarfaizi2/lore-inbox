Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTHXO3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTHXO3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 10:29:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:60676 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261159AbTHXO3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 10:29:18 -0400
Subject: Re: [PATCH] Nick's scheduler policy
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F48B12F.4070001@cyberone.com.au>
References: <3F48B12F.4070001@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1061735355.1034.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 24 Aug 2003 16:29:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-24 at 14:35, Nick Piggin wrote:
> Hi,
> Patch against 2.6.0-test4. It fixes a lot of problems here vs
> previous versions. There aren't really any open issues for me, so
> testers would be welcome.
> 
> The big change is more dynamic timeslices, which allows "interactive"
> tasks to get very small timeslices while more compute intensive loads
> can be given bigger timeslices than usual. This works properly with
> nice (niced processes will tend to get bigger timeslices).
> 
> I think I have cured test-starve too.

I haven't still found any starvation cases, but forking time when the
system is under heavy load has increased considerable with respect to
vanilla or Con's O18.1int:

1. On a Konsole session, run "while true; do a=2; done"
2. Now, try forming a new Konsole session and you'll see it takes
approximately twice the time it takes when the system is under no load.

Also, renicing X to -20 helps X interactivity, while with Con's patches,
renicing X to -20 makes it feel worse.


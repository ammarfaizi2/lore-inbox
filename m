Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbSIZOxp>; Thu, 26 Sep 2002 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSIZOxo>; Thu, 26 Sep 2002 10:53:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14605 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261314AbSIZOxn>; Thu, 26 Sep 2002 10:53:43 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
Date: Thu, 26 Sep 2002 15:01:51 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <amv7gv$266$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0209261311070.11487-100000@localhost.localdomain>
X-Trace: palladium.transmeta.com 1033052337 2298 127.0.0.1 (26 Sep 2002 14:58:57 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Sep 2002 14:58:57 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0209261311070.11487-100000@localhost.localdomain>,
Ingo Molnar  <mingo@elte.hu> wrote:
>
>while running fork() testcases with NPTL we found a number of futex
>related failures that i tracked down to the following conceptual bug in
>the futex code:

This patch seems trivially broken by having two futexes on the same
page.  When the first futex removes itself, it will clear the sticky
bit, even though the other futex is still pinning the same page.

Trust me, you'll have to use the page list approach.

		Linus

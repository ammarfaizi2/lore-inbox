Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTL0XI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 18:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbTL0XI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 18:08:27 -0500
Received: from mail2.bluewin.ch ([195.186.4.73]:19851 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S264870AbTL0XI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 18:08:26 -0500
Date: Sun, 28 Dec 2003 00:07:58 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@surriel.com>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-ID: <20031227230757.GA25229@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Rik van Riel <riel@surriel.com>, torvalds@osdl.org,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	andrea@suse.de
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com> <20031226190045.0f4651f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226190045.0f4651f3.akpm@osdl.org>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003 19:00:45 -0800, Andrew Morton wrote:
> The current behaviour seems better from a theoretical point of view.  All
> we want to know is the reference pattern - whether it is one process
> referencing the page frequently or 100 processes referencing it
> infrequently shouldn't matter.  And if we want to give mapped pages more

It can matter. Evicting a page that is infrequently referenced by many
processes increases the chance that all runnable processes block waiting
for that same page later. The likelihood of that happening grows under
memory pressure, when "infrequently" may actually be "quite often" and
when disk I/O is congested (resulting in higher disk access times).

You won't have the same effect when evicting a page that is referenced
by one process only, no matter how frequently.

Having all processes blocked is indeed one problem of 2.6 under memory
pressure. I don't know what the cause is, though.

Roger

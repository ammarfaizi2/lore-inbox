Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVL3P11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVL3P11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 10:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVL3P11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 10:27:27 -0500
Received: from [81.2.110.250] ([81.2.110.250]:10428 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932217AbVL3P10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 10:27:26 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <20051228201150.b6cfca14.akpm@osdl.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Dec 2005 15:28:00 +0000
Message-Id: <1135956480.28365.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-28 at 20:11 -0800, Andrew Morton wrote:
> If no-forced-inlining makes the kernel smaller then we probably have (yet
> more) incorrect inlining.  We should hunt those down and fix them.  We did
> quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a script which
> would identify which functions are a candidate for uninlining?

There is a tool that does this quite well. Its called "gcc" ;)

More seriously we need to seperate "things Andrew thinks are good inline
candidates" and "things that *must* be inlined". That allows 'build for
size' to do the equivalent of "-Dplease_inline" and the other build to
do "-Dplease_inline=inline". Gcc's inliner isn't aware of things cross
module so isn't going to make all the decisions right, but will make the
tedious local decisions.

As far as bugs go - gcc -Os has also fixed bugs in the past. It doesn't
introduce bugs so much as change them. Fedora means we have good long
term data on -Os with modern gcc (not with old gcc but we just dumped <
3.2 anyway).

Nowdays the -Os code paths are also getting real hammering because many
people build desktops, even OpenOffice with -Os and see overall
performance gains for the system.

Alan


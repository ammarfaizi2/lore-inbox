Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUBUBFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUBUBFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:05:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:58029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbUBUBFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:05:49 -0500
Date: Fri, 20 Feb 2004 17:10:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(),
 O_CLEAN
In-Reply-To: <20040221003831.GB10928@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402201708100.3301@ppc970.osdl.org>
References: <20040219081027.GB4113@mail.shareable.org>
 <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu>
 <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220173307.GF8994@mail.shareable.org>
 <Pine.LNX.4.58.0402201017370.2533@ppc970.osdl.org> <20040221003831.GB10928@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Jamie Lokier wrote:
> 
> Eh?  The flag and notification operations are set and tested
> under the inode semaphore, when fcntl() is called.

Doesn't matter. Because you will drop the inode semaphore before you
actually create a new file. So you'll alway shave a window open for a
race.

That's what Ingo's O_CLEAN thing did. An di fyou do Ingo's O_CLEAN, then 
there's no point to notifiers in the first place - Ingo's algorithm works 
regardless of them (it had other problems, but that's another issue and 
just requires a bit of extending on the basic concept).

So why do you care about dnotify? It doesn't help at all once you have 
O_CLEAN (or equivalent).

		Linus

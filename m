Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUBTXBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUBTXBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:01:12 -0500
Received: from dp.samba.org ([66.70.73.150]:28134 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261381AbUBTXBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:01:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16438.37289.895975.757333@samba.org>
Date: Sat, 21 Feb 2004 10:00:57 +1100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(),
 O_CLEAN
In-Reply-To: <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org>
References: <16435.61622.732939.135127@samba.org>
	<Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
	<20040219081027.GB4113@mail.shareable.org>
	<Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	<20040219163838.GC2308@mail.shareable.org>
	<Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	<20040219182948.GA3414@mail.shareable.org>
	<Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
	<20040220120417.GA4010@elte.hu>
	<Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
	<20040220170438.GA19722@elte.hu>
	<Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

 > This is one of the reasons why I worry about user-space caching. It's just 
 > damn hard to get right. 

yes, I'm concerned about that too. It does have the potential to be
very fast though, as it allows us to index any way we want to (in the
hot-cache paths at least).

One thing that may be important to know is with the normal Samba
process model there may be thousands of processes accessing this cache
as Samba creates a new process for each connection. With futexes we
have some chance of sanely managing access to a shared cache in user
space between such a large pool of processes, so I don't think that is
an insurmountable problem, but its something to consider when thinking
of the normal use case of whatever solution is decided on.

The current user-space positive name cache is per-process, largely
because it was designed to be portable and nice things like futexes
weren't available. At the time we also were trying to avoid too much
OS specific stuff in Samba. We've got much better infrastructure for
OS specific stuff now, so there is no problem with a Linux specific
solution. The other unixes can just continue to be slow.

Cheers, Tridge

PS: Thanks _very_ much for all the effort on this!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbUBSVtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267340AbUBSVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:49:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:53997 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267317AbUBSVs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:48:57 -0500
Date: Thu, 19 Feb 2004 13:53:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <20040219214353.GI31035@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402191349440.1439@ppc970.osdl.org>
References: <20040219163838.GC2308@mail.shareable.org>
 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org>
 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
 <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191340080.1439@ppc970.osdl.org>
 <20040219214353.GI31035@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Thu, Feb 19, 2004 at 01:45:32PM -0800, Linus Torvalds wrote:
> > So we'd see very quickly if these tentative dentries were to escape 
> > outside of __d_lookup().
> 
> Ahem...  You'll see them (at least) in dcache pruning codepaths.  And
> those will dereference inodes...

Yea, you be right. Many of those paths would not need to care about
TENTATIVE at all, so using the d_inode thing would make them uglier, I
agree. Maybe the flag is better after all (and it really should be pretty
well contained by just checking all __d_lookup callers, so it should be 
hard to get it wrong, but maybe I've forgotten some path).

We could do it both ways - do the TENTATIVE_INODE thing as a debugging 
thing at first to make sure none of these dentries escape, and then remove 
it (and the unnecessary tests in the pruning paths) once everybody is 
convinced that it is working correctly.

		Linus

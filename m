Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbUBSV1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUBSV0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:26:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:21472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267317AbUBSVZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:25:16 -0500
Date: Thu, 19 Feb 2004 13:30:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Tridge <tridge@samba.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <20040219204853.GA4619@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Jamie Lokier wrote:
> 
> Yes: The slow part of my brain thinks dnotify with a new flag
> DN_IGNORE_SELF, meaning don't notify for things done by the process
> which is watching, would provide equivalent functionality.

Basically, yes. However, I can tell you that directory name caching is 
damn hard, and the kernel does it better than anybody else. 

The hardest part of caching is not filling the cache - it's knowing when 
to release it. In other words, forget the filling part, and think about 
the replacement policy (balacing between the page cache, the directory 
cache, and regular pages). The kernel already has that.

Besides, I really think that we can do this with basically just a few 
lines of code in the kernel (apart from the actual case comparison, which 
I'm not even going to worry about - that's totally independent of the 
cache handling itself, and I don't care about how to write a 
"windows_equivalent_strncasecmp()".

		Linus

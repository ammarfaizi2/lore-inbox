Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWJWQcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWJWQcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWJWQcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:32:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13277 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932144AbWJWQcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:32:03 -0400
Date: Mon, 23 Oct 2006 09:31:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Andi Kleen <ak@suse.de>, Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
In-Reply-To: <Pine.LNX.4.62.0610231812290.1841@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.64.0610230928430.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
 <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <200610230059.23806.ak@suse.de>
 <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
 <Pine.LNX.4.64.0610230908570.3962@g5.osdl.org>
 <Pine.LNX.4.62.0610231812290.1841@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Oct 2006, Geert Uytterhoeven wrote:
> > 
> > We have tons of issues that depend on config variables and architecture 
> > details. 
> 
> Indeed, so the config variables and architecture details should be handled in
> the include files, not in the (multiple) users of those include files.

The point is - _verifying_ that is actually hard.

If some inline function depends on a particular header, you'll have a hard 
time checking for that if there's an #ifdef around it. Which is not 
uncommon, we have things like:

	#ifdef CONFIG_PROCFS
	.. number of inline functions ..
	#else
	#define function1(a,b,c) do { } while (0)
	...
	#endif

so I'm just saying that "just compile it" is _not_ a way of verifying that 
the header file is complete - because it may well be complete for the 
particular config you're testing, but not for some other.

So this is a hard problem. If it was easy, we'd not _have_ the problem in 
the first place.

		Linus

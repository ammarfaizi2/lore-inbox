Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVHWXon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVHWXon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 19:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVHWXom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 19:44:42 -0400
Received: from gold.veritas.com ([143.127.12.110]:39253 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751290AbVHWXom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 19:44:42 -0400
Date: Wed, 24 Aug 2005 00:46:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ulrich Drepper <drepper@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap() use is racy
In-Reply-To: <430B9E45.3080107@redhat.com>
Message-ID: <Pine.LNX.4.61.0508240037430.12750@goblin.wat.veritas.com>
References: <430B7EAE.6020001@redhat.com> <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
 <430B8D96.5080002@redhat.com> <Pine.LNX.4.58.0508231425330.3317@g5.osdl.org>
 <430B9E45.3080107@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Aug 2005 23:44:41.0796 (UTC) FILETIME=[A1EAF040:01C5A83C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005, Ulrich Drepper wrote:
> Linus Torvalds wrote:
> > Actually, it should be pretty much as valid as using mremap - ie it works 
> > on Linux. 
> > 
> > Especially if you use MAP_SHARED, you don't even need to mprotect 
> > anything: you'll get a nice SIGBUS if you ever try to access past the last 
> > page that maps the file.
> 
> If you guarantee this (and test for this) it's fine with me.  The POSIX
> spec explicitly leaves this undefined and requiring to use mremap()
> would be a nice way to work around this without allowing the
> introduction of undefined behavior into programs.  I probably would
> prefer to use mremap() since this makes it clear what should happen but
> I can live with using the too-large mapping.

I don't have spec to hand to quote, but at least 10 years ago the SIGBUS
beyond end of file was required behaviour, on both MAP_SHARED and more
surprisingly MAP_PRIVATE mappings of a file.  Well, you don't get SIGBUS
on any part of the page that covers the end of the file: perhaps what
you read as undefined in the spec is addressing that tail page issue.

We guarantee it: it's a kernel bug if it doesn't work.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161972AbWJDSlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161972AbWJDSlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161966AbWJDSlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:41:13 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:44963 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161972AbWJDSlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:41:12 -0400
Message-ID: <45240034.2040704@oracle.com>
Date: Wed, 04 Oct 2006 11:40:52 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered
 I/O path
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>	<20061004102522.d58c00ef.akpm@osdl.org>	<4523F486.1000604@oracle.com>	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com> <20061004111603.20cdaa35.akpm@osdl.org>
In-Reply-To: <20061004111603.20cdaa35.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We have lots of nice new tools in-kernel which permit applications to
> manipulate and to invalidate pagecache.  Please, start using them rather
> than pushing bits of oracle into the core vfs ;)

And apps that were written before they were available? :)  We're OK with
their behaviour changing under newer kernels because they now have a
previous source of memory pressure that they didn't have before?

It seems a bit much to suggest that retaining the previous behaviour of
avoiding memory pressure by using the O_DIRECT API is somehow "pushing
bits of oracle into the core vfs" :).

Maybe that aspect of the API was unintentional, though.  That would be a
shame.  I suspect Oracle isn't alone in relying on it.

> Please, no truncate_inode_pages.  For this application, the far-safer
> invalidate_inode_pages() would suffice.

So now apps always have to pay the cost of looking up pages to
invalidate on the off chance that they wrote to a sparse region, based
on the current implementation detail that sparse regions fall back to
buffered?

- z

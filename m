Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264805AbTIDI3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTIDI3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:29:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:63172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264805AbTIDI3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:29:08 -0400
Date: Thu, 4 Sep 2003 01:28:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Hugh Dickins <hugh@veritas.com>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-Reply-To: <20030904024345.CC3E02C018@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0309040127370.20151-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Rusty Russell wrote:
> 
> However, Jamie's futex code will see !VM_SHARED on the mapping, and
> compare futexes by mm + uaddr (rather than inode + file offset), so
> this is NOT the case.  Using VM_MAYSHARE instead would make the
> MAP_SHARED readonly case work as above, though.

But that is WORSE!

Now MAP_SHARED works, but MAP_PRIVATE does not. That's still the same bug, 
but now it' san inconsistent bug!

I'd rather have a consistent bug than one that makes no sense.

			Linus


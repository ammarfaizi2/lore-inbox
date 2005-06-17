Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVFQBfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVFQBfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVFQBfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:35:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34200 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261882AbVFQBfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:35:10 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <42B227B5.3090509@yahoo.com.au>
References: <1118855899.3949.21.camel@betsy>  <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy>  <42B227B5.3090509@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 21:35:09 -0400
Message-Id: <1118972109.7280.13.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 11:30 +1000, Nick Piggin wrote:

> What we could do is just check list_empty(&inode->inotify_watchers)
> and remove the atomic count completely.
> 
> We don't actually care about getting an exact count at all, just
> whether or not it is empty, and in that case using list_empty is
> no more racy than checking an atomic count, both are done outside
> any locks.
> 
> It is basically just a lock avoidance heuristic. But I think count
> is superfluous - off with its head!

Yah.  This is what I originally did.  Because of the current
implementation of list_empty(), the race is never dangerous (e.g., no
segfault), we just get false positives/negatives, but that is no
different than the atomic check, really, since we can race in the
interim and then we go on and check the list anyhow.

So, let's do it.  I'll cook up a patch and updated inotify tomorrow, if
no one beats me to the punch.

	Robert Love



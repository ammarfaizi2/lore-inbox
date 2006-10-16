Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWJPPl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWJPPl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWJPPl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:41:27 -0400
Received: from xenotime.net ([66.160.160.81]:18403 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161000AbWJPPl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:41:27 -0400
Date: Mon, 16 Oct 2006 08:42:55 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "alpha @ steudten Engineering" <alpha@steudten.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: INFO: possible circular locking dependency detected
Message-Id: <20061016084255.10f133b6.rdunlap@xenotime.net>
In-Reply-To: <4533980C.10403@yahoo.com.au>
References: <453391A4.5090100@steudten.org>
	<4533980C.10403@yahoo.com.au>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 00:32:44 +1000 Nick Piggin wrote:

> alpha @ steudten Engineering wrote:
> > =======================================================
> > [ INFO: possible circular locking dependency detected ]
> > 2.6.18-1.2189self #1
> > -------------------------------------------------------
> > kswapd0/186 is trying to acquire lock:
> >  (&inode->i_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
> > 
> > but task is already holding lock:
> >  (iprune_mutex){--..}, at: [<c0326e32>] mutex_lock+0x21/0x24
> > 
> > which lock already depends on the new lock.
> 
> Thanks. __grab_cache_page wants to clear __GFP_FS, because it is
> holding the i_mutex so we don't want to reenter the filesystem in
> page reclaim.
> 
> This would be an easy two liner, except those funny page_cache_alloc
> routines which take a mapping rather than a gfp_t argument :P

and it would be only one email, but you forgot spaces there,
so it's too ugly to use.  ;)  i.e., please add spaces around
the '&'.

and it's an attachment :(

> Anyway, I'll get around to writing the real patch and queue it up
> with my other buffered write deadlock fixes. It should be fairly
> unlikely to cause you a deadlock. You could give this quick patch a
> try, though. Does it fix your problem?



---
~Randy

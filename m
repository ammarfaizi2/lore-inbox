Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUEXHko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUEXHko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbUEXHkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:40:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:46792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264103AbUEXHig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:38:36 -0400
Date: Mon, 24 May 2004 00:38:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [FIX] kernel BUG at fs/locks.c:1723!
Message-Id: <20040524003803.3cb476db.akpm@osdl.org>
In-Reply-To: <200405232350.16169.agruen@suse.de>
References: <200405232350.16169.agruen@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
>
> 
>  There is a race between unshare_files() and the following steal_locks(). As a 
>  consequence, steal_locks() may steal some additional FL_POSIX locks that 
>  don't belong to the current thread. This triggers a BUG in 
>  locks_remove_flock().

Well based on Trond's words it's not clear whether we should be proceeding
this way.  Although I think he said "the code is crap and someone should
rewrite it".  Fine, but that doesn't mean we shouldn't be fixing oopses in
the current stuff.

I fixed up the big reject which this threw - it's getting a bit optimistic
sending out patches against 2.6.5...

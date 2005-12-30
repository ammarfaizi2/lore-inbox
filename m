Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbVL3WLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVL3WLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVL3WLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:11:52 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49543 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750929AbVL3WLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:11:52 -0500
Subject: Re: [PATCH] protect remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051230215544.GI27284@gaz.sfgoth.com>
References: <1135973075.6039.63.camel@localhost.localdomain>
	 <1135978110.6039.81.camel@localhost.localdomain>
	 <20051230215544.GI27284@gaz.sfgoth.com>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 17:11:40 -0500
Message-Id: <1135980700.6039.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 13:55 -0800, Mitchell Blank Jr wrote:
> Steven Rostedt wrote:
> > I've added a global remove_proc_lock to protect this section of code.  I
> > was going to add a lock to proc_dir_entry so that the locking is only
> > cut down to the same parent, but since this function is called so
> > infrequently, why waste more memory then is needed.  One global lock
> > should not cause too much of a headache here.
> 
> Are you sure that it's the only place where we need guard ->subdir?  It
> looks like proc_lookup() and proc_readdir() use the BLK when walking that
> list, so probably the best fix would be to use that lock everywhere else
> ->subdir is touched

Perhaps this is a good candidate to have the BKL removed from this
protection and replaced with a spin lock or something else.  If I
remember, I'll look into that further.

-- Steve



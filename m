Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWCJMCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWCJMCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWCJMCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:02:35 -0500
Received: from mail.suse.de ([195.135.220.2]:59094 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750744AbWCJMCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:02:34 -0500
Date: Fri, 10 Mar 2006 13:02:33 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Kirill Korotaev <dev@openvz.org>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
Message-ID: <20060310120232.GM4243@hasse.suse.de>
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru> <20060310105950.GL4243@hasse.suse.de> <44116198.7000000@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44116198.7000000@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, Kirill Korotaev wrote:

> >I think that we should go for the first.
> just an idea which came to my mind:
> can't we fix it the following way:
> 1. fix select_parent() when called from generic_shutdown_super() to loop 
> until _all_ dentries are shrinked (not only those, with d_count = 1);
> this guarentees that no dentries are left.
> 2. no dentries are left, but iput() can be in progress.
> So can't we simply make invalidate_inodes() to be in a loop with 
> schedule() until no busy inodes are left?!

But this hides the places where dput() is called after mntput() and locks up
when somebody forgets to call dput() at all. And I think we should printk() in
that situations instead of waiting for them.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de

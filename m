Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWCJK7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWCJK7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCJK7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:59:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:38877 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932231AbWCJK7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:59:52 -0500
Date: Fri, 10 Mar 2006 11:59:50 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Neil Brown <neilb@suse.de>, Kirill Korotaev <dev@openvz.org>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
Message-ID: <20060310105950.GL4243@hasse.suse.de>
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441138B7.9060809@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, Kirill Korotaev wrote:

> >I really think that we need to stop prune_one_dentry from being called
> >on dentries for a filesystem that is being unmounted.  With that code
> >currently in -git, that means passing a 'struct super_block *' into
> >prune_dcache so that it ignores any filesystem with ->s_root==NULL
> >unless that filesystem is the filesystem that was passed.
> Can try...
> 

Can not ... because of down_read(s_umount) before checking s_root :(

So what do we do now?

 1. always get the reference counting right outside of dcache_lock

 2. hack around with different paths for prune_dcache() when called from
    shrink_dcache_memory() and shrink_dcache_parent()

I think that we should go for the first.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de

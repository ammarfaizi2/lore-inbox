Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751830AbWCILgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbWCILgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWCILgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:36:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47007 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751830AbWCILgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:36:47 -0500
Date: Thu, 9 Mar 2006 17:06:34 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jan Blunck <jblunck@suse.de>
Cc: akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de, neilb@suse.de,
       dev@openvz.org, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309113634.GA8944@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060308145105.GA4243@hasse.suse.de> <20060309063330.GA23256@in.ibm.com> <20060309110025.GE4243@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309110025.GE4243@hasse.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> No. Think about a dentry which parent isn't unhashed. This parent will end up
> on the lru-list after the wait_on_prunes(). Therefore we have to do the
> select_parent()/prune_dcache() again to get rid of all dentries.
>

Just checked, yes prune_one_dentry() needs to be called once the parent
gets on to the LRU list, so we must call prune_dcache() again.
In -mm, the generic_shutdown_super() calls shrink_dcache_sb() which takes care
of looping till the lru-list is empty.

Your fix is correct, but the looping is probably not be required for -mm.
 
Regards,
Balbir

<snip>

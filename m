Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWCIOIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWCIOIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWCIOIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:08:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:59558 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751913AbWCIOI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:08:29 -0500
Date: Thu, 9 Mar 2006 15:08:27 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, viro@zeniv.linux.org.uk,
       olh@suse.de, neilb@suse.de, dev@openvz.org, bsingharora@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (updated patch)
Message-ID: <20060309140827.GH4243@hasse.suse.de>
References: <20060308145105.GA4243@hasse.suse.de> <20060309063330.GA23256@in.ibm.com> <20060309110025.GE4243@hasse.suse.de> <20060309032157.0592153e.akpm@osdl.org> <4410253E.3070101@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4410253E.3070101@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, Kirill Korotaev wrote:

> >
> >Are we all happy with this patch now?
> 
> I can't see why we fix shrink_dcache_parent() only, why 
> shrink_dcache_anon() is totally missed?
> 

First of all because anon-dentries don't have a parent. So they are not a real
problem in don't restarting the shrink_dcache_anon() if we waited for prunes.
Since I've reordered the calls to shrink_dcache_anon() and
shrink_dcache_parent() in generic_shutdown_super() they are handled as normal
dentries if they are pruned through shrink_dcache_memory() from the d_lru list.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de

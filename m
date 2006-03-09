Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWCIObk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWCIObk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWCIObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:31:39 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:35757 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751919AbWCIObj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:31:39 -0500
Message-ID: <44103D50.7010108@sw.ru>
Date: Thu, 09 Mar 2006 17:36:00 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, viro@zeniv.linux.org.uk,
       olh@suse.de, neilb@suse.de, dev@openvz.org, bsingharora@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (updated patch)
References: <20060308145105.GA4243@hasse.suse.de> <20060309063330.GA23256@in.ibm.com> <20060309110025.GE4243@hasse.suse.de> <20060309032157.0592153e.akpm@osdl.org> <4410253E.3070101@sw.ru> <20060309140827.GH4243@hasse.suse.de>
In-Reply-To: <20060309140827.GH4243@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Are we all happy with this patch now?
>>
>>I can't see why we fix shrink_dcache_parent() only, why 
>>shrink_dcache_anon() is totally missed?
>>
> 
> 
> First of all because anon-dentries don't have a parent. So they are not a real
> problem in don't restarting the shrink_dcache_anon() if we waited for prunes.
> Since I've reordered the calls to shrink_dcache_anon() and
> shrink_dcache_parent() in generic_shutdown_super() they are handled as normal
> dentries if they are pruned through shrink_dcache_memory() from the d_lru list.
This looks a bad idea to reorder calls to achieve such a behvaiour.
I would move the loop outside of shrink_dcache_parent to 
generic_shutdown_super instead.

Thanks,
Kirill



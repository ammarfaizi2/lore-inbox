Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWCJMPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWCJMPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCJMPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:15:52 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:61290 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750722AbWCJMPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:15:52 -0500
Message-ID: <44116EDD.8020903@sw.ru>
Date: Fri, 10 Mar 2006 15:19:41 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Neil Brown <neilb@suse.de>, Kirill Korotaev <dev@openvz.org>,
       akpm@osdl.org, viro@zeniv.linux.org.uk, olh@suse.de,
       bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (3rd updated patch)]
References: <20060309165833.GK4243@hasse.suse.de> <441060D2.6090800@openvz.org> <17425.2594.967505.22336@cse.unsw.edu.au> <441138B7.9060809@sw.ru> <20060310105950.GL4243@hasse.suse.de> <44116198.7000000@sw.ru> <20060310120232.GM4243@hasse.suse.de>
In-Reply-To: <20060310120232.GM4243@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I think that we should go for the first.
>>
>>just an idea which came to my mind:
>>can't we fix it the following way:
>>1. fix select_parent() when called from generic_shutdown_super() to loop 
>>until _all_ dentries are shrinked (not only those, with d_count = 1);
>>this guarentees that no dentries are left.
>>2. no dentries are left, but iput() can be in progress.
>>So can't we simply make invalidate_inodes() to be in a loop with 
>>schedule() until no busy inodes are left?!
> 
> 
> But this hides the places where dput() is called after mntput() and locks up
> when somebody forgets to call dput() at all. And I think we should printk() in
> that situations instead of waiting for them.
I think both: printk and wait.
 From my own personal experience with it: it is better to wait in a loop 
and be able to collect information, then to crash.

Thanks,
Kirill


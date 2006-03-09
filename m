Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWCIQOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWCIQOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWCIQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:14:00 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:22871 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932198AbWCIQN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:13:59 -0500
Message-ID: <4410554D.2050806@sw.ru>
Date: Thu, 09 Mar 2006 19:18:21 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, neilb@suse.de, bsingharora@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (updated patch)
References: <20060308145105.GA4243@hasse.suse.de> <44103EE3.7040303@openvz.org> <20060309160922.GI4243@hasse.suse.de>
In-Reply-To: <20060309160922.GI4243@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks! I'll send the corrected patch.
> So, everythings fine now?
looks so! Will be glad to Ack/Sign or whatever needed :)))

>>>	d_free(dentry);
>>>	if (parent != dentry)
>>>		dput(parent);
>>>	spin_lock(&dcache_lock);
>>>+	sb->s_prunes--;
>>>+	if (likely(!sb->s_prunes))
>>
>><<< Is it possibe to do something like:
>>if (unlikely(!sb->s_root && !sb->s_prunes))
>>?
> 
> 
> Uh, I forgot about that one. You already complained about that before :(
But I'm not sure it is that simple... s_root is set to NULL w/o locks, 
so I wonder whether it is safe to check it here or we can miss some 
wakeups...

Thanks,
Kirill


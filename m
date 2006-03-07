Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWCGGSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWCGGSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWCGGSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:18:04 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44897 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752000AbWCGGSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:18:02 -0500
Message-ID: <440D26A6.9040802@sw.ru>
Date: Tue, 07 Mar 2006 09:22:30 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <17414.38749.886125.282255@cse.unsw.edu.au>	 <17419.53761.295044.78549@cse.unsw.edu.au>	 <661de9470603052332s63fd9b2crd60346324af27fbf@mail.gmail.com>	 <17420.59580.915759.44913@cse.unsw.edu.au> <661de9470603061849t470b0709v1987385c9845710e@mail.gmail.com>
In-Reply-To: <661de9470603061849t470b0709v1987385c9845710e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>+               /* avoid further wakeups */
>>>>+               sb->s_pending_iputs = 65000;
>>>
>>>This looks a bit ugly, what is 65000?
>>
>>Just the first big number that came to by head... probably not needed.
>>
> 
> 
> ok, I would rather use a const or a #define and hide it under a
> meaningful name, with comments. If it is not needed, then nothing like
> avoiding magic numbers.
It looks like this assignment is not needed at all if "wait_for_prunes" 
is moved after dput(root), since no more dentries should exist after 
that point and wakeup can not potentially happen.

Thanks,
Kirill


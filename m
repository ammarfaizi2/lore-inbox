Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWAWINf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWAWINf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWAWINf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:13:35 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:57758 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751415AbWAWINf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:13:35 -0500
Message-ID: <43D4907B.4060801@sw.ru>
Date: Mon, 23 Jan 2006 11:14:51 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru> <20060119100443.GD10267@hasse.suse.de> <43CF693D.4020104@sw.ru> <20060120190653.GE24401@hasse.suse.de>
In-Reply-To: <20060120190653.GE24401@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>CPU 1				CPU 2
>>~~~~~				~~~~~
>>umount /dev/sda1
>>generic_shutdown_super          shrink_dcache_memory()
>>shrink_dcache_parent            dput dentry
>>select_parent                   prune_one_dentry()
>>                                <<<< child is dead, locks are released,
>>                                  but parent is still referenced!!! >>>>
>>skip dentry->parent,
>>since it's d_count > 0
>>
>>message: BUSY inodes after umount...
>>                                <<< parent is left on dentry_unused list,
>>                                   referencing freed super block >>>
> 
> 
> I see. The problem is that dcache_lock is given up before dereferencing the
> parent. But your patch seems to be wrong anyway IMHO. I'll post patches in a
> seperate thread.
Jan, I still have not heard a single comment about what's wrong with 
it... I would really appreciate if you provide me one.

Kirill


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWA3OcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWA3OcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWA3OcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:32:23 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:6518 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932293AbWA3OcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:32:22 -0500
Message-ID: <43DE23E3.6020009@sw.ru>
Date: Mon, 30 Jan 2006 17:34:11 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru> <20060119100443.GD10267@hasse.suse.de> <43CF693D.4020104@sw.ru> <20060120190653.GE24401@hasse.suse.de> <43D4907B.4060801@sw.ru> <20060130115435.GA9181@hasse.suse.de> <43DE1D28.1030100@sw.ru> <20060130142140.GE9181@hasse.suse.de>
In-Reply-To: <20060130142140.GE9181@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

>>>mntput(path->mnt);   // too early mntput()
>>>dput(path->dentry);
>>>
>>>Assuming that in-between this sequence someone unmounts the file system, 
>>>your
>>>patch will wait for this dput() to finish before it proceeds with 
>>>unmounting
>>>the file system. I think this isn't what we want.
>>
>>No, it won't wait for anything, because if umount happened between 
>>mntput/dput, dentry is not in s_dshrinkers list.
>>if umount happens in parallell with dput() (where shrinker operations 
>>are), then it will behave ok - will wait for dput() and then umount. It 
>>was intended behaviour!
> 
> 
> It should not wait.
why?! it makes sure, that dentries/inodes are gone _before_ super block 
destroyed.

>>Also, please, note that such early mntput()'s are bugs!!! because such 
>>dentries can reference freed memory after last mntput(). And I remember 
>>some patches in 2.4.x/2.6.x which fixed this sequence everywhere.
> 
> 
> Thats why I'm complaining ...
about what?
my patch doesn't hide this bug, nor helps it anyhow.

Kirill



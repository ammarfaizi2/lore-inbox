Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWASJwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWASJwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWASJwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:52:04 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:3659 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161039AbWASJwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:52:03 -0500
Message-ID: <43CF6170.3050608@sw.ru>
Date: Thu, 19 Jan 2006 12:52:48 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Jan Blunck <jblunck@suse.de>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de>
In-Reply-To: <20060118224953.GA31364@hasse.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Olaf, can you please check if my patch for busy inodes from -mm tree 
>>helps you?
>>Patch name is fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
> 
> 
> This patch is just wrong. It is hiding bugs in file systems. The problem is
> that somewhere the reference counting on the vfsmount objects is wrong. The
> file system is unmounted before the last dentry is dereferenced. Either you
> didn't hold a reference to the proper vfsmount objects at all or you
> dereference it too early. See Al Viros patch series (search for "namei fixes")
> on how to fix this issues.

This patch has nothing to do with vfsmount references and doesn't hide 
anything. It just adds syncronization barrier between do_umount() and 
shrink_dcache() since the latter can work with dentries/inodes without 
holding locks.

So if you think there is something wrong with it, please, be more specific.

Kirill


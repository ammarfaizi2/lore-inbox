Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWIDO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWIDO7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWIDO7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:59:08 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:45250 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751452AbWIDO7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:59:05 -0400
Date: Mon, 4 Sep 2006 16:55:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
In-Reply-To: <1157381440.3384.941.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041652520.17279@yvahk01.tjqt.qr>
References: <1157031183.3384.793.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0609040824290.9108@yvahk01.tjqt.qr> <1157381440.3384.941.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Is not there a better way to do this? Note that there is also a "nfsd4" process
>> running. Do you really want to do a 'costly'
>> 
>>   strcmp(current->comm, "nfsd") != 0 && strcmp(current->comm, "nfsd4") != 0
>> 
>> every time someone does a readdir? What if I run a userspace nfs daemon?
>> What if that userspace daemon is called differently?
>> 
>> jengelh@linux01:7 08:28:14 ~ > ps -e | grep nfs
>>  5580 ?        00:00:08 rpc.nfsd
>> jengelh@linux01:7 08:28:30 ~ > rpm -qf /usr/sbin/rpc.nfsd 
>> nfs-server-2.2beta51-209.2 (a userspace nfsd)
>
>Ah, now this is a very tricky one to solve. Its on my todo list to look
>at this area again. You are right that the test is bogus in that it
>should only respond to the in kernel NFS server and the reason for its

In that case, you could use the fact that ... (I'll express it in C code):

    is_kernel_task = !current->mm;

>existence is due to locking issues with the way that NFS calls through
>the VFS layer.


Jan Engelhardt
-- 

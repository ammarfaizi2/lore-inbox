Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFDAP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFDAP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:15:57 -0400
Received: from dm2-85.slc.aros.net ([66.219.220.85]:56730 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S261994AbTFDAPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:15:53 -0400
Message-ID: <3EDD3D5F.3010509@aros.net>
Date: Tue, 03 Jun 2003 18:29:19 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj
 (bug?!)
References: <3EDCEA14.2000407@aros.net> <20030603120717.66012855.akpm@digeo.com>
In-Reply-To: <20030603120717.66012855.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Lou Langholtz <ldl@aros.net> wrote:
>  
>
>>Or perhaps the block 
>>handling logic was changed such that disks don't share the same 
>>request_queue anymore. If so, then a few drivers (like nbd) need to be 
>>updated to use a seperate request_queue per disk.
>>    
>>
>
>The ramdisk driver was recently changed to do exactly this.  From what
>you say it appears that nbd needs the same treatment.
>  
>
I noticed that too but thought surely that couldn't be why the rd driver 
was changes. Cause... then it would seem via 'grep blk_init_queue 
drivers/block/*.c' that most of the block drivers need to be changed. 
And having a request_queue structure for every disk that's often (in 
these drivers) every minor device, seems like a lot of unneeded memory 
usage too. I'm afraid to ask this, but are you sure that each disk 
really is supposed to have its own request queue now? That seems less 
sensible than inverting the kobject parenting logic so that the 
request_queue.elevator kobject is the parent of the disk kobject. After 
all, makes more sense for multiple gen_disk objects to belong to the 
same elevator than for multiple elevators to belong to the same gen_disk 
no???

Anyways.... thanks for setting me straight ;-)

Lou


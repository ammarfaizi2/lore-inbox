Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTFDAqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTFDAqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:46:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:64470 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262413AbTFDAqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:46:12 -0400
Date: Tue, 3 Jun 2003 18:00:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj
 (bug?!)
Message-Id: <20030603180002.2a0b4402.akpm@digeo.com>
In-Reply-To: <3EDD3D5F.3010509@aros.net>
References: <3EDCEA14.2000407@aros.net>
	<20030603120717.66012855.akpm@digeo.com>
	<3EDD3D5F.3010509@aros.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2003 00:59:38.0979 (UTC) FILETIME=[93059B30:01C32A34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz <ldl@aros.net> wrote:
>
> >The ramdisk driver was recently changed to do exactly this.  From what
>  >you say it appears that nbd needs the same treatment.
>  >  
>  >
>  I noticed that too but thought surely that couldn't be why the rd driver 
>  was changes. Cause... then it would seem via 'grep blk_init_queue 
>  drivers/block/*.c' that most of the block drivers need to be changed. 
>  And having a request_queue structure for every disk that's often (in 
>  these drivers) every minor device, seems like a lot of unneeded memory 
>  usage too. I'm afraid to ask this, but are you sure that each disk 
>  really is supposed to have its own request queue now? That seems less 
>  sensible than inverting the kobject parenting logic so that the 
>  request_queue.elevator kobject is the parent of the disk kobject. After 
>  all, makes more sense for multiple gen_disk objects to belong to the 
>  same elevator than for multiple elevators to belong to the same gen_disk 
>  no???

According to Al, we have a significant number of drivers in the tree in
which multiple gendisks shared the same queue.  Sometimes because that's a
logical mapping onto how the hardware behaves.

As far as I know, the new queue-per-gendisk requirement is purely because
of this sysfs hierarchy problem.

So yes, perhaps you are right and we need to rethink things from the sysfs
angle rather than reworking the drivers.  Along the lines which you
mention.

This isn't my area.  Perhaps Jens, Greg or Pat could comment?

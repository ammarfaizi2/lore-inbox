Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSGERMq>; Fri, 5 Jul 2002 13:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSGERMp>; Fri, 5 Jul 2002 13:12:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43426 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317505AbSGERMo>;
	Fri, 5 Jul 2002 13:12:44 -0400
Date: Fri, 5 Jul 2002 10:09:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Greg KH <gregkh@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove BKL from driverfs
In-Reply-To: <3D23EA93.7090106@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0207051001560.8496-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Jul 2002, Dave Hansen wrote:

> I saw your talk about driverfs at OLS and it got my attention.  When 
> my BKL debugging patch showed some use of the BKL in driverfs, I was 
> very dissapointed (you can blame Greg if you want).

I'm sorry to hear about your distress. Hopefully you've had a chance to 
talk to someone about it and calm down a bit. 

> text from dmesg after BKL debugging patch:
> release of recursive BKL hold, depth: 1
> [ 0]main:492
> [ 1]inode:149
> 
> I see no reason to hold the BKL in your situation.  I replaced it with 
> i_sem in some places and just plain removed it in others.  I believe 
> that you get all of the protection that you need from dcache_lock in 
> the dentry insert and activate.  Can you prove me wrong?

No, and I'm not about to try very hard. It appears that the place you 
removed it should be fine. In driverfs_unlink, you replace it with i_sem. 
ramfs, which driverfs mimmicks, doesn't hold any lock during unlink. It 
seems it could be removed altogether. 

The other replacement happens in _lseek. That looks fine, though I 
think that entire function can be replaced with one of the generic lseek 
functions...

Patch applied. Thanks,

	-pat


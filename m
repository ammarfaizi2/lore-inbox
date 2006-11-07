Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753841AbWKGXBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbWKGXBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbWKGXBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 18:01:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753841AbWKGXBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 18:01:17 -0500
Date: Tue, 7 Nov 2006 15:00:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Srinivasa DS <srinivasa@in.ibm.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-Id: <20061107150017.fb78a327.akpm@osdl.org>
In-Reply-To: <45510C73.7060408@redhat.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com>
	<20061107122837.54828e24.akpm@osdl.org>
	<45510C73.7060408@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2006 16:45:07 -0600
Eric Sandeen <sandeen@redhat.com> wrote:

> Andrew Morton wrote:
> 
> >> --- linux-2.6.19-rc4.orig/fs/buffer.c	2006-11-07 17:06:20.000000000 +0000
> >> +++ linux-2.6.19-rc4/fs/buffer.c	2006-11-07 17:26:04.000000000 +0000
> >> @@ -188,7 +188,9 @@ struct super_block *freeze_bdev(struct b
> >>  {
> >>  	struct super_block *sb;
> >>  
> >> -	mutex_lock(&bdev->bd_mount_mutex);
> >> +	if (down_trylock(&bdev->bd_mount_sem))
> >> +		return -EBUSY;
> >> +
> > 
> > This is a functional change which isn't described in the changelog.  What's
> > happening here?
> 
> Only allow one bdev-freezer in at a time, rather than queueing them up?
> 

You're asking me? ;)

Guys, I'm going to park this patch pending a full description of what it
does, a description of what the above hunk is doing and pending an
examination of whether we'd be better off changing the mutex-debugging code
rather than switching to semaphores.


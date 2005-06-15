Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFOTlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFOTlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVFOTlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:41:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261521AbVFOTky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:40:54 -0400
Date: Wed, 15 Jun 2005 12:41:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
Message-Id: <20050615124139.6859bf07.akpm@osdl.org>
In-Reply-To: <20050615105537.GO1467@schottelius.org>
References: <20050614215032.35d44e93.akpm@osdl.org>
	<20050615105537.GO1467@schottelius.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> wrote:
>
> Hello Andrew,
> 
> you wrote:
> > What filesystem?
> 
> jfs

It would be useful to test with a different filesystem (ext3 mounted with
data=writeback is close to equivalent).  That'll help us identify the bug.

> > What kernel version?
> 
> 2.6.11.11
> 
> > Any unusual bind mounts, loopback
> > mounts, etc?  There must be something there...>
> 
> Yes, dm-crypt-mounted-jfs.

Again, if you can temporarily eliminate dm-crypt as well it will help
narrow it down.

> So if I understood everything correctly, a simple umount() without
> a sync() before should be enough?

Yes.

> If so, I'll try that, I am happy about every less function call
> I need to do.

OK.  sync()+umount() shouldn't take any longer than a bare umount() (which
has to do a sync too).  Unless you have multiple disks, in which case
there's no point in syncing the disks which aren't being umounted.  But
then, I have a feeling that standard util-linux umount(8) does a global
sync anyway.


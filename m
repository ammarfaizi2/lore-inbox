Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbULIVPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbULIVPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbULIVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:15:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:48611 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261620AbULIVPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:15:33 -0500
Date: Thu, 9 Dec 2004 13:19:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steve Lord <lord@xfs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: negative dentry_stat.nr_unused causes aggressive dcache pruning
Message-Id: <20041209131949.7862f0c8.akpm@osdl.org>
In-Reply-To: <41B8BB96.4040006@xfs.org>
References: <41B77D54.4080909@xfs.org>
	<20041209020919.6f17e322.akpm@osdl.org>
	<41B8BB96.4040006@xfs.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> wrote:
>
> Andrew Morton wrote:
> > Steve Lord <lord@xfs.org> wrote:
> > 
> >>I have seen this stat go negative (just from booting up a multi cpu box),
> >> and looking at the code, it is manipulated without locking in a number
> >> of places. I have only seen this in real life on a 2.4 kernel, but 2.6
> >> also looks vulnerable.
> > 
> > 
> > In 2.6, both dentry_stat.nr_unused and dentry_stat.nr_dentry are covered
> > by dcache_lock.  I just double-checked and all seems well.
> > 
> 
> I still do not know exactly how the count gets negative, but I tracked it
> down to a user space app from emulex called HBAanywhere. The only thing I
> can see this doing which might be related is attempting to open a lot of
> non-existant /proc entries:
> 
> 	/proc/scsi//120
> 	/proc/scsi//121
> 	etc...
> 
> Yes there is a // in there.
> 
> I ran with a BUG call if we manipulate nr_unused without the dcache lock
> and it never tripped. All very wierd.
> 

Is that 2.4 or 2.6?

I'd be expecting a systematic counting bug.  After all, nr_unused would
normally be in the thousands and it'd take a lot of races to get that down
to zero.


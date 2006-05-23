Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWEWU4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWEWU4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWEWU4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:56:16 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:59903 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932200AbWEWU4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:56:15 -0400
Subject: Re: [Question] how to follow a symlink via a dentry?
From: Steven Rostedt <rostedt@goodmis.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060523100847.7056909a@localhost.localdomain>
References: <1148403363.22855.8.camel@localhost.localdomain>
	 <20060523100847.7056909a@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 May 2006 16:56:10 -0400
Message-Id: <1148417770.24623.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 10:08 -0700, Stephen Hemminger wrote:
> On Tue, 23 May 2006 12:56:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > What is the best way from inside the kernel, to find the dentry that
> > another dentry points to via symlink?
> > 
> > Scenario:
> > 
> > I have a kobj of a device in the sysfs system.  Inside a directory of
> > the kobj, is a symlink to another device I need to get.  I can find the
> > dentry of the symlink, but I haven't found a good way to get to the
> > dentry of what the symlink points to.
> > 
> > Is there a standard way to do this, or do I need to start hacking at the
> > follow_link of the sysfs directory to get what I want?
> > 
> > Do I need to hack up something like page_readlink to get the path, and
> > then do vfs_follow_link to get the rest.  Another thing is that I can't
> > rely on what current->fs points to.
> > 
> > Thanks,
> > 
> > -- Steve
> >
> 
> Sysfs reflects kernel object linkage, you should not be using
> file access to find kernel objects.  You should use the pointers
> instead.

What pointers are you talking about?  Let me ask a better question. If
I have a pointer to an ide_drive_t or ide_driver_t or just the struct
device, how do I get to the block_device (bdev) that points to it?

So I have the /sys/block/hda/device object (which really is a symlink to
the /sys/devices/...) but I want to get to the object that
represents /sys/block/hda/device/block:hda which is also a symlink back
to /sys/block/hda. Right now the only way I know to do that is to follow
the sysfs.

-- Steve



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTJNM1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTJNM1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:27:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:35046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262400AbTJNM1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:27:42 -0400
Date: Tue, 14 Oct 2003 05:30:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031014053041.2edd65d4.akpm@osdl.org>
In-Reply-To: <20031014131856.A17629@flint.arm.linux.org.uk>
References: <20031014105514.GH765@holomorphy.com>
	<20031014045614.22ea9c4b.akpm@osdl.org>
	<20031014125848.A17145@flint.arm.linux.org.uk>
	<20031014051031.1d2b5f23.akpm@osdl.org>
	<20031014131856.A17629@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Tue, Oct 14, 2003 at 05:10:31AM -0700, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > On Tue, Oct 14, 2003 at 04:56:14AM -0700, Andrew Morton wrote:
> > > > I guess not mounting /sys doesn't help here.  It would be nice.  Maybe with
> > > > a CONFIG_I_WILL_NEVER_MOUNT_SYSFS we could avoid all those allocations.
> > > 
> > > I believe sysfs is required for mounting the root filesystem - see
> > > name_to_dev_t in init/do_mounts.c.
> > 
> > OK.  But it looks like if /sys is empty and you provide "root=03:02" then
> > things will still work.  It's a matter of trying it...
> 
> Uhh?
> 
> dev_t name_to_dev_t(char *name)
> {
>         dev_t res = 0;
> 
>         sys_mkdir("/sys", 0700);
>         if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
>                 goto out;
> 
> 	...
> 
> out:
>         sys_rmdir("/sys");
>         return res;
> }
> 
> If sysfs can't be mounted, then it looks like we can't even decode a
> numeric major:minor root device specification.

Well I was proposing that sysfs be present and mountable, but empty.  ie:
make sysfs_create() a no-op.  Something like that.  Additional touchups may
be needed of course.

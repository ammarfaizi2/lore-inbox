Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVHVVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVHVVJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVHVVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:09:39 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35307 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751205AbVHVVJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:09:16 -0400
Subject: Re: 2.6.13-rc6-mm1
From: John McCutchan <ttb@tentacle.dhs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       Robert Love <rml@novell.com>
In-Reply-To: <20050820235229.68682f4f.akpm@osdl.org>
References: <fa.h617rae.h64dpq@ifi.uio.no> <430821E1.8040308@reub.net>
	 <20050820235229.68682f4f.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Aug 2005 11:12:36 -0400
Message-Id: <1124723557.2225.19.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 23:52 -0700, Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> > Hi,
> > 
> > On 19/08/2005 11:37 a.m., Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> > > 
> > > - Lots of fixes, updates and cleanups all over the place.
> > > 
> > > - If you have the right debugging options set, this kernel will generate
> > >   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
> > >   It is being worked on.
> > > 
> > > 
> > > Changes since 2.6.13-rc5-mm1:
> > > 
> > >  linus.patch
> > 
> > Noted this in my log earlier today.
> > 
> > Is this inotify related?
> > 
> > Aug 21 08:33:04 tornado kernel: idr_remove called for id=2048 which is not 
> > allocated.
> > Aug 21 08:33:04 tornado kernel:  [<c0103a00>] dump_stack+0x17/0x19
> > Aug 21 08:33:04 tornado kernel:  [<c01c9f9a>] idr_remove_warning+0x1b/0x1d
> > Aug 21 08:33:04 tornado kernel:  [<c01ca024>] sub_remove+0x88/0xea
> > Aug 21 08:33:04 tornado kernel:  [<c01ca0a1>] idr_remove+0x1b/0x7f
> > Aug 21 08:33:04 tornado kernel:  [<c018176a>] remove_watch_no_event+0x7a/0x12e
> > Aug 21 08:33:04 tornado kernel:  [<c0181f64>] inotify_release+0x8f/0x1af
> > Aug 21 08:33:04 tornado kernel:  [<c015ca80>] __fput+0xaf/0x199
> > Aug 21 08:33:04 tornado kernel:  [<c015c9b8>] fput+0x22/0x3b
> > Aug 21 08:33:04 tornado kernel:  [<c015b2ed>] filp_close+0x41/0x67
> > Aug 21 08:33:04 tornado kernel:  [<c015b383>] sys_close+0x70/0x92
> > Aug 21 08:33:04 tornado kernel:  [<c0102a9b>] sysenter_past_esp+0x54/0x75
> > Aug 21 08:33:04 tornado kernel: idr_remove called for id=3072 which is not 
> > allocated.
> > Aug 21 08:33:05 tornado kernel:  [<c0103a00>] dump_stack+0x17/0x19
> > Aug 21 08:33:05 tornado kernel:  [<c01c9f9a>] idr_remove_warning+0x1b/0x1d
> > Aug 21 08:33:05 tornado kernel:  [<c01ca024>] sub_remove+0x88/0xea
> > Aug 21 08:33:05 tornado kernel:  [<c01ca0a1>] idr_remove+0x1b/0x7f
> > Aug 21 08:33:05 tornado kernel:  [<c018176a>] remove_watch_no_event+0x7a/0x12e
> > Aug 21 08:33:05 tornado kernel:  [<c0181f64>] inotify_release+0x8f/0x1af
> > Aug 21 08:33:05 tornado kernel:  [<c015ca80>] __fput+0xaf/0x199
> > Aug 21 08:33:05 tornado kernel:  [<c015c9b8>] fput+0x22/0x3b
> > Aug 21 08:33:05 tornado kernel:  [<c015b2ed>] filp_close+0x41/0x67
> > Aug 21 08:33:05 tornado kernel:  [<c015b383>] sys_close+0x70/0x92
> > Aug 21 08:33:05 tornado kernel:  [<c0102a9b>] sysenter_past_esp+0x54/0x75
> > 
> > This would have been triggered by using dovecot IMAP which is configured to 
> > use inotify on Maildir.
> > I'm also seeing some userspace errors logged for dovecot:
> > 
> > "Aug 21 04:17:22 Error: IMAP(reuben): inotify_rm_watch() failed: Invalid argument"
> > 
> > I'll deal with those with the guy who wrote the inotify code in dovecot.
> > 
> > I'm not so sure userspace should be able or need to cause the kernel to dump 
> > stack traces like that though?
> > 
> 
> Yes, the stack dumps would appear to be due to an inotify bug.
> 
> The message from dovecot is allegedly due to dovecot passing in a file
> descriptor which was not obtained from the inotify_init() syscall.  But
> until we know what caused those stack dumps we cannot definitely say
> whether dovecot is at fault.
> 

Inotify has a check on both add and rm watch syscalls:

    /* verify that this is indeed an inotify instance */
    if (unlikely(filp->f_op != &inotify_fops)) {
        ret = -EINVAL;
        goto out;
    }

This is crashing in inotify_release, which is called on close of the
inotify instance. So this fd must be from an inotify instance right?

I looked at the dovecot code, it looks fine wrt inotify. Long shot, but
the close-on-exec flag is set. Could this be tripping anything up?

-- 
John McCutchan <ttb@tentacle.dhs.org>

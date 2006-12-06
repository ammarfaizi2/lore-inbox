Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760348AbWLFJLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760348AbWLFJLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760364AbWLFJLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:11:31 -0500
Received: from twin.jikos.cz ([213.151.79.26]:38270 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760348AbWLFJLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:11:30 -0500
Date: Wed, 6 Dec 2006 10:11:20 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
In-Reply-To: <20061206090715.GA30931@elte.hu>
Message-ID: <Pine.LNX.4.64.0612061008370.28502@twin.jikos.cz>
References: <Pine.LNX.4.64.0612060149220.28502@twin.jikos.cz>
 <20061206083730.GB24851@elte.hu> <Pine.LNX.4.64.0612060940130.28502@twin.jikos.cz>
 <20061206085428.GA28160@elte.hu> <Pine.LNX.4.64.0612060957180.28502@twin.jikos.cz>
 <20061206090715.GA30931@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Ingo Molnar wrote:

> i'll probably ack such a patch, it can be useful even when the line 
> number is unique: if someone reports a WARN_ON() from an old kernel i 
> dont have to dig up the exact source but can see it right from the 
> condition what happened. Useful redundancy in bug output can be quite 
> useful at times. Please post it and we'll see whether it's acceptable.

OK, thanks, I will send it later today.

BTW I still don't see how to distinguish it easily ... for example:

WARNING at kernel/mutex.c:132 __mutex_lock_common()
 [<c0103d70>] dump_trace+0x68/0x1b5
 [<c0103ed5>] show_trace_log_lvl+0x18/0x2c
 [<c010445b>] show_trace+0xf/0x11
 [<c01044cd>] dump_stack+0x12/0x14
 [<c037523f>] __mutex_lock_slowpath+0xc6/0x261
 [<c0199c61>] create_dir+0x24/0x1ba
 [<c019a30b>] sysfs_create_dir+0x45/0x5f
 [<c01f302b>] kobject_add+0xd6/0x18d
 [<c01f31fb>] kobject_register+0x19/0x30
 [<c02e771a>] md_probe+0x11a/0x124
 [<c0267fa4>] kobj_lookup+0xe6/0x122
 [<c01ec12e>] get_gendisk+0xe/0x1b
 [<c018590e>] do_open+0x2e/0x298
 [<c0185d0f>] blkdev_open+0x25/0x4d
 [<c016451b>] __dentry_open+0xc3/0x17e
 [<c0164650>] nameidata_to_filp+0x24/0x33
 [<c0164691>] do_filp_open+0x32/0x39
 [<c01646da>] do_sys_open+0x42/0xbe
 [<c016478f>] sys_open+0x1c/0x1e
 [<c0102dbc>] syscall_call+0x7/0xb

How can you see immediately which one of the two WARN_ONs in 
spin_lock_mutex() triggered?

-- 
Jiri Kosina

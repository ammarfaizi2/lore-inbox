Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbWLZFwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWLZFwV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 00:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWLZFwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 00:52:21 -0500
Received: from mailhub.hp.com ([192.151.27.10]:57583 "EHLO mailhub.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932333AbWLZFwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 00:52:20 -0500
X-Greylist: delayed 1293 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 00:52:20 EST
From: "Paul Moore" <paul.moore@hp.com>
Subject: Re: selinux networking: sleeping functin called from invalid  context in 2.6.20-rc[12]
Date: 26 Dec 2006 00:30:00 -0500
To: <akpm@osdl.org>
X-Mailer: ChatterEmail+ for Treo 600/650/700p (2.1.2+)
Message-ID: <3249937847.23410275@mail.hp.com>
Cc: <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andrew Morton <akpm@osdl.org>
Date: Sunday, Dec 24, 2006 7:25 pm
Subject: Re: selinux networking: sleeping functin called from invalid  context in 2.6.20-rc[12]

On Mon, 25 Dec 2006 05:21:24 +0800
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>
>> 	Under 2.6.20-rc1 and 2.6.20-rc2, I get the following complaint
> for several network programs running on my system:
> 
> [  156.381868] BUG: sleeping function called from invalid context at net/core/sock.c:1523
> [  156.381876] in_atomic():1, irqs_disabled():0
> [  156.381881] no locks held by kio_http/9693.
> [  156.381886]  [<c01057a2>] show_trace_log_lvl+0x1a/0x2f
> [  156.381900]  [<c0105dab>] show_trace+0x12/0x14
> [  156.381908]  [<c0105e48>] dump_stack+0x16/0x18
> [  156.381917]  [<c011e30f>] __might_sleep+0xe5/0xeb
> [  156.381926]  [<c025942a>] lock_sock_nested+0x1d/0xc4
> [  156.381937]  [<c01cc570>] selinux_netlbl_inode_permission+0x5a/0x8e
> [  156.381946]  [<c01c2505>] selinux_file_permission+0x96/0x9b
> [  156.381954]  [<c0175a0a>] vfs_write+0x8d/0x167
> [  156.381962]  [<c017605a>] sys_write+0x3f/0x63
> [  156.381971]  [<c01040c0>] syscall_call+0x7/0xb
> [  156.381980]  =======================
> 
>
>There's a glaring bug in selinux_netlbl_inode_permission() - taking lock_sock() inside rcu_read_lock().
>
>I would again draw attention to Documentation/SubmitChecklist.  In
>particular please always always always enable all kernel debugging options when developing and testing new kernel code.  And everything else in that file, too.
>

I apologize for the mistake - I'm still trying to get a firm grasp on some of the finer points of Linux kernel development and I obviously missed something here.  Unfortunately, due to the holiday I won't be able to write/test/submit a patch until after the first of the year but I promise to do so as soon as I am able.

. paul moore
. linux security @ hp


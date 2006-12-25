Return-Path: <linux-kernel-owner+w=401wt.eu-S1753275AbWLYAZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbWLYAZb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 19:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbWLYAZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 19:25:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38816 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbWLYAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 19:25:29 -0500
Date: Sun, 24 Dec 2006 16:25:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Paul Moore <paul.moore@hp.com>
Subject: Re: selinux networking: sleeping functin called from invalid
 context in 2.6.20-rc[12]
Message-Id: <20061224162511.eaac4a89.akpm@osdl.org>
In-Reply-To: <20061225052124.A10323@freya>
References: <20061225052124.A10323@freya>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Dec 2006 05:21:24 +0800
"Adam J. Richter" <adam@yggdrasil.com> wrote:

> 	Under 2.6.20-rc1 and 2.6.20-rc2, I get the following complaint
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

There's a glaring bug in selinux_netlbl_inode_permission() - taking
lock_sock() inside rcu_read_lock().

I would again draw attention to Documentation/SubmitChecklist.  In
particular please always always always enable all kernel debugging options
when developing and testing new kernel code.  And everything else in that
file, too.

<guesses that this was tested on ia64>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTK2GVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 01:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTK2GVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 01:21:40 -0500
Received: from holomorphy.com ([199.26.172.102]:58820 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263680AbTK2GVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 01:21:39 -0500
Date: Fri, 28 Nov 2003 22:21:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: John Zielinski <grim@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
Message-ID: <20031129062136.GH8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Zielinski <grim@undead.cc>, linux-kernel@vger.kernel.org
References: <3FC82D8F.9030100@undead.cc> <20031129053128.GF8039@holomorphy.com> <3FC8394A.7010702@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC8394A.7010702@undead.cc>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Could you do a sysrq t and send in a backtrace?

On Sat, Nov 29, 2003 at 01:14:34AM -0500, John Zielinski wrote:
> Here's the trace for umount:
> umount        D DF9D98C0  3920   380    245                     (NOTLB)
[...]
> Call Trace:
> [<c015be66>] path_release+0x16/0x40
> [<c0169f59>] umount_tree+0xa9/0x100
> [<c01e169c>] rwsem_down_write_failed+0x8c/0x140
> [<c0155e0b>] .text.lock.super+0x12/0x187
> [<c016a22c>] sys_umount+0x3c/0x90
> [<c016a299>] sys_oldumount+0x19/0x20
> [<c010938f>] syscall_call+0x7/0xb

Looks like either namespace->sem or sb->s_umount; you should be able
to put some instrumentation code in down_write() and/or down_read() to
see who acquired it first by checking to see if the sem acquired belongs
to rootfs' sb or some namespace (doubtful you'll create many of them).


-- wli

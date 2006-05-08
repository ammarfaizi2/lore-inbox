Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWEHQBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWEHQBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEHQBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:01:34 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61324 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932381AbWEHQBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:01:34 -0400
Date: Mon, 8 May 2006 12:01:06 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: ntachino@jp.fujitsu.com, akpm@osdl.org, torvalds@osdl.org,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] __deprecated_for_modules: panic_timeout
Message-ID: <Pine.LNX.4.58.0605081149180.12205@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> tree 10b2b90d2fd270d86f381a06e535736ea7c16792
> parent 24622efd11fc5ee569b008b9f89e5e268265811b
> author Adrian Bunk <bunk@stusta.de> Mon, 07 Nov 2005 17:01:44 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 07 Nov 2005
> 23:54:08
> -0800
>
> [PATCH] __deprecated_for_modules: panic_timeout
>
> This looks like something which out-of-tree code could possibly be
> using.
> Give panic_timeout the twelve-month treatment.

Hi,

I found a user of panic_timeout.  The module diskdump:

 http://sourceforge.net/project/showfiles.php?group_id=110436

It uses the panic_timeout to actually implement the timeout after it
completes the dump.

diskdump is a light weight crash dump utility which works great for my
embedded devices that don't have much resources.  I don't know if it is
still maintained (I CC'd the reported author), but I'm hacking it quite a
bit.  The last release (1.0) was based off of 2.6.9.  I'm bringing it up
to 2.6.16 with some major changes.

Not sure if anyone cares about this module, but I felt like I should
report of one user.  But since the diskdump needs to modify the kernel
anyway, it could just remove the deprecated warning or export
panic_timeout itself.  So this isn't really an issue.

Just sending an FYI.

-- Steve


>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
>  Documentation/feature-removal-schedule.txt |    8 ++++++++
>  include/linux/kernel.h                     |    2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)



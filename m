Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTBDAaL>; Mon, 3 Feb 2003 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTBDAaL>; Mon, 3 Feb 2003 19:30:11 -0500
Received: from ns.suse.de ([213.95.15.193]:50955 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267070AbTBDAaL>;
	Mon, 3 Feb 2003 19:30:11 -0500
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug in arch/i386/kernel/process.c for reloading of debug registers (DRx)?
References: <20030203235140.10443.qmail@web80304.mail.yahoo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Feb 2003 01:39:43 +0100
In-Reply-To: Kevin Lawton's message of "4 Feb 2003 01:19:16 +0100"
Message-ID: <p7365s0ri9c.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Lawton <kevinlawton2001@yahoo.com> writes:

> I was scanning through the source and noticed the lines below.
> Should the code below, be reloading at least the local bits of
> DR7 if the current DR7 value != 0?  From a quick glance, it
> looks like only if the next task's DR7 value is non-zero,
> that DR7 is reloaded.  I'm wondering if this would leave
> a new task to receive "local" debug events for the previous
> task if prev->DR7!=0 && next->DR7==0.

The do_debug trap handler handles that. It checks that
the debug event is set in the current process before doing anything
and if they weren't they are clared.

So yes they leak, but only once and the user should never notice.

-Andi

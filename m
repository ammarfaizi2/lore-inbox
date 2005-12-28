Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVL1RqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVL1RqS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVL1RqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:46:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:59864 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932548AbVL1RqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:46:17 -0500
Message-ID: <3513371.1135791966050.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 28 Dec 2005 18:46:06 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051228154138.GA18798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_16)
Organization: SuSE Linux AG
References: <20051228114701.GC3003@elte.hu> <p734q4tb5na.fsf@verdi.suse.de> <20051228154138.GA18798@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi 28.12.2005 16:41 schrieb Ingo Molnar <mingo@elte.hu>:

>
> * Andi Kleen <ak@suse.de> wrote:
>
> > But one caveat: turning on unit-at-a-time makes objdump -S / make
> > foo/bar.lst with CONFIG_DEBUG_INFO essentially useless because
> > objdump
> > cannot deal with functions being out of order in the object file.
> > This
> > can be a big problem while analyzing oopses - essentially you have
> > to
> > analyze the functions without source level information. And with
> > unit-at-a-time they become bigger so it's more difficult.
> >
> > But I still think it's a good idea.
>
> hm, i dont seem to have problems with DEBUG_INFO. I picked a random
> address within the kernel:
>
> c035766f T schedule_timeout
>
> (gdb) list *0xc035768f
> 0xc035768f is in schedule_timeout (kernel/timer.c:1075).
> 1070 * should never happens anyway). You just have the printk()
> 1071 * that will tell you if something is gone wrong and where.
> 1072 */
> 1073 if (timeout < 0)
> 1074 {
> 1075 printk(KERN_ERR "schedule_timeout: wrong timeout "
> 1076 "value %lx from %p
", timeout,
> 1077 __builtin_return_address(0));
> 1078 current->state = TASK_RUNNING;
> 1079 goto out;
> (gdb)
>
> or is it something else that breaks?

It's objdump that breaks. Try objdump -S. gdb can deal with it, but you
can't generate
mixed C/assembly listings with it, so it's hard to match up the exact
lines.

(apparently it's possible through the gdb/mi interface, but I haven't
attempted
that yet)

-Andi




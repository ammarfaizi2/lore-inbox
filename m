Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQJ0Rs0>; Fri, 27 Oct 2000 13:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbQJ0RsQ>; Fri, 27 Oct 2000 13:48:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129359AbQJ0RsM>; Fri, 27 Oct 2000 13:48:12 -0400
Date: Fri, 27 Oct 2000 10:47:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: George Anzinger <george@mvista.com>
cc: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>,
        Nigel Gamble <nigel@mvista.com>
Subject: Re: Full preemption issues
In-Reply-To: <39F9BE56.DD81A8A3@mvista.com>
Message-ID: <Pine.LNX.4.10.10010271044211.1642-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2000, George Anzinger wrote:
> 
> First, as you know, we have added code to the spinlock macros to count
> up and down a preemption lock counter.  We would like to not do this if
> the macro also turns off local interrupts.  The issue here is that in
> some places in the code, spin_lock_irq() or spin_lock_irqsave() is
> called but spin_unlock_irq() or spin_lock_irqrestore() is not.  This, of
> course, confuses the preemption count.  Attached is a patch that
> addresses this issue.  At this time we are not asking you to apply this
> patch, but to indicate if we are moving in an acceptable direction.

Looks entirely sane to me.

> The second issue resolves around the naming conventions used in the
> kernel.  We want to extend this work to include the SMP kernel, but to
> do this we need to have several levels of names for the spinlock
> macros.  We note that the kernel uses "_" and "__" prefixes in some
> macros, but can not, by inspection, figure out when to uses these
> prefixes.  Could you explain this convention or is this wisdom written
> somewhere?

The "wisdom" is not written down anywhere, and is more a convention than
anything else. The convention is that a prepended "__" means that "this is
an internal routine, and you can use it, but you should damn well know
what you're doing if you do". For example, the most common use is for
routines that need external locking - the version that does its own
locking and is thus "safe" to use in normal circumstances has the regular
name, and the version of the routine that does no locking and depends on
the caller to lock for it has the "__" version.

Your proto code does not break this convention in any way..

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

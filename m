Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263517AbSKDAES>; Sun, 3 Nov 2002 19:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbSKDAER>; Sun, 3 Nov 2002 19:04:17 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:18320 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263517AbSKDAER>; Sun, 3 Nov 2002 19:04:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 3 Nov 2002 16:15:46 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <hch@lst.de>,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: interrupt checks for spinlocks
In-Reply-To: <20021103220816.GY16347@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0211031612250.954-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, William Lee Irwin III wrote:

> I recently thought about interrupt disablement and locking again, or
> at least such as has gone about in various places, and I got scared.
>
> Hence, a wee addition to CONFIG_DEBUG_SPINLOCK:
>
> (1) check that spinlocks are not taken in interrupt context without
> 	interrupts disabled
> (2) taint spinlocks taken in interrupt context
> (3) check for tainted spinlocks taken without interrupts disabled
> (4) check for spinlocking calls unconditionally disabling (and
> 	hence later re-enabling) interrupts with interrupts disabled
>
> The only action taken is printk() and dump_stack(). No arch code has
> been futzed with to provide irq tainting yet. Looks like a good way
> to shake out lurking bugs to me (somewhat like may_sleep() etc.).

Wouldn't it be interesting to keep a ( per task ) list of acquired
spinlocks to be able to diagnose cross locks in case of stall ?
( obviously under CONFIG_DEBUG_SPINLOCK )



- Davide



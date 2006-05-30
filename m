Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWE3XxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWE3XxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWE3XxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:53:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:42999 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932230AbWE3XxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:53:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eCkb3fckvwvhily9TatdwdQ1rVZHFNZk1HyWs1eQjzNqT9M94hT+zgf+D5O481qmqkcOqAr/RXiKnr2LAk50jHYPesuuQr8yTAQqqsSdYSIiz0cvpgOa3wUG0fT4VpNoau52Q8VA+q4PLxZHSQEEkCDS+TyoR7wqQJ46PakfFOI=
Message-ID: <6bffcb0e0605301653p4537ce33w7b7da629a2213b4c@mail.gmail.com>
Date: Wed, 31 May 2006 01:53:22 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
>

I resend this one. It contains additional debug info

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {in-hardirq-W} -> {hardirq-on-W} usage.
events/1/9 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&base->lock#2){++..}, at: [<c0128115>] run_timer_softirq+0x42/0x17a
{in-hardirq-W} state was registered at:
  [<c013869a>] lockdep_acquire+0x50/0x68
  [<c02eae04>] _spin_lock_irqsave+0x2d/0x3c
  [<c0128b42>] lock_timer_base+0x1f/0x3a
  [<c0128bfd>] __mod_timer+0x29/0xaa
  [<c0128f48>] mod_timer+0x32/0x36
  [<c02903da>] i8042_interrupt+0x21/0x1fb
  [<c014c0c8>] handle_IRQ_event+0x1d/0x52
  [<c014d007>] handle_edge_irq+0xc7/0x10c
  [<c01054ca>] do_IRQ+0x86/0xac
irq event stamp: 44459
hardirqs last  enabled at (44458): [<c02eb137>] _spin_unlock_irq+0x24/0x47
hardirqs last disabled at (44459): [<c02ead78>] _spin_lock_irq+0x11/0x38
softirqs last  enabled at (44446): [<c012492d>] __do_softirq+0xf0/0xf8
softirqs last disabled at (44453): [<c01053e5>] do_softirq+0x5e/0xbd

other info that might help us debug this:
1 locks held by events/1/9:
 #0:  (&base->lock#2){++..}, at: [<c0128115>] run_timer_softirq+0x42/0x17a

stack backtrace:
 [<c0104208>] show_trace+0x1b/0x20
 [<c01042e6>] dump_stack+0x1f/0x24
 [<c0136cbc>] print_usage_bug+0x1a5/0x1b1
 [<c01372ef>] mark_lock+0x21d/0x3e7
 [<c01374fc>] mark_held_locks+0x43/0x63
 [<c0138421>] trace_hardirqs_on+0xc4/0x10b
 [<c02eb512>] restore_nocheck+0x8/0xb
 =======================
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c02ead7f>] .... _spin_lock_irq+0x18/0x38
.....[<c0128115>] ..   ( <= run_timer_softirq+0x42/0x17a)
.. [<c011fe13>] .... vprintk+0x15/0x2e0
.....[<c01200f8>] ..   ( <= printk+0x1a/0x1c)
.. [<c02eadf2>] .... _spin_lock_irqsave+0x1b/0x3c
.....[<c011f923>] ..   ( <= release_console_sem+0x1f/0x1e5)

Here is dmesg
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-dmesg4

Here is config
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config4

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbUAJUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbUAJUG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:06:28 -0500
Received: from intra.cyclades.com ([64.186.161.6]:58568 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265433AbUAJUG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:06:26 -0500
Date: Sat, 10 Jan 2004 17:58:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Message-ID: <Pine.LNX.4.58L.0401101758010.1310@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------- Forwarded message ----------
Date: Sat, 10 Jan 2004 17:32:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Simon Kirby <sim@netnation.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.4.24 SMP lockups



On Fri, 9 Jan 2004, Simon Kirby wrote:

> 'lo all,

Hi Simon,

> We've had about 6 cases of this now, across 4 separate boxes.  Since
> upgrading to 2.4.24, our SMP web server boxes (both Intel and AMD
> hardware) are randomly blowing up.  This may have happened on 2.4.23 as
> well, but they weren't really running long enough to tell.  2.4.22 was
> fine.  GCC 3.3.3.
>
> These boxes are all dual CPU, and the failure case shows up suddenly with
> no warning.  Sysreq-P works, but only reports from one CPU no matter how
> many times I try.  In normal operation, every machine distributes all
> IRQs across both CPUs, and Sysreq-P reports from both CPUs.
>
> Mapping the EIP reported by Sysreq-P to symbols shows that the responding
> CPU is spinning on a spinlock (so far I have seen .text.lock.fcntl,
> .text.lock.sched, .text.lock.locks, and .text.lock.inode), which I assume
> is being held by the other (dead) CPU.

This sounds like a deadlock. I wonder why the NMI watchdog is not
triggering.

> Even on boxes with nmi_watchdog=1, nothing is reported from the NMI
> watchdog.

Can you share all available SysRQ-P output for the locked CPU ? SysRQ-T if
possible, too.

Can you please describe the hardware in more detail. Is there any common
hardware used in these boxes?


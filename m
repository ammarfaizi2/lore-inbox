Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbULXSVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbULXSVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULXSVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:21:15 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:16609 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261404AbULXSVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:21:12 -0500
Date: Fri, 24 Dec 2004 19:20:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [1/4]
Message-ID: <20041224182031.GG13747@dualathlon.random>
References: <20041224173519.GB13747@dualathlon.random> <20041224100016.530a004c.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224100016.530a004c.davem@davemloft.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 10:00:16AM -0800, David S. Miller wrote:
> On Fri, 24 Dec 2004 18:35:19 +0100
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > I made used_math a char at the light of later patches. per-cpu atomicity
> > with byte granularity is provided by all archs AFIK.
> 
> Older Alpha's need to read-modify-write a word to implement
> byte ops.

Yep, I remeber this was the case in some old alpha. But did they support
smp too? I can't see how that old hardware could support smp. If they're
UP they're fine.

The race is extremely tiny anyway, you'd need to write to the
/proc/<pid>/ file at the same time that used_math is toggled.

Or alternatively you'd need to kill the task due oom at the same time
used_math is toggled.

The race in PF_MEMDIE is more serious.

And false sharing with memdie and oomkilladj is zero, since they're
pratically readonly.

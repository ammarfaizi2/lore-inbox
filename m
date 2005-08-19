Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbVHSXjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbVHSXjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbVHSXjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:39:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:52917 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932754AbVHSXje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:39:34 -0400
Subject: Re: sleep under spinlock, sequencer.c, 2.6.12.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ptb@inv.it.uc3m.es
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508190813.j7J8Dml28378@inv.it.uc3m.es>
References: <200508190813.j7J8Dml28378@inv.it.uc3m.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Aug 2005 19:07:09 +0100
Message-Id: <1124474829.32050.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-19 at 10:13 +0200, Peter T. Breuer wrote:
> The following "sleep under spinlock" is still present as of linux
> 2.6.12.5 in sound/oss/sequencer.c in midi_outc:
> 
> 
>         n = 3 * HZ;             /* Timeout */
> 
>         spin_lock_irqsave(&lock,flags);
>         while (n && !midi_devs[dev]->outputc(dev, data)) {
>                 interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
>                 n--;
>         }
>         spin_unlock_irqrestore(&lock,flags);
> 
> 
> I haven't thought about it, just noted it. It's been there forever
> (some others in the sound architecture have been gradually disappearing
> as newer kernels come out).

Yep thats a blind substition of lock_kernel in an old tree it seems.
Probably my fault. Should drop it before the sleep and take it straight
after.


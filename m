Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUEWXdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUEWXdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUEWXdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:33:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46353 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263741AbUEWXdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:33:11 -0400
Date: Mon, 24 May 2004 00:33:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: scheduler: IRQs disabled over context switches
Message-ID: <20040524003308.B4818@flint.arm.linux.org.uk>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040523174359.A21153@flint.arm.linux.org.uk> <Pine.LNX.4.58.0405231125420.512@bigblue.dev.mdolabs.com> <20040523203814.C21153@flint.arm.linux.org.uk> <Pine.LNX.4.58.0405231241450.512@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0405231241450.512@bigblue.dev.mdolabs.com>; from davidel@xmailserver.org on Sun, May 23, 2004 at 04:04:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 04:04:39PM -0700, Davide Libenzi wrote:
> On Sun, 23 May 2004, Russell King wrote:
> > Not quite - look harder.  They use spin_unlock_irq in finish_arch_switch
> > rather than prepare_arch_switch.
> 
> Hmm, they do indeed. Hmm, if we release the rq lock before the ctx switch, 
> "prev" (the real one) will result not running since we already set 
> "rq->curr" to "next" (and we do not hold "prev->switch_lock").

We do hold prev->switch_lock - we hold it all the time that the thread
is running.  Consider what prepare_arch_switch() is doing - it's taking
the next threads switch_lock.  It only gets released _after_ we've
switched away from that thread.

So I think your analysis is flawed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

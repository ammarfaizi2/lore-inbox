Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUI3JGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUI3JGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 05:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUI3JGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 05:06:21 -0400
Received: from styx.suse.cz ([82.119.242.94]:38791 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S268609AbUI3JGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 05:06:08 -0400
Date: Thu, 30 Sep 2004 11:06:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readd panic blinking in 2.6
Message-ID: <20040930090637.GA7157@ucw.cz>
References: <m3llet4456.fsf@averell.firstfloor.org> <20040929132134.GA3770@ucw.cz> <20040930084224.GA28779@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930084224.GA28779@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 10:42:24AM +0200, Andi Kleen wrote:
> > 
> > Something like
> > 
> > 	spin_lock_irqsave(&i8042_lock, flags);
> > 	i8042_flush();
> > 	i8042_ctr &= ~I8042_CTR_KBDINT & ~I8042_CTR_AUXINT;
> > 	i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
> > 	i8042_wait_write();
> > 	i8042_write_data(0xed);
> > 	i8042_wait_read();
> > 	i8042_flush();
> > 	i8042_wait_write();
> > 	i8042_write_data(led);
> > 	i8042_wait_read();
> > 	i8042_flush();
> > 	spin_unlock_irqrestore(&i8042_lock, flags);
> > 
> > would be safer and more correct.
> 
> That all takes far too many locks.

Ouch, yes. Just ignore the locks then. As it is, it would deadlock
immediately.

> The risk of deadlocking during
> panic is too great. I think the delay is fine (worked great under 2.4),
> just need to fix the IBF issue you mentioned.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

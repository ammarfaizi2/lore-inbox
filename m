Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUI3Imt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUI3Imt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268317AbUI3Imt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:42:49 -0400
Received: from colin2.muc.de ([193.149.48.15]:60174 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268955AbUI3Imb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:42:31 -0400
Date: 30 Sep 2004 10:42:24 +0200
Date: Thu, 30 Sep 2004 10:42:24 +0200
From: Andi Kleen <ak@muc.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Readd panic blinking in 2.6
Message-ID: <20040930084224.GA28779@muc.de>
References: <m3llet4456.fsf@averell.firstfloor.org> <20040929132134.GA3770@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929132134.GA3770@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Something like
> 
> 	spin_lock_irqsave(&i8042_lock, flags);
> 	i8042_flush();
> 	i8042_ctr &= ~I8042_CTR_KBDINT & ~I8042_CTR_AUXINT;
> 	i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
> 	i8042_wait_write();
> 	i8042_write_data(0xed);
> 	i8042_wait_read();
> 	i8042_flush();
> 	i8042_wait_write();
> 	i8042_write_data(led);
> 	i8042_wait_read();
> 	i8042_flush();
> 	spin_unlock_irqrestore(&i8042_lock, flags);
> 
> would be safer and more correct.

That all takes far too many locks. The risk of deadlocking during
panic is too great. I think the delay is fine (worked great under 2.4),
just need to fix the IBF issue you mentioned.

-Andi


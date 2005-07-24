Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVGXITP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVGXITP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 04:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVGXITP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 04:19:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2313 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261927AbVGXITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 04:19:13 -0400
Date: Sun, 24 Jul 2005 09:19:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Airlie <airlied@gmail.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: fix suspend/resume irq request free for yenta..
Message-ID: <20050724091902.A4908@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Airlie <airlied@gmail.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Pavel Machek <pavel@ucw.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
References: <Pine.LNX.4.58.0507222331580.15287@skynet> <200507221816.19424.dtor_core@ameritech.net> <20050723002924.GA1988@elf.ucw.cz> <20050723084049.A7921@flint.arm.linux.org.uk> <Pine.LNX.4.61.0507230941280.16055@montezuma.fsmlabs.com> <21d7e997050723154057d36290@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <21d7e997050723154057d36290@mail.gmail.com>; from airlied@gmail.com on Sun, Jul 24, 2005 at 08:40:00AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 08:40:00AM +1000, Dave Airlie wrote:
> > > What if some other driver is sharing the IRQ, and requires IRQs to be
> > > enabled for the resume to complete?
> 
> All drivers re-enable IRQs on their way back up in their resume code,
> they shouldn't be doing anything before that point..

I think you missed the point.  If a driver resume method requires
to send some commands to the chip to restore it to the state it was
before it was suspended, and requires interrupts to complete that
operation.

This is quite possible if a device has child devices which will be
resumed after it has been resumed, and they share this interrupt.

This is why I think request_irq/free_irq is a better solution.

Alternatively, we need to go to a two stage resume model - 1st
stage to re-setup the devices such that they are in a quiescent
state, 2nd stage to complete.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

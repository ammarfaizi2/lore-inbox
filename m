Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318189AbSHIIgb>; Fri, 9 Aug 2002 04:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSHIIgb>; Fri, 9 Aug 2002 04:36:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56581 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318189AbSHIIga>; Fri, 9 Aug 2002 04:36:30 -0400
Date: Fri, 9 Aug 2002 09:40:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Albert Cranford <ac9410@attbi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] 2.5.30 i2c updates
Message-ID: <20020809094010.A29805@flint.arm.linux.org.uk>
References: <3D53359B.BC5980FB@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D53359B.BC5980FB@attbi.com>; from ac9410@attbi.com on Thu, Aug 08, 2002 at 11:23:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

btw, I'm Russell, not Rusty. 8)

On Thu, Aug 08, 2002 at 11:23:07PM -0400, Albert Cranford wrote:
> --- linux-2.5.26/drivers/i2c/i2c-elektor.c.orig 2002-07-05 19:42:02.000000000 -0400
> +++ linux/drivers/i2c/i2c-elektor.c     2002-08-07 22:39:08.000000000 -0400
>...
> @@ -121,12 +118,12 @@
>         int timeout = 2;
>  
>         if (irq > 0) {
> -               cli();
> +               spin_lock_irq(&irq_driver_lock);
>                 if (pcf_pending == 0) {
>                         interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );

Two points here:

- Sleeping with interrupts disabled.
- Use of interruptible_sleep_on_timeout().

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSHNIv0>; Wed, 14 Aug 2002 04:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318974AbSHNIv0>; Wed, 14 Aug 2002 04:51:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30729 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318526AbSHNIv0>; Wed, 14 Aug 2002 04:51:26 -0400
Date: Wed, 14 Aug 2002 09:55:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Albert Cranford <ac9410@attbi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/4] 2.5.31 i2c updates
Message-ID: <20020814095514.A2777@flint.arm.linux.org.uk>
References: <3D57BEDE.8F868A5E@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D57BEDE.8F868A5E@attbi.com>; from ac9410@attbi.com on Mon, Aug 12, 2002 at 09:57:50AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 09:57:50AM -0400, Albert Cranford wrote:
> @@ -121,12 +118,12 @@
>         int timeout = 2;
>  
>         if (irq > 0) {
> -               cli();
> +               spin_lock_irq(&irq_driver_lock);
>                 if (pcf_pending == 0) {
>                         interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
>                 } else
>                         pcf_pending = 0;
> -               sti();
> +               spin_unlock_irq(&irq_driver_lock);

In case you didn't get my previous message, sleeping with spinlocks held
is the perfect path to deadlock.  Also, scheduling with interrupts disabled
is not a good idea.  Unfortunately the code above does both.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


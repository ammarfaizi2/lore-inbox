Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVHaKJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVHaKJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 06:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVHaKJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 06:09:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37130 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750751AbVHaKJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 06:09:03 -0400
Date: Wed, 31 Aug 2005 11:08:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8250 serial driver and PM
Message-ID: <20050831110855.D26480@flint.arm.linux.org.uk>
Mail-Followup-To: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>,
	linux-kernel@vger.kernel.org
References: <43134BF8.1090706@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43134BF8.1090706@dev.rtsoft.ru>; from gtolstolytkin@dev.rtsoft.ru on Mon, Aug 29, 2005 at 09:55:04PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 09:55:04PM +0400, Grigory Tolstolytkin wrote:
> I'm working on power management support for a particular ARM based board 
> and I've got a question:
> I want to add a board specific power management for standard uart driver 
> (serial8250). For this purpose there is a special hook defined in 
> uart_8250_port structure (drivers/serial/8250.c):
> ...
>  >        /*
>  >        * We provide a per-port pm hook.
>  >         */
>  >        void                    (*pm)(struct uart_port *port,
>  >                                      unsigned int state, unsigned int 
> old);
> ...
> 
> When driver goes into suspend/resume, serial8250_pm() function is called 
> and it checks for the hook and executes it if it exists. But I didn't 
> find a proper way to assign my own function to this hook.

We probably want to pass it via the platform device - which probably
means changing that interface.

> How this hook is supposed to be changed?

It's something which wasn't thought about since there were very few
people wanting to use it, and further work needed to be done (as my
first comment) to allow it to be used - which basically meant changing
the initialisation paths to allow platform devices (now done).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

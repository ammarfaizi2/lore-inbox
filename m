Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUAMSaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAMSaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:30:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30724 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265094AbUAMS37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:29:59 -0500
Date: Tue, 13 Jan 2004 18:29:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PROBLEM] ircomm ioctls
Message-ID: <20040113182955.F7256@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040113181034.GA9960@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113181034.GA9960@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Jan 13, 2004 at 10:10:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 10:10:34AM -0800, Jean Tourrilhes wrote:
> Russell King wrote :
> > On Tue, Jan 13, 2004 at 12:00:15PM +0100, Jozef Vesely wrote:
> > > I am gettig this error (while connecting to my mobile phone):
> > > ------
> > > # gsmctl -d /dev/ircomm0  ALL
> > > gsmctl[ERROR]: clearing DTR failed (errno: 22/Invalid argument)
> > > ------
> > 
> > ircomm needs updating to use the tiocmset/tiocmget driver calls.  Could
> > you see if the following patch solves your problem please?
> 
> 	Good catch. Is there any other API changes worth looking into ?
> 
> 	By the way, I would rather keep the function
> ircomm_tty_tiocmget() and ircomm_tty_tiocmset() in ircomm_tty_ioctl.c,
> because ircomm_tty.c is already big and messy.
> 	Check the patch below (quickly tested).

I think this patch is missing some of the error checking (TTY_IO_ERROR)
which I included in my later patch.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

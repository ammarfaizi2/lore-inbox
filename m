Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVESHdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVESHdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 03:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVESHdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 03:33:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56082 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262429AbVESHdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 03:33:45 -0400
Date: Thu, 19 May 2005 08:33:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: George Anzinger <george@mvista.com>
Cc: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
Message-ID: <20050519083338.A28946@flint.arm.linux.org.uk>
Mail-Followup-To: George Anzinger <george@mvista.com>,
	Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050513184806.GA24166@redhat.com> <m1u0l4afdx.fsf@muc.de> <20050515130742.A29619@flint.arm.linux.org.uk> <m1ekc8adfl.fsf@muc.de> <428BDCAD.2090307@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <428BDCAD.2090307@mvista.com>; from george@mvista.com on Wed, May 18, 2005 at 05:24:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 05:24:13PM -0700, George Anzinger wrote:
> Um... I would think the real fix is to set the UART up to generate the modem 
> status interrupt and eliminate the pole loop.  Why can't this be done?  I, for 
> one, don't want my cpu looping in the serial driver, even more so with the 
> interrupt system off.  This, in my mind, is a real bug in the serial driver and 
> should be so handled.

Because printk is *synchronous*.  It never returns until it's written
the entire message.  There is no buffering.

Extra complexity, adding reliance on interrupts, etc all means that
you reduce the probability that you'll get the panic or oops message
out of the system.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVFVJM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVFVJM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVFVJKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:10:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61707 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262831AbVFVJCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:02:42 -0400
Date: Wed, 22 Jun 2005 10:02:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Eugeny S. Mints" <emints@ru.mvista.com>
Cc: Andrew Lewis <andrew-lewis@netspace.net.au>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Dwalker@Mvista. Com" <dwalker@mvista.com>
Subject: Re: ARM Linux Suitability for Real-time Application
Message-ID: <20050622100231.A28181@flint.arm.linux.org.uk>
Mail-Followup-To: "Eugeny S. Mints" <emints@ru.mvista.com>,
	Andrew Lewis <andrew-lewis@netspace.net.au>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	"Dwalker@Mvista. Com" <dwalker@mvista.com>
References: <42B8F6FB.2090203@netspace.net.au> <42B92791.9060800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42B92791.9060800@ru.mvista.com>; from emints@ru.mvista.com on Wed, Jun 22, 2005 at 12:55:45PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 12:55:45PM +0400, Eugeny S. Mints wrote:
> The bottom line is that interrupt and preemption latencies for a kernel 
> with RT patch are inbetween 15-150us. But of course even with real-time 
> patch you have to perform _real_ fine tuning of your system to achieve 
> such hard constraints you identified.

If you're just after some background process to run off interrupts with
minimal interrupt latency, the good news is that you don't have to modify
the kernel on ARM, and you certainly don't need any RT patches.

If you use the FIQ, then your FIQ latency will be the time it takes the
CPU to enter your FIQ function.  Since the kernel _never_ disables FIQs
in any way, FIQs have ultimate priority over everything else in the
system.

This does mean that you have to be careful if you want data to cross
the boundary between FIQ and the rest of the kernel since you can't use
any of the normal locking functions from FIQ mode.  Also, note that FIQ
code can not reside in modules.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

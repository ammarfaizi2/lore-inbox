Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVG2KiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVG2KiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVG2KiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:38:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18962 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262592AbVG2KiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:38:00 -0400
Date: Fri, 29 Jul 2005 11:37:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_times() return value
Message-ID: <20050729113755.E10345@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050718002446.B789@flint.arm.linux.org.uk> <20050723153531.7a5880c0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050723153531.7a5880c0.akpm@osdl.org>; from akpm@osdl.org on Sat, Jul 23, 2005 at 03:35:31PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 03:35:31PM +1000, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > ARM folk have recently pointed out a problem with sys_times().
> > When the kernel boots, we set jiffies to -5 minutes.  This causes
> > sys_times() to return a negative number, which increments through
> > zero.
> > 
> > However, some negative numbers are used to return error codes.
> > Hence, there's a period of time when sys_times() returns values
> > which are indistinguishable from error codes shortly after boot.
> 
> What a strange system call.
> 
> > This probably only affects 32-bit architectures.  However, one
> > wonders whether sys_times() needs force_successful_syscall_return().
> 
> I'd say so, yes.  But lots of architectures seem to have a no-op there.

As I mentioned below, these other architectures need glibc to be fixed.

> > Also, it appears that glibc does indeed interpret the return value
> > from sys_times in the way I describe above on at least ARM and x86.
> > Other architectures may be similarly affected.  Hopefully the ARM
> > glibc folk will raise a cross-architecture bug in glibc for this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVGQXYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVGQXYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 19:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVGQXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 19:24:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25353 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261445AbVGQXYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 19:24:50 -0400
Date: Mon, 18 Jul 2005 00:24:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: sys_times() return value
Message-ID: <20050718002446.B789@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

ARM folk have recently pointed out a problem with sys_times().
When the kernel boots, we set jiffies to -5 minutes.  This causes
sys_times() to return a negative number, which increments through
zero.

However, some negative numbers are used to return error codes.
Hence, there's a period of time when sys_times() returns values
which are indistinguishable from error codes shortly after boot.

This probably only affects 32-bit architectures.  However, one
wonders whether sys_times() needs force_successful_syscall_return().

Also, it appears that glibc does indeed interpret the return value
from sys_times in the way I describe above on at least ARM and x86.
Other architectures may be similarly affected.  Hopefully the ARM
glibc folk will raise a cross-architecture bug in glibc for this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

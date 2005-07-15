Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbVGOH3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbVGOH3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 03:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbVGOH3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 03:29:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9740 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263226AbVGOH3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 03:29:03 -0400
Date: Fri, 15 Jul 2005 08:28:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9: serial_core: uart_open
Message-ID: <20050715082859.B23102@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050714195717.B10410@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILEEAJCEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILEEAJCEAA.karl@petzent.com>; from karl@petzent.com on Thu, Jul 14, 2005 at 03:35:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 03:35:07PM -0700, karl malbrain wrote:
> AT LAST I HAVE SOME DATA!!!
> 
> The problem is that ALL SYSTEM CALLS to open "/dev/tty" are blocking!! even
> with O_NDELAY set and even from completely disjoint sessions.  I discovered
> this via issuing "strace sh".  That's why the new xterm windows froze.
> 
> The original process doing the open("/dev/ttyS1", O_RDWR) is listed in the
> ps aux listing as status S+.

Ok, 'S' means it's sleeping.

Can you enable Magic SYSRQ, and ensure that you have a large kernel
log buffer (the LOG_BUF_SHIFT configuration symbol).  Ensure that
/proc/sys/kernel/sysrq is 1, and re-run your test such that you have
something else waiting (eg, the strace sh).  Then hit Alt-SysRQ-T.

You can then read the kernel messages with dmesg - you may need the
-s argument to capture the entire kernel buffer.

This will tell us where all processes are sleeping.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

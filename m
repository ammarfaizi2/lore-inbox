Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423447AbWBBK1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423447AbWBBK1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423450AbWBBK1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:27:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7185 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423447AbWBBK1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:27:17 -0500
Date: Thu, 2 Feb 2006 10:27:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, chris@zankel.net,
       lethal@linux-sh.org
Subject: Re: [BUG] sizeof(struct async_icount) exported to userspace on SH, SH64 and xtensa
Message-ID: <20060202102708.GD5034@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	chris@zankel.net, lethal@linux-sh.org
References: <20060121185712.GA25185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121185712.GA25185@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sat, Jan 21, 2006 at 06:57:12PM +0000, Russell King wrote:
> I've just been looking through the remaining cruft in the serial
> drivers, and have come across this silly thing:
> 
> TIOCGICOUNT exports a structure to userspace called
> struct serial_icounter_struct.
> 
> However, sh, sh64 and xtensa do this:
> 
> include/asm-sh/ioctls.h:#define TIOCGICOUNT     _IOR('T', 93, struct async_icount) /* 0x545D */ /* read serial port inline interrupt counts */
> include/asm-sh64/ioctls.h:#define TIOCGICOUNT   0x802c545d      /* _IOR('T', 93, struct async_icount) 0x545D */ /* read serial port inline interrupt counts */
> include/asm-xtensa/ioctls.h:#define TIOCGICOUNT _IOR('T', 93, struct async_icount) /* read serial port inline interrupt counts */
> 
> What's more is that no driver actually exports async_icount, and
> async_icount is a kernel internal structure which does _not_ form
> part of the public API, and modifications to this will result in
> unexpected breakage on these platforms.
> 
> 100% for trying to clean up the tty ioctl definitions.  0% for
> using the wrong structures.  As such, these _require_ fixing.
> 
> Please document that your TIOCGICOUNT is broken and remove the
> dependence on the async_icount structure.  Thanks.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

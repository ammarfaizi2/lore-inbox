Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263114AbVCXMR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbVCXMR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbVCXMR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:17:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18185 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263114AbVCXMRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:17:54 -0500
Date: Thu, 24 Mar 2005 12:17:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Bitrotting serial drivers
Message-ID: <20050324121746.A4189@flint.arm.linux.org.uk>
Mail-Followup-To: Hirokazu Takata <takata@linux-m32r.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050324.191424.233669632.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050324.191424.233669632.takata.hirokazu@renesas.com>; from takata@linux-m32r.org on Thu, Mar 24, 2005 at 07:14:24PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 07:14:24PM +0900, Hirokazu Takata wrote:
> Could you please accept the following patch?

Probably, but I'd like to have a reply to my comments below first.

> diff -ruNp a/include/asm-m32r/serial.h b/include/asm-m32r/serial.h
> --- a/include/asm-m32r/serial.h	2004-12-25 06:35:40.000000000 +0900
> +++ b/include/asm-m32r/serial.h	2005-03-24 17:25:05.812651363 +0900

Can m32r accept PCMCIA cards?  If so, this may mean that 8250.c gets
built, which will use this file to determine where it should look for
built-in 8250 ports.

If this file is used to describe non-8250 compatible ports, you could
end up with a nasty mess.  Therefore, I recommend that you do not use
asm-m32r/serial.h to describe your SIO ports.

Instead, since these definitions are private to your own driver, you
may consider moving them into the driver, or a header file closely
associated with your driver in drivers/serial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

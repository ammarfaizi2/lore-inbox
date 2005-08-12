Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVHLTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVHLTmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVHLTmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:42:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14606 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751128AbVHLTmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:42:39 -0400
Date: Fri, 12 Aug 2005 20:42:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc, ppc64 build failures (allmodconfig, -latest)
Message-ID: <20050812204234.A21152@flint.arm.linux.org.uk>
Mail-Followup-To: Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050812183854.GA3204@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050812183854.GA3204@mipter.zuzino.mipt.ru>; from adobriyan@gmail.com on Fri, Aug 12, 2005 at 10:38:54PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:38:54PM +0400, Alexey Dobriyan wrote:
> 	sparc
> 
> drivers/char/ip2main.c:123:24: asm/serial.h: No such file or directory
> drivers/char/synclinkmp.c:58:24: asm/serial.h: No such file or directory

These drivers need to stop including asm/serial.h.  The only driver
which should include this file is drivers/serial/8250.c and no other.
It contains architecture specific definitions of the platforms 8250
ports.

It does not contain the default base baud (aka BASE_BAUD) for use with
a custom 8250 board, which is actually architecture independent.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

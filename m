Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVIHVb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVIHVb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbVIHVb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:31:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61966 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965008AbVIHVb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:31:57 -0400
Date: Thu, 8 Sep 2005 22:31:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
Message-ID: <20050908223152.E19542@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
References: <20050908212236.A19542@flint.arm.linux.org.uk> <20050908.132634.88719733.davem@davemloft.net> <Pine.LNX.4.58.0509081333450.3039@g5.osdl.org> <20050908.134259.51218842.davem@davemloft.net> <Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0509081418310.3039@g5.osdl.org>; from torvalds@osdl.org on Thu, Sep 08, 2005 at 02:22:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 02:22:37PM -0700, Linus Torvalds wrote:
> On Thu, 8 Sep 2005, David S. Miller wrote:
> > Ok, I'll revert the patch and fix the sunsab.c driver as
> > Russell indicated.  So much for type checking...
> 
> Actually, I think there's a simpler fix. Instead of reverting, how about 
> something like this?
> 
> (You might even remove the #ifdef inside the function by then, since "ch" 
> being a constant zero will make 90% of it go away anyway).
> 
> rmk? Davem?

Ok, I'll settle for this.

> ---
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -401,6 +401,9 @@ uart_handle_sysrq_char(struct uart_port 
>  #endif
>  	return 0;
>  }
> +#ifndef SUPPORT_SYSRQ
> +#define uart_handle_sysrq_char(port,ch,regs) uart_handle_sysrq_char(port, 0, NULL)
> +#endif
>  
>  /*
>   * We do the SysRQ and SAK checking like this...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

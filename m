Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269276AbTCBTCs>; Sun, 2 Mar 2003 14:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269277AbTCBTCs>; Sun, 2 Mar 2003 14:02:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21773 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269276AbTCBTCr>; Sun, 2 Mar 2003 14:02:47 -0500
Date: Sun, 2 Mar 2003 19:13:01 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.5.63: 'Debug: sleeping function called from illegal context
Message-ID: <20030302191300.B10914@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <3E62200D.2010505@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E62200D.2010505@colorfullife.com>; from manfred@colorfullife.com on Sun, Mar 02, 2003 at 04:15:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 04:15:25PM +0100, Manfred Spraul wrote:
> I would propose something like the attached patch - it handles all archs 
> that support disable_irq on an unregistered interrupt. The remaining 
> arch [which one, btw] must implement request_irq_disabled().
>...
> +{
> +	int retval;
> +	disable_irq(irq);
> +	retval = request_irq(irq, handler, irqflags, devname, dev_id);
> +	if (retval < 0)
> +		enable_irq(irq);
> +	return retval;
> +}
> +#endif

request_irq() explicitly enables the interrupt source no matter how many
times you call disable_irq() before hand.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


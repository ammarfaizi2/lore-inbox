Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283662AbRLEB0i>; Tue, 4 Dec 2001 20:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283657AbRLEB03>; Tue, 4 Dec 2001 20:26:29 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:44263 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S283660AbRLEB0R>; Tue, 4 Dec 2001 20:26:17 -0500
Date: Wed, 5 Dec 2001 02:26:10 +0100
From: Kurt Roeckx <Q@ping.be>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
Subject: Re: [PATCH] eepro100 - need testers
Message-ID: <20011205022610.A757@ping.be>
In-Reply-To: <E167w6n-0001dz-00@fenrus.demon.nl> <3C0D54DF.4E897B70@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0D54DF.4E897B70@sun.com>; from thockin@sun.com on Tue, Dec 04, 2001 at 02:57:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 02:57:35PM -0800, Tim Hockin wrote:
> -#define TX_RING_SIZE	32
> -#define RX_RING_SIZE	32
> +#define TX_RING_SIZE	64
> +#define RX_RING_SIZE	1024

Why do I have the feeling that you're just changing those values
so you get less chance of having the problem?  Are there any
other reason why you change this?  It might even be a good idea
to test it with lower values.


> -			} else if ((status & 0x003c) == 0x0008) { /* No resources. */
> -				struct RxFD *rxf;
> -				printk(KERN_WARNING "%s: card reports no resources.\n",
> -						dev->name);

[...]

> +		switch ((status >> 2) & 0xf) {
> +		case 0: /* Idle */
> +			break;
> +		case 1:	/* Suspended */
> +		case 2:	/* No resources (RxFDs) */
> +		case 9:	/* Suspended with no more RBDs */
> +		case 10: /* No resources due to no RBDs */
> +		case 12: /* Ready with no RBDs */
> +			speedo_rx_soft_reset(dev);
> +			break;

You can also argue that you're trying to fix the problem by
hiding it.  It would be useful that it still reported the same
error message, so you can see that if it happens again with the
patch that it no longer locks up.


Kurt


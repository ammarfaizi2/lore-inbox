Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbSKCRwm>; Sun, 3 Nov 2002 12:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSKCRwm>; Sun, 3 Nov 2002 12:52:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17931 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262290AbSKCRwl>; Sun, 3 Nov 2002 12:52:41 -0500
Date: Sun, 3 Nov 2002 17:59:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5-AC] cistpl.c pcibios_read_config_dword
Message-ID: <20021103175910.D5589@flint.arm.linux.org.uk>
Mail-Followup-To: Zwane Mwaikambo <zwane@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211031123520.14075-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211031123520.14075-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Sun, Nov 03, 2002 at 11:43:24AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 11:43:24AM -0500, Zwane Mwaikambo wrote:
> Sorry untested :/
> 
> Index: linux-2.5.44-ac5/drivers/pcmcia/cistpl.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.44-ac5/drivers/pcmcia/cistpl.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 cistpl.c
> --- linux-2.5.44-ac5/drivers/pcmcia/cistpl.c	3 Nov 2002 07:19:08 -0000	1.1.1.1
> +++ linux-2.5.44-ac5/drivers/pcmcia/cistpl.c	3 Nov 2002 16:32:36 -0000
> @@ -429,7 +429,7 @@
>  #ifdef CONFIG_CARDBUS
>      if (s->state & SOCKET_CARDBUS) {
>  	u_int ptr;
> -	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
> +	pci_read_config_dword(s->cap.cb_dev, PCI_CARDBUS_CIS, &ptr);
>  	tuple->CISOffset = ptr & ~7;
>  	SPACE(tuple->Flags) = (ptr & 7);
>      } else

There is a patch that fixes this floating around.  The above isn't correct,
because we don't want to read s->cap.cb_dev (which is the bridge), but we
want to read the cardbus device that was just plugged in.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


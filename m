Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268707AbUI2Qp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268707AbUI2Qp4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268710AbUI2Qpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:45:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29459 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268707AbUI2Qpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:45:41 -0400
Date: Wed, 29 Sep 2004 17:45:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: Re: PATCH: 3c59x 00:00:00:00:00:00 MAC failure
Message-ID: <20040929174530.D16537@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, jgarzik@pobox.com
References: <20040929163023.GA17899@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040929163023.GA17899@devserv.devel.redhat.com>; from alan@redhat.com on Wed, Sep 29, 2004 at 12:30:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 12:30:23PM -0400, Alan Cox wrote:
> The 3com EEPROM has a checksum but unfortunately it seems that a zapped
> EEPROM returning all zero values passes the checksum test fine and we try
> and use it. 
> 
> 
> --- drivers/net/3c59x.c~	2004-09-29 17:23:42.964453264 +0100
> +++ drivers/net/3c59x.c	2004-09-29 17:28:40.358242536 +0100
> @@ -1295,6 +1295,13 @@
>  		for (i = 0; i < 6; i++)
>  			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
>  	}
> +	/* Unfortunately an all zero eeprom passes the checksum and this
> +	   gets found in the wild in failure cases. Crypto is hard 8) */
> +	if (memcmp(dev->dev_addr, "\0\0\0\0\0", 6) == 0) {

Shouldn't this be using is_valid_ether_addr() ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUEQXTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUEQXTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUEQXTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:19:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26536 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263124AbUEQXTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:19:02 -0400
Message-ID: <40A94857.9030507@pobox.com>
Date: Mon, 17 May 2004 19:18:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com>	<40A40204.1060509@pobox.com>	<40A93DA5.4020701@hp.com>	<20040517160508.63e1ddf0.akpm@osdl.org> <20040517161212.659746db.akpm@osdl.org>
In-Reply-To: <20040517161212.659746db.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +static inline u64 readq(void *addr)
> +{
> +	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> +}
> +
> +static inline void writeq(u64 v, void *addr)
> +{
> +	writel(v & 0xffffffff, addr);
> +	writel(v >> 32, addr + 4);
> +}


Seems sane, though I wonder about two things:

* better home is probably asm-generic

* It seems to me that a poorly-written writel() macro might prefer some 
guarantee that it's argument is pre-cast to u32.  I dunno if this is 
just paranoia or not.



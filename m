Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270675AbTG0F2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 01:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270676AbTG0F2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 01:28:25 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:9688 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270675AbTG0F2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 01:28:20 -0400
Message-ID: <3F236A4A.2090302@genebrew.com>
Date: Sun, 27 Jul 2003 01:59:38 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Penna Guerra <eu@marcelopenna.org>
CC: Andrew de Quincey <adq_dvb@lidskialf.net>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net> <3F235B73.70701@genebrew.com> <200307262326.49638.eu@marcelopenna.org>
In-Reply-To: <200307262326.49638.eu@marcelopenna.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Penna Guerra wrote:
> Hi,
> 
>>From nvnet.c:
> 
>    /* 
>      * Mac address is loaded at boot time into h/w reg, but it's loaded 
> backwards
>      * we get the address, save it, and reverse it. The saved value is loaded
>      * back into address at close time.
>      */
> 
> PRINTK(DEBUG_INIT, "nvnet_init - get mac address\n");
>     priv->hwapi->pfnGetNodeAddress(priv->hwapi->pADCX, priv-
> 
>>original_mac_addr);

Well, I wanted to reload the module with debug on, so I tried:

# modprobe -r nvnet
Segmentation fault

#lsmod

At this point lsmod just hung.

Tried shutting down the computer, and it was stuck during shutdown. 
Seems like the refcounting is not really working, or perhaps there are 
too many cycles happening. What happens if you do the following with a 
module:

try_module_get
MOD_INC_USE_COUNT
MOD_DEC_USE_COUNT
module_put

> But I don't think the only thing missing is the MAC address. You could try to 
> manually set it in the source itself and see if anything works.

I'll just add it in BIOS and try with AMD8111. No desire to futz around 
with the nvnet source, where half of what is going on is a complete 
black box (priv->hwapi, "priv" is definitely *private*).

Thanks,
Rahul


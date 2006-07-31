Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWGaXuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGaXuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWGaXuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:50:55 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:62013 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751497AbWGaXux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:50:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=a7i1a0xhqVOFifCxw54OgbYC1PU4kn93cQQVn82T7Nv3QHvS4Fni3ZyEvXmoQfeKNHDHzQeIrhPr9m9rsjO6z69Cy3+Sftn8JWv4qMA3YRZYZURWNcyk+nTJs4A3+zJVfaV0wRwkZtLVK2ZrTcq1OkT2inlJx249hruDYxtQBZQ=
Message-ID: <44CE974B.1090605@gmail.com>
Date: Tue, 01 Aug 2006 07:50:35 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] crash in aty128_set_lcd_enable on PowerBook
References: <20060716163728.GA16228@suse.de> <20060731185024.GA5117@suse.de>
In-Reply-To: <20060731185024.GA5117@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
>  On Sun, Jul 16, Olaf Hering wrote:
> 
>> Current Linus tree crashes in aty128_set_lcd_enable() because par->pdev
>> is NULL. This happens since at least a week. Call trace is:
>>
>> aty128_set_lcd_enable
>> aty128fb_set_par
>> fbcon_init
>> visual_init
>> take_over_console
>> fbcon_takeover
>> notifier_call_chain
>> blocking_notifier_call_chain
>> register_framebuffer
>> aty128fb_probe
>> pci_device_probe
>> bus_for_each_dev
>> driver_attach
>> bus_add_driver
>> driver_register
>> __pci_register_driver
>> aty128fb_init
>> init
>> kernel_thread
>>
> 
> 
> - info->fix was assigned twice.
> - par->vram_size is assigned in aty128_probe(), no need to redo it again in aty128_init()
> - register_framebuffer() uses uninitialized struct members,
>   move it past par->pdev assignment and past aty128_bl_init().
> 
> 

Looks good.

> Signed-off-by: Olaf Hering <olh@suse.de>
Acked-by: Antonino Daplas <adaplas@pol.net>



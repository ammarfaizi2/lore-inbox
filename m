Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265228AbUELVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUELVNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUELVMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:12:43 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:1469 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263750AbUELVHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:07:49 -0400
Message-ID: <40A29211.2010707@colorfullife.com>
Date: Wed, 12 May 2004 23:07:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alec H. Peterson" <ahp@hilander.com>
CC: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>,
       netdev@oss.sgi.com
Subject: Re: PCI memory reservation failure - 2.4/2.6
References: <BDD74A21E0B47FEAC3AB8A10@[192.168.0.100]>
In-Reply-To: <BDD74A21E0B47FEAC3AB8A10@[192.168.0.100]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alec H. Peterson wrote:

> + #if 1
> +         if (!(type & IORESOURCE_IO) && (((end - start) < 
> BRIDGE_SIZE_MIN) ||
> +             (start & (end - start))))
> +       {
> +               printk(KERN_INFO "yenta %s: Preassigned resource start 
> %lx end %lx too small or not aligned.\n", socket->dev->slot_name, 
> start, end);
> +                 res->start = res->end = 0;
> +         } 

I'm not sure if this is the right approach - what if a bios 
intentionally assigns a small area? It's dangerous to override the BIOS 
setting.
I'd prefer a kernel command line parameter / module parameter / dmi 
based override instead of an unconditional override based on the minimum 
size.
I'll think about it.

--
    Manfred


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVLXT4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVLXT4e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 14:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVLXT4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 14:56:34 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:5302 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750703AbVLXT4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 14:56:34 -0500
Message-ID: <43ADA7D0.9010908@colorfullife.com>
Date: Sat, 24 Dec 2005 20:56:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
References: <43AD4ADC.8050004@colorfullife.com> <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Of course, on the alloc path, it seems to add an additional 
>"NV_RX_ALLOC_PAD" thing, so maybe the "end-data" thing makes sense.
>
>  
>
The problem is the pci_unmap_single() call that happens during 
nv_close() or the rx interrupt handler. I think it makes more sense to 
rely on fields in the individual skb instead of reading from 
np->rx_buf_sz. If np->rx_buf_sz changes inbetween, then we have a memory 
leak.

--
    Manfred

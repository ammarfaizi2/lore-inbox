Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbUL0Rm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUL0Rm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUL0Rm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:42:27 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:33677 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261935AbUL0RmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:42:24 -0500
Message-ID: <41D04977.2040902@colorfullife.com>
Date: Mon, 27 Dec 2004 18:42:15 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: kmalloc packet slab
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Why 1620 bytes ?
>
Because then 5 objects will fit into one 8 kB memory block:
5*1620+slab control structure.

> Most drivers allocate packet_size + 2 bytes.
>dev_alloc_skb adds another 16 bytes, finally alloc_skb adds
>sizeof(struct skb_shared_info). 
>
>  
>
>(32bit): 1514b + 2b + 16b + 160b = 1692b
>(64bit): 1514b + 2b + 16b + 312b = 1844b
>
>  
>
Hmm. If the shared_info is that large then the patch won't help much.

Alan - what is printed in the /proc/slabinfo line for the new cache?
- 1620 bytes is probably a bit too much for archs with 128 byte cache 
lines and 8 kB pages. If I've calculated correctly, only 4 will fit into 
one page.
- if the shared info is really that large - is the patch actually useful?

--
    Manfred


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVDRMKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVDRMKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVDRMKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:10:44 -0400
Received: from Smtp2.univ-nantes.fr ([193.52.82.19]:36258 "EHLO
	smtp2.univ-nantes.fr") by vger.kernel.org with ESMTP
	id S262050AbVDRMKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:10:34 -0400
Message-ID: <4263A3B7.6010702@univ-nantes.fr>
Date: Mon, 18 Apr 2005 14:10:31 +0200
From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Organization: CRIUN
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz>
In-Reply-To: <20050414214828.GB9591@mail.muni.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek a écrit :

>Hello,
>
>today I tried 2.6.11.7 kernel with hoping that allocation failures disappear.
>Unfortunately they did not.
>
>Default min_free_kb is 3200kB.
>
>Here is stack trace:
>
>swapper: page allocation failure. order:0, mode:0x20
> [<c0139783>] __alloc_pages+0x2b3/0x420
> [<c013c4f1>] kmem_getpages+0x31/0xa0
> [<c013d22e>] cache_grow+0xae/0x160
> [<c0342b50>] ip_rcv_finish+0x0/0x280
> [<c013d45b>] cache_alloc_refill+0x17b/0x230
> [<c013d7d8>] __kmalloc+0x88/0xa0
> [<c0327ce7>] alloc_skb+0x47/0xf0
> [<c02bff97>] e1000_alloc_rx_buffers+0x57/0x100
> [<c02bfc3f>] e1000_clean_rx_irq+0x1bf/0x4c0
>  
>
I have those problems too. The (temporary ?) fix is to raise the
min_free_kb to an higher value.
echo 65535 > /proc/sys/vm/min_free_kbytes

Maybe such an high value is totally silly, but at least I don't have
those messages.

Sincerely yours,

-- 
Yann Dupont, Cri de l'université de Nantes
Tel: 02.51.12.53.91 - Fax: 02.51.12.58.60 - Yann.Dupont@univ-nantes.fr


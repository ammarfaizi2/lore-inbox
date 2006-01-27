Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWA0AiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWA0AiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWA0AiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:38:07 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36072 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1030252AbWA0AiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:38:06 -0500
Date: Fri, 27 Jan 2006 01:35:11 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Garzik <jgarzik@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [lock validator] drivers/net/8139too.c: deadlock?
Message-ID: <20060127003511.GA10871@electric-eye.fr.zoreil.com>
References: <20060126224312.GA2779@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126224312.GA2779@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> :
[...]
> i'm wondering, is this a genuine deadlock, or a false positive? The 
> dependency chain is quite complex, but looks realistic:
> 
>   -> #4 {&dev->xmit_lock}: [<c045294b>] dev_watchdog+0x1b/0xc0
>   -> #3 {&dev->queue_lock}: [<c0447154>] dev_queue_xmit+0x64/0x290
>   -> #2 {&((sk)->sk_lock.slock)}: [<c043eb66>] sk_clone+0x66/0x200
>   -> #1 {&((sk)->sk_lock.slock)}: [<c047a116>] tcp_v4_rcv+0x726/0x9d0
>   -> #0 {&tp->rx_lock}: [<c033e460>] rtl8139_tx_timeout+0x110/0x1f0

It looks like watchdog racing against rx_poll (which should/can not
happen). Do you have something specific in mind ?

--
Ueimor

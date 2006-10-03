Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030607AbWJCWT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030607AbWJCWT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWJCWT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:19:56 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:4556 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030610AbWJCWTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:19:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/4]: Spidernet stop queue when queue is full
Date: Wed, 4 Oct 2006 00:19:42 +0200
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, jeff@garzik.org, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
References: <20061003205240.GE4381@austin.ibm.com> <20061003205729.GF4381@austin.ibm.com>
In-Reply-To: <20061003205729.GF4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610040019.43028.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 22:57, Linas Vepstas wrote:
> +       if ((chain->head->next == chain->tail->prev) ||
> +          (spider_net_get_descr_status(descr) != SPIDER_NET_DESCR_NOT_IN_USE)) {
>                 result = NETDEV_TX_LOCKED;
>                 goto out;
>         }

...

>  out:
> -       netif_wake_queue(netdev);
> +       card->netdev_stats.tx_dropped++;
> +       netif_stop_queue(netdev);
>         return result;
>  }

Hmm, this looks a little strange to me. I would assume that we should not
stop the queue when the device is locked, but only when it is busy.

I would assume though that the fix is to return NETDEV_TX_BUSY instead
of NETDEV_TX_LOCKED in the case above, while the netif_stop_queue()
is correct here.

	Arnd <><

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRGNUiJ>; Sat, 14 Jul 2001 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbRGNUh7>; Sat, 14 Jul 2001 16:37:59 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264932AbRGNUhm>; Sat, 14 Jul 2001 16:37:42 -0400
Subject: Re: [PATCH] ppp_generic.c: last_channel_index
To: brian.kuschak@skystream.com (Brian Kuschak)
Date: Sat, 14 Jul 2001 21:38:23 +0100 (BST)
Cc: paulus@linuxcare.com.au ('paulus@linuxcare.com.au'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A02BBD74B@SERVER1> from "Brian Kuschak" at Jul 14, 2001 12:30:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LWBD-0001iG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> get an Oops.  PPP daemon would try to allocate strange PPP interface numbers
> (ppp12, for example) and other sanity checks would fail (kind != INTERFACE
> || CHANNEL)
> 
> The last_channel_index wasn't being cleaned up when the channel was closed,
> leading to these problems the next time a PPP channel was opened.  This
> patch fixes the problem for me.

Im not convinced this is the actual problem I must admit

>         spin_lock_bh(&all_channels_lock);
> +       last_channel_index--;
>         list_del(&pch->file.list);
>         spin_unlock_bh(&all_channels_lock);

Suppose you open channel 0, then 1, then 2, then close 0. Your last_channel_index
is now wrong.

Certainly we should be reusing channel ids but I dont think its as simple as
your patch. The obvious question therefore is why does it work


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbSJGTqP>; Mon, 7 Oct 2002 15:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbSJGTqO>; Mon, 7 Oct 2002 15:46:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26018 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262652AbSJGTqL>; Mon, 7 Oct 2002 15:46:11 -0400
Date: Mon, 7 Oct 2002 16:13:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.20-pre9 - drivers/atm/iphase.c : GFP_KERNEL with
 spinlock held
In-Reply-To: <20021005225410.A22417@fafner.intra.cogenit.fr>
Message-ID: <Pine.LNX.4.44L.0210071613320.21638-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Oct 2002, Francois Romieu wrote:

> drivers/atm/iphase.c:tx_intr()
> [...]
>    1684            spin_lock_irqsave(&iadev->tx_lock, flags);
>    1685            ia_tx_poll(iadev);
>
> ia_tx_poll ->
>  ia_hack_tcq ->
>   ia_enque_rtn_q ->
>    IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>
> Driver does not seem maintained. Please apply.
>
> --- linux-2.4.20-pre9.orig/drivers/atm/iphase.c	Sat Oct  5 15:51:28 2002
> +++ linux-2.4.20-pre9/drivers/atm/iphase.c	Sat Oct  5 22:44:18 2002
> @@ -124,7 +124,7 @@ static void ia_enque_head_rtn_q (IARTN_Q
>  }
>
>  static int ia_enque_rtn_q (IARTN_Q *que, struct desc_tbl_t data) {
> -   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
>     if (!entry) return -1;
>     entry->data = data;
>     entry->next = NULL;

It seems correct. Have you tried to send this to Peter Wang
<pwang@iphase.com> ?



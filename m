Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289212AbSAGNmL>; Mon, 7 Jan 2002 08:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289213AbSAGNly>; Mon, 7 Jan 2002 08:41:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18438 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289212AbSAGNlp>; Mon, 7 Jan 2002 08:41:45 -0500
Subject: Re: [PATCH] removed socket buffer in unix domain socket
To: yasuma@miraclelinux.com (Yasuma Takeda)
Date: Mon, 7 Jan 2002 13:53:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020107173944.05623687.yasuma@miraclelinux.com> from "Yasuma Takeda" at Jan 07, 2002 05:39:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NaD0-0001Hs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                  */
> -                               if(UNIXCB(skb).fp)
> +                               if(s->dead && UNIXCB(skb).fp)
>                                 {

The bug may be real but the fix would prevent garbage collection working
at all - which I grant would fix the problem. 

You don't need a socket to be dead to want to garbage collect it. If a
socket is getting disposed of while in use then there is a
maybe_unmark_and.. call missing, or a lock on the unix socket table missing
somewhere.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSFZBSo>; Tue, 25 Jun 2002 21:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFZBSn>; Tue, 25 Jun 2002 21:18:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24082 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316223AbSFZBSm>; Tue, 25 Jun 2002 21:18:42 -0400
Date: Tue, 25 Jun 2002 21:23:30 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Simon Kirby <sim@netnation.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1
In-Reply-To: <20020625230607.GA13960@netnation.com>
Message-ID: <Pine.LNX.4.44.0206252122520.10492-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simon,

This fix is on my BK tree since yesterday.

Thanks anyway


On Tue, 25 Jun 2002, Simon Kirby wrote:

> Hello,
>
> This fix did not yet make it in to the tg3 driver as of -rc1.  This patch
> fixes an occasional crash problem with several of our boxes and the tg3
> driver (fix from Jes).
>
> --
>
> Hi Dave
>
> Here's another one, tg3_recycle_rx() needs to declare dest_idx_unmasked
> as unsigned int or it will do funny stuff on modular division once we go
> above 31 bit values.
>
> I don't think this is the bug that Scott was hitting, but it is of
> course possible. It takes about 120 minutes for me with a packet
> generator, spewing out 64 byte packets, to trigger it.
>
> Cheers,
> Jes
>
> --- ../orig/drivers/net/tg3.c	Tue May 14 07:30:52 2002
> +++ drivers/net/tg3.c	Fri Jun 14 11:20:48 2002
> @@ -1689,7 +1669,7 @@
>   * tg3_alloc_rx_skb for full details.
>   */
>  static void tg3_recycle_rx(struct tg3 *tp, u32 opaque_key,
> -			   int src_idx, int dest_idx_unmasked)
> +			   int src_idx, u32 dest_idx_unmasked)
>  {
>  	struct tg3_rx_buffer_desc *src_desc, *dest_desc;
>  	struct ring_info *src_map, *dest_map;
>
> --
>
> Simon-
>
> [  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
> [       sim@stormix.com       ][       sim@netnation.com        ]
> [ Opinions expressed are not necessarily those of my employers. ]
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSFYXGL>; Tue, 25 Jun 2002 19:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSFYXGK>; Tue, 25 Jun 2002 19:06:10 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:24974 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S315925AbSFYXGJ>;
	Tue, 25 Jun 2002 19:06:09 -0400
Date: Tue, 25 Jun 2002 16:06:07 -0700
From: Simon Kirby <sim@netnation.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1
Message-ID: <20020625230607.GA13960@netnation.com>
References: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This fix did not yet make it in to the tg3 driver as of -rc1.  This patch
fixes an occasional crash problem with several of our boxes and the tg3
driver (fix from Jes).

--

Hi Dave

Here's another one, tg3_recycle_rx() needs to declare dest_idx_unmasked
as unsigned int or it will do funny stuff on modular division once we go
above 31 bit values.

I don't think this is the bug that Scott was hitting, but it is of
course possible. It takes about 120 minutes for me with a packet
generator, spewing out 64 byte packets, to trigger it.

Cheers,
Jes

--- ../orig/drivers/net/tg3.c	Tue May 14 07:30:52 2002
+++ drivers/net/tg3.c	Fri Jun 14 11:20:48 2002
@@ -1689,7 +1669,7 @@
  * tg3_alloc_rx_skb for full details.
  */
 static void tg3_recycle_rx(struct tg3 *tp, u32 opaque_key,
-			   int src_idx, int dest_idx_unmasked)
+			   int src_idx, u32 dest_idx_unmasked)
 {
 	struct tg3_rx_buffer_desc *src_desc, *dest_desc;
 	struct ring_info *src_map, *dest_map;

--

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

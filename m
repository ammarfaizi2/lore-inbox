Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbSI3LDO>; Mon, 30 Sep 2002 07:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262016AbSI3LDN>; Mon, 30 Sep 2002 07:03:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4814 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262015AbSI3LDM>; Mon, 30 Sep 2002 07:03:12 -0400
Date: Mon, 30 Sep 2002 13:08:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jochen Friedrich <jochen@scram.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 compile errors on Alpha
In-Reply-To: <Pine.NEB.4.44.0209300934330.7633-100000@www2.scram.de>
Message-ID: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Jochen Friedrich wrote:

> Hi,

Hi Jochen,

> these are the errors i found in my log from a "make -k modules" on Alpha:
>
> drivers/atm/atmtcp.c:
>
> atmtcp.c:278: incompatible types in assignment

this is a known issue, the following patch (already in Linus' BK tree)
fixes it:

--- linux-2.5.35-VIRGIN/drivers/atm/atmtcp.c	2002-08-24 00:08:21.000000000 -0700
+++ linux-2.5.35/drivers/atm/atmtcp.c	2002-09-16 21:04:30.000000000 -0700
@@ -275,7 +275,7 @@
 		result = -ENOBUFS;
 		goto done;
 	}
-	new_skb->stamp = xtime;
+	do_gettimeofday(&new_skb->stamp);
 	memcpy(skb_put(new_skb,skb->len),skb->data,skb->len);
 	out_vcc->push(out_vcc,new_skb);
 	atomic_inc(&vcc->stats->tx);

>...
> drivers/md/lvm.c:
>
> lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling
>
> drivers/md/lvm-snap.c:
>
> lvm-snap.c:248: incompatible type for argument 1 of `block_size'
>...

LVM is currently completely broken, see the current discussions about how
to get LVM2 into 2.5 before Halloween.

> Cheers,
> --jochen
>...

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132279AbRANMIx>; Sun, 14 Jan 2001 07:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRANMIf>; Sun, 14 Jan 2001 07:08:35 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:22801 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S132279AbRANMI1>;
	Sun, 14 Jan 2001 07:08:27 -0500
Date: Sun, 14 Jan 2001 13:08:16 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: "David S. Miller" <davem@redhat.com>
cc: Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <14945.28354.209720.579437@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101141253590.16758-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Igmar Palsenberg writes:
>
>  > we might want to consider changing the error the call gives in case
>  > MULTIPLE_TABLES isn't set. -EINVAL is ugly, -ENOSYS should make the error
>  > more clear..
>
> How do I tell the difference between using the wrong system call
> number to invoke an ioctl or socket option change, and making a
> call for a feature I haven't configured into my kernel?

The large tables option is rather strange : Looking at the name I start
thinking that the option is actually already there, but this option
enlarges this table.

When the kernel return -EINVAL I start thinking that the call is actually
supported, but the userspace stuff sends garbage. In this case, it sends
valid data, bit the call isn't there.

I haven't had a real good look at the code, but we might change the
behaviour so that the call fails (same case if NETLINK isn't compiled in,
you get an error when creating the socket).

If this isn't possible (if we don't know what userspace wants when
creating the socket, it's a good idea to print an aditional hint saying
'you might want to compile LARGE TABLES option'.

> I think ENOSYS is just a bad a choice.

Maybe time for a ENOTSUPPORTED or so ?

The config option says :

'If you have routing zones that grow to more than about 64 entries, you
may want to say Y here to speed up the routing process'

Which I assume that it just enlarges the table.

-ENOSYS is bad in this case indeed, but -EINVAL is also bad IMHO.



	Regards,

		Igmar
-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

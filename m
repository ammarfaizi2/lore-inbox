Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293020AbSBVWE1>; Fri, 22 Feb 2002 17:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293021AbSBVWES>; Fri, 22 Feb 2002 17:04:18 -0500
Received: from linux.kappa.ro ([194.102.255.131]:32903 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S293020AbSBVWEC>;
	Fri, 22 Feb 2002 17:04:02 -0500
Date: Sat, 23 Feb 2002 00:05:37 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem? 802.1q kernel 2.4.18-rc1-rmap12f
In-Reply-To: <a55sem$425$2@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.31.0202230003150.2719-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Feb 2002, Miquel van Smoorenburg wrote:

> In article <Pine.LNX.4.31.0202221815590.28962-100000@linux.kappa.ro>,
> Teodor Iacob  <Teodor.Iacob@astral.kappa.ro> wrote:
> >I want to use the eth0 as 2 subinterfaces with 802.1q with vlan IDs 3 and
> >5, so this is how I set the whole thing up:
> >
> >/sbin/ifconfig eth0 up # This to make the link of the interface up
> >vconfig add eth0 5
> >vconfig add eth0 3
> >
> >/sbin/ifconfig eth0.5 inet ..etc..
> >/sbin/ifconfig eth0.3 inet ...etc..
> >
> >and I have also the default gateway through the eth0.5 vlan.
> >
> >Now after a fresh start, I can ping whatever I want, but I cannot start a
> >file transfer, it just locks up after first 1024 bytes ( as seen with tick
> >in simple ftp command ).
>
> Did you patch the ethernet driver so that it supports the bigger
> MTUs needed for VLAN support ? It's all described in the VLAN patch docs.

Is there any drawback to use this patch? :
In const char i82557_config_cmd[22] = {
-       0x68, 0, 0x40, 0xf2, 0xBD,              /* 0xBD->0xFD=Force
full-duplex */
+       0x68, 0, 0x40, 0xfa, 0xBD,              /* 0xBD->0xFD=Force
full-duplex */


I use the other 2 interfaces in normal mode and they are eepro100 too,
only one uses 2 tagged subinterfaces.

Btw, I was able to reconfigure the whole thing and it does work fine now,
but I can't really make a test now with the other two interfaces since I
did all this remotely.


>
> Mike.
> --
> Computers are useless, they only give answers. --Pablo Picasso
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


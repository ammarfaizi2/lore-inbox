Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132773AbRDIPng>; Mon, 9 Apr 2001 11:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRDIPn1>; Mon, 9 Apr 2001 11:43:27 -0400
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:8717 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S132593AbRDIPnL>; Mon, 9 Apr 2001 11:43:11 -0400
Message-ID: <018601c0c10c$50f5d3b0$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1010409102624.12657A-100000@chaos.analogic.com>
Subject: Re: skbuff.h
Date: Mon, 9 Apr 2001 23:46:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot.
Do you know the purpose of csum_partial( ) function?
I can't find out it source code.

I can't believe that I have discovered an area where an
improvement in performance. Maybe I loss some thing.

Cheers,
Tom

> On Mon, 9 Apr 2001, nctucis wrote:
>
> > Hi,
> >
> > I use 2.2.16 kernel.
> > I found that there is a sk_buff structure in
> > "/usr/src/linux/include/linux/skbuff.c", and
> > there is a variable "unsigned in csum;" in
> > the sk_buff structure.
> >
> > I want to know this checksum check what information.
> > Could you give me a hand, please?
> >
> > -=-=-=-=-=-=-=-
> > In fact, I found 64byte and 1518byte UDP packet waste different
> > time to do masquerade(ip_fw_masquerade).
> > Many books say NAT just modify header fields, so it should no
> > different between small and big packet size.
> > I guess the different time due to csum_partial(h.raw, doff, sum)
> > in ip_fw_masquerade(). Right? Thanks a lot.
> > (But I can't find out source code of this function.)
> >
> > Cheers,
> > Tom
>
> TCP/IP packets contain a checksum. The checksum is defined by the
> standards. Linux checksums the IP packets in two ways, the first
> is obvious, the second is the 'csum_partial_copy_generic' in
> ../linux/arch/i386/lib/checksum.S.
>
> NAT, because it modifies the IP packet, must also modify the
> checksum. However, the checksum is in the IP header so your
> 'books' are correct. FYI, since the checksum is known, the
> IP address is known, and the standard is known. It is not
> necessary to re-checksum the entire packet to produce a new
> checksum after modification of some of the checksummed data
> (IP address).
>
> I think Linux recalculates the entire checksum over again so
> you may have discovered an area where an improvement in performance
> could be obtained.
>
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
>
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


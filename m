Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281342AbRKHDNM>; Wed, 7 Nov 2001 22:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281349AbRKHDNC>; Wed, 7 Nov 2001 22:13:02 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:15091 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281342AbRKHDMs>; Wed, 7 Nov 2001 22:12:48 -0500
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, ak@muc.de, andrewm@uow.edu.au,
        "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
        owner-netdev@oss.sgi.com, tim@physik3.uni-rostock.de
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF80A3FFE5.FC1D4628-ON88256AFE.0010957E@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Wed, 7 Nov 2001 19:07:47 -0800
X-MIMETrack: Serialize by Router on D03NM066/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/07/2001 08:11:26 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unsigned arithmetic is fine. The _correct_ way to test whether something
> is in within
>
>          [ start , start+HZ ]
>
> is to do
>
>          if (jiffies - start <= HZ)
>
> try it. The C language guarantees that unsigned arithmetic works in a
> "modulo power of two" fashion, which means that it _is_ ok to do
> arithmetic on unsigned longs, and jiffy wrapping does not matter. No need
> to cast to "signed" or anything else.
>
> In short: It is wrong to do
>
>          if (jiffies <= start+HZ)
>
> and it is _right_ to do
>
>          if (jiffies - start <= HZ)

Actually this last part is wrong, isn't it ? jiffies <= start + HZ is also
a correct way to do it, since start+HZ will overflow to the current value
of
jiffies when HZ time elapses. So the above two statements are IDENTICAL. I
agree with the rest of the statements, and especially that you don't need
to worry about wrapping using unsigned numbers.

Regards,

- KK

> (as long as "start" is "unsigned long" like jiffies).
>
>                    Linus


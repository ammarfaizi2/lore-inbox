Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272598AbRHaEVy>; Fri, 31 Aug 2001 00:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272601AbRHaEVn>; Fri, 31 Aug 2001 00:21:43 -0400
Received: from [209.218.224.101] ([209.218.224.101]:9857 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S272600AbRHaEVg>; Fri, 31 Aug 2001 00:21:36 -0400
Message-ID: <000d01c131d4$a8449820$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: "Doug Ledford" <dledford@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <05c501c13178$43e19ba0$6caaa8c0@kevin> <3B8E7F0D.3000503@redhat.com>
Subject: Re: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
Date: Thu, 30 Aug 2001 21:23:16 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I see that now... and it looks like the risks associated with setting
the unmaskirq flags on my drives (none of the four drives have it set now)
are too great to be worth playing with it. I'll just not use my PPP
connection during these particularly heavy disk activity moments. Thanks for
the quick response.

----- Original Message -----
From: "Doug Ledford" <dledford@redhat.com>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 30, 2001 10:59 AM
Subject: Re: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable


> Kevin P. Fleming wrote:
>
> > I ran into a very strange problem yesterday... my server here, which is
a
> > 700 MHz Celeron, 256MiB RAM, four ~40G disks has two RAID-5 arrays
(using
> > the standard kernel MD driver) configured across those four drives. For
some
> > reason definitely related to operator error, the machine crashed and
needed
> > to resync the arrays after being rebooted.
> >
> > Eveything was working fine, interactive response was just fine even
though
> > the drives were just cranking away doing their resync. I then brought up
my
> > PPP Internet connection, which came up just fine. However, I was _not_
able
> > to actually communicate with any 'Net hosts.
>
>
> [ snip ]
>
>
> > I can probably reproduce this pretty easily, if anyone is interested and
can
> > give me some idea where to look for the cause...
>
>
> Don't bother.  The problem is that your disks are IDE disks and you
> don't have IRQ unmasking enabled on some/all of them.  As long as that's
> the case, heavy disk activity (whether it's a RAID5 resync or a bonnie
> run or untar'ing a kernel archive) will always cause your PPP connection
> to quit working due to dropped serial data and therefore corrupted PPP
> packets.
>
>
> --
>
>   Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>        Please check my web site for aic7xxx updates/answers before
>                        e-mailing me about problems
>
>
>
>


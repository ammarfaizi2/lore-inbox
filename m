Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUHGTY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUHGTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 15:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUHGTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 15:24:56 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5847 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264265AbUHGTYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 15:24:53 -0400
Date: Sat, 07 Aug 2004 13:21:11 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ide-cs using 100% CPU
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <006d01c47cb3$b2e133b0$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.j0leddb.okcbor@ifi.uio.no> <fa.goasld9.1q1kb05@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't that the CPU is doing so much work, it's mostly waiting. However
with this type of PIO access, the CPU must do all the reads/writes from the
buffer and while doing this the CPU is blocked and cannot do anything else.


----- Original Message ----- 
From: "Hamie" <hamish@travellingkiwi.com>
Newsgroups: fa.linux.kernel
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, August 06, 2004 1:46 PM
Subject: Re: ide-cs using 100% CPU


> Russell King wrote:
>
> >On Sun, Jul 18, 2004 at 10:30:16AM +0100, Hamie wrote:
> >
> >
> >>Anyone know why this happens? Something busy waiting? (BUt that should
> >>show as system cpu right?) or something taking out really long locks?
> >>
> >>
> >
> >It'll be because IDE is using PIO to access the CF card, which could
> >have long access times (so reading a block of sectors could take some
> >time _and_ use CPU.)  Obviously, PIO requires the use of the CPU, so
> >the CPU can't be handed off to some other task while this is occuring.
> >
> >
> >
> Well... I did consider that. And not to disbelieve you, since you know
> the kernel way better than I do, But decided I was being silly that a
> 1.6GHz Pentium-M processor should use 100% CPU moving a couple of
> MB/second across a CF interface...
>
> Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing
> the same job as quick, or even slightly faster...
>
> And should it not use system CPU rather than user CPU?
>
> TIA
>  Hamish.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


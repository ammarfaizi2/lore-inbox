Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUHHTlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUHHTlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 15:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266201AbUHHTlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 15:41:23 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62152 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266200AbUHHTlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 15:41:22 -0400
Date: Sun, 08 Aug 2004 13:32:10 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ide-cs using 100% CPU
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <000f01c47d7e$669727f0$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.hhjr2f2.1ql2t80@ifi.uio.no> <fa.ggacpdl.26on0d@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Hamie" <hamish@travellingkiwi.com>


> Robert Hancock wrote:
>
> >It isn't that the CPU is doing so much work, it's mostly waiting. However
> >
> >
>
> That was my point... While waiting, shouldn't the CPU be off doing
> something else? Like giving X some attention...
>
> >with this type of PIO access, the CPU must do all the reads/writes from
the
> >buffer and while doing this the CPU is blocked and cannot do anything
else.
> >
> >
> >
>
> Or is the CF requirements such that it's spending it's time doing the
> actual reads & writes from the buffer, and it's the hardware inserting
> wait-states when it's being accessed?
>

That's basically what's happening, when the CPU does a write or a read of
some data from the buffer, it has to wait for that to go all the way across
the bus and to/from the card, meanwhile no other useful work can be done
while it is waiting. As Alan Cox mentioned, having a hyperthreaded CPU helps
tremendously in such cases, since the other "half" of the CPU can be doing
useful work while the first half is blocked.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUAAOIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 09:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUAAOIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 09:08:19 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:35753 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S261595AbUAAOIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 09:08:18 -0500
Message-ID: <32837.68.105.173.45.1072966107.squirrel@mail.mainstreetsoftworks.com>
Date: Thu, 1 Jan 2004 09:08:27 -0500 (EST)
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: "Brad House" <brad_mssw@gentoo.org>
To: <ak@muc.de>
In-Reply-To: <m34qviyiy4.fsf@averell.firstfloor.org>
References: <18kst-5Av-1@gated-at.bofh.it>
        <m34qviyiy4.fsf@averell.firstfloor.org>
X-Priority: 3
Importance: Normal
Cc: <brad_mssw@gentoo.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the point was it _didn't_ work on AMD64 with 2.6.0 at all.
Which was what I was trying to fix.  Also, it is a megaraid2 series
driver in the 2.6.0 kernel (2.00.3), I've since ported the 2.00.9
2.4 driver to 2.6.0, but have not yet had it tested (I did not
make the 64bit changes I had posted a patch for).
I guess we'll see, I hope bumping to 2.00.9 works.

-Brad

> "Brad House" <brad_mssw@gentoo.org> writes:
>>
>> diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c
>> linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c
>> --- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c	2003-12-29
>> 23:51:43.000000000 -0500
>> +++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c	2003-12-29
>> 23:54:01.005469936 -0500
>> @@ -1292,7 +1292,7 @@
>>
>>  			/* Calculate Scatter-Gather info */
>>  			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
>> -					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
>> +					(dma_addr_t *)&mbox->m_out.xferaddr, (u32 *)&seg);
>
> I'm pretty sure it's completely broken. You're changing the layout of  a
> data structure that is shared with the firmware. Using a 32bit
> int here is fine when the driver sets the correct dma mask or
> only stuffs pci_alloc_consistent() memory in there (i think it's
> the later here)
>
> Even though the driver prints lots of warnings at compile time it
> actually works on AMD64 as is. But in many cases you should
> use megaraid2.c instead of megaraid.c.
>
> -Andi




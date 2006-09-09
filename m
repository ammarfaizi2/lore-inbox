Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWIIRzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWIIRzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 13:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWIIRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 13:55:40 -0400
Received: from mout0.freenet.de ([194.97.50.131]:132 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1751341AbWIIRzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 13:55:39 -0400
Date: Sat, 09 Sep 2006 20:03:28 +0200
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tfkmp60biudtyh@master> <4501BC2B.5040204@cfl.rr.com>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tfmhr2driudtyh@master>
In-Reply-To: <4501BC2B.5040204@cfl.rr.com>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Thomas Maier wrote:
>> Hello
>>
>> (3th try with fixed inline patch)
>>
>> This is a patch for the packet writing driver pktcdvd.
>> It adds a sysfs interface to the driver and a bio write
>> queue "congestion" handling.
>>
>
> Why does pktcdvd need to handle congestion?

> Doesn't it get blocked when
> trying to send down bios to the underlying device if it's queue is
> congested?

Yes, that is right.

But the pktcdvd driver has an internal queue for *incoming* bio write request
(over own make_request function), and this queue size was unlimited!
Since the underlying (DVD writer in my case) can not process as much
write packets as fast as new bio write requests are passed to the driver,
the bio write queue size increases and increases and increases ;)
Esp if you are write huge files. In my case, i wrote about 2G on data
(using rsync for backup purpose) onto DVDRAM, with some huge files
(about 300 MB). The bio write queue size raised over 200000 and more
and at the end, the kernel said: ups, no more memory available, i
let something fail.

-Thomas Maier


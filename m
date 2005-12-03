Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVLCMAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVLCMAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 07:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVLCMAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 07:00:14 -0500
Received: from www4.pochta.ru ([81.211.64.24]:59462 "EHLO www4.pochta.ru")
	by vger.kernel.org with ESMTP id S1751230AbVLCMAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 07:00:12 -0500
Date: Sat, 3 Dec 2005 14:32:24 +0300 (MSK)
From: vitalhome@rbcmail.ru
Message-Id: <200512031132.jB3BWOd5047350@www4.pochta.ru>
To: david-b@pacbell.com
Cc: linux-kernel@vger.kernel.org, dpervushin@ru.mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Free mail service Pochta.ru; WebMail Client; Account: vitalhome@rbcmail.ru
X-Proxy-IP: [195.242.0.161]
X-Originating-IP: [195.201.72.10]
Subject: Re: [PATCH 2.6-git] MTD/SPI dataflash driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

> So consider two different tasks accessing devices on the same SPI bus.
> 
> One is lower priority, currently waiting for an SPI request to complete.
> A request that has your magic "leave me owning chipselect/bus after
> this request flag" ... because the first thing it's going to do when
> it returns is start another transfer.  (And in the case of the MTD driver,
> that transfer could already have been queued, removing the issue as
> well as the need for that flag.)
> 
> Now the high priority task issues a request to the other device on
> that same SPI bus.  This means that *two* other tasks ought to be
> temporarily operating with that higher priority:  whatever task
> you've allocated to manage the I/O queue on that bus (plus maybe
> an IRQ task with RT_PREEMPT); and the task that's waiting for that
> transfer to complete.  Inversions ... 

Can you please tell me if that's not the same for your core? I'm afraid this problem is 
common between the cores :(

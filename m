Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbULaK7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbULaK7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 05:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbULaK7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 05:59:55 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:30438 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261848AbULaK7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 05:59:52 -0500
Message-ID: <41D5313B.1080907@verizon.net>
Date: Fri, 31 Dec 2004 06:00:11 -0500
From: Jim Nelson <james4765@verizon.net>
Reply-To: james4765@gmail.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] esp: Make driver SMP-correct
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20041231014611.003281e5.akpm@osdl.org> <20041231100037.A29868@flint.arm.linux.org.uk>
In-Reply-To: <20041231100037.A29868@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Fri, 31 Dec 2004 04:59:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Dec 31, 2004 at 01:46:11AM -0800, Andrew Morton wrote:
> 
>>James Nelson <james4765@verizon.net> wrote:
>>
>>>This is an attempt to make the esp serial driver SMP-correct.  It also removes
>>> some cruft left over from the serial_write() conversion.
>>
>>>From a quick scan:
>>
>>- startup() does multiple sleeping allocations and request_irq() under
>>  spin_lock_irqsave().  Maybe fixed by this:
> 
> 
> However, can you guarantee that two threads won't enter startup() at
> the same time?  (that's what ASYNC_INITIALIZED is protecting the
> function against, and the corresponding shutdown() as well.)
> 
> It's probably better to port ESP to the serial_core structure where
> this type of thing is already taken care of.
> 

You are right.  Quite a bit of work, if I am looking at it correctly, though.  Any 
pointers/URLs to help a newbie get their head wrapped around the process?

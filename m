Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVAJX23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVAJX23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVAJXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:23:10 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:31707 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262608AbVAJXTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:19:41 -0500
Message-ID: <41E30D4E.1070007@kolivas.org>
Date: Tue, 11 Jan 2005 10:18:38 +1100
From: Con Kolivas <lkml@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Rajsekar <rajsekar@cse.iitm.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: SCHED_BATCH not stopped (swsusp fails)
References: <m3oeg1uk1y.fsf@rajsekar.pc> <20050110223213.GC1343@elf.ucw.cz>
In-Reply-To: <20050110223213.GC1343@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>SCHED_BATCH processes dont seem to heed the `stop' request (order?) by
>>swsusp.  I run httpd and mysqld (for my wiki page) with SCHED_BATCH (so
>>that I can work on my computer even if the load is very high) but when I
>>try to suspend the system, it tries to stop the tasks and simply returns.
>>Here is the dmesg output (paritial)
> 
> 
> Aha, so if it mysqld is not running SCHED_BATCH priority, stopping
> mysqld will work ok?

That makes sense.

Sorry, SCHED_BATCH is unique to my tree at the moment so this is my 
mistake for not considering it. I'll have to transiently schedule 
SCHED_BATCH tasks as SCHED_NORMAL if we are going into swsusp. It's 
something I'll have to work on. In the interim, a workaround would be to 
convert all httpd threads to SCHED_NORMAL before shutting down in your 
scripts somewhere and convert them back after resuming.

Cheers,
Con

P.S. Raj the --cutme-- thing in your email is very annoying for those of 
us who reply to up to 300 emails a day (and yes I do know why you do it, 
but if you keep doing it people will stop replying directly to you).

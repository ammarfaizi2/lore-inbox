Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVJOUXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVJOUXO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVJOUXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:23:14 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:64682 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751219AbVJOUXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:23:13 -0400
Date: Sat, 15 Oct 2005 14:21:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: interruptible_sleep_on, interrupts and device drivers
In-reply-to: <4XQZI-5QC-1@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <435164E3.9000001@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4XQZI-5QC-1@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriele Brugnoni wrote:
> But:
> If the test is made with IRQ closed, and IRQ are then enabled after the test
> but before the call to interruptible_sleep_on, what happen if the handler
> break the procedure immediately before entering the interruptible_sleep_on
> function ?
> I beleave that the interrupt handler, calling the wakeup function, will not
> wake our process, because is not in the waiting list. But at return from
> IRQ handler, the process will continue execution calling the sleep
> function, and nobody will wake it because the data is now already available.

This is why interruptible_sleep_on is deprecated and should not be used 
anymore. The wait_event_interruptible, etc. functions avoid this race 
since the condition is tested after the caller is put into the wait 
queue, so if the condition is true you are guaranteed to be woken up.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWFGASX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWFGASX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWFGASX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:18:23 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47428 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751396AbWFGASW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:18:22 -0400
Date: Tue, 06 Jun 2006 18:16:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
In-reply-to: <6kHVe-3Hs-45@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>
Message-id: <44861AEE.3020109@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6kGwd-1tt-23@gated-at.bofh.it> <6kHVe-3Hs-45@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 06/06/06, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:
>> Hi!
>>
>> Short Version (tm): I try to backport a USB driver (rtl8150.c) from
>> 2.6.15.x to 2.4.32 and have no idea how to substitue two functions:
>> in_atomic() and schedule_timeout_uninterruptible() ... I really would
>> appreciate any help, because I am no kernel hacker at all ...
>>
> in_atomic() is used to test if the kernel is in a state where sleeping
> is allowed or not. The 2.4.x kernel is not preemptive and has quite
> coarse grained SMP support (the BKL "Big Kernel Lock"), it didin't
> need in_atomic() in the same way as 2.6.x does.

There's little difference in the need for it, 2.4 just doesn't have it. 
I don't see a call to that function in that driver's code though?

> 
> schedule_timeout_uninterruptible() is used to sleep on a wait-queue,
> which 2.4.x does not have.

Huh? 2.4 did have wait queues, but that call has nothing to do with 
them. You should be able to replace it with:

set_current_state( TASK_UNINTERRUPTIBLE );
schedule_timeout( timeout );

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


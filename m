Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWFGG4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFGG4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 02:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWFGG4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 02:56:54 -0400
Received: from server1.meinberg.de ([85.10.202.66]:53400 "EHLO
	paolo.meinberg.de") by vger.kernel.org with ESMTP id S1751073AbWFGG4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 02:56:53 -0400
Message-ID: <448678A8.2050501@meinberg.de>
Date: Wed, 07 Jun 2006 08:56:40 +0200
From: Heiko Gerstung <heiko.gerstung@meinberg.de>
Organization: Meinberg Radio Clocks
User-Agent: Thunderbird 1.5.0.2 (X11/20060601)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
References: <6kGwd-1tt-23@gated-at.bofh.it> <6kHVe-3Hs-45@gated-at.bofh.it> <44861AEE.3020109@shaw.ca>
In-Reply-To: <44861AEE.3020109@shaw.ca>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jesper Juhl wrote:
>> On 06/06/06, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:
>>> Hi!
>>>
>>> Short Version (tm): I try to backport a USB driver (rtl8150.c) from
>>> 2.6.15.x to 2.4.32 and have no idea how to substitue two functions:
>>> in_atomic() and schedule_timeout_uninterruptible() ... I really would
>>> appreciate any help, because I am no kernel hacker at all ...
>>>
>> in_atomic() is used to test if the kernel is in a state where sleeping
>> is allowed or not. The 2.4.x kernel is not preemptive and has quite
>> coarse grained SMP support (the BKL "Big Kernel Lock"), it didin't
>> need in_atomic() in the same way as 2.6.x does.
> 
> There's little difference in the need for it, 2.4 just doesn't have it.
> I don't see a call to that function in that driver's code though?
It is in the modified version. In the long version of my post I wrote
that the maintainer of the driver was so kind to modify the 2.6 driver
code for me, because using such an interface in a bonding configuration
always leads to kernel crashes in 2.4 kernels (I tested 2.4.20 and
2.4.32). Backporting the unmodified 2.6 driver did not change that and
it seems that the crashes are caused by the way the bonding code is
accessing the interface (in combination with the buggy driver, of course).

>> schedule_timeout_uninterruptible() is used to sleep on a wait-queue,
>> which 2.4.x does not have.
> 
> Huh? 2.4 did have wait queues, but that call has nothing to do with
> them. You should be able to replace it with:
> 
> set_current_state( TASK_UNINTERRUPTIBLE );
> schedule_timeout( timeout );

Thanks for the tip!

I will take a look into the differences between the 2.4 and 2.6 bonding
code and will come back here with questions (that one is for sure!).

Kind regards,
Heiko



-- 
------------------------------------------------------------------------

*MEINBERG Funkuhren GmbH & Co. KG*
Auf der Landwehr 22
D-31812 Bad Pyrmont, Germany
Tel.: ++49 (0)5281 9309-25
Fax: ++49 (0)5281 9309-30
eMail: heiko.gerstung@meinberg.de <mailto:heiko.gerstung@meinberg.de>
Internet: www.meinberg.de <http://www.meinberg.de/>

------------------------------------------------------------------------

Meinberg radio clocks: 25 years of accurate time worldwide


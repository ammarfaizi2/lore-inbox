Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVJASYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJASYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVJASYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:24:30 -0400
Received: from orb.pobox.com ([207.8.226.5]:18152 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S1750763AbVJASY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:24:29 -0400
Message-ID: <433ED44C.3060805@rtr.ca>
Date: Sat, 01 Oct 2005 14:24:12 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de,
       torvalds@osdl.org, randy_dunlap <rdunlap@xenotime.net>
Subject: Re: SATA suspend/resume (was Re: [PATCH] updated version of Jens'
 SATA suspend-to-ram patch)
References: <20050923163334.GA13567@triplehelix.org> <433B79D8.9080305@pobox.com>
In-Reply-To: <433B79D8.9080305@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
..
> Ah hah!  I found the other SCSI suspend patch:
>     http://lwn.net/Articles/97453/
> Anybody (Joshua?) up for reconciling and testing the two?

I just now tried out *only* "the other SCSI suspend patch",
and by itself it hangs on resume.  Laptop computer, blank screen,
no serial ports, no printk()s visible.

And there's one minor bug in that patch:  it uses GFP_KERNEL to
alloc a buffer, but on resume it really should use GFP_ATOMIC instead,
since the swap device is the same drive we're trying to resume..

> 2) sd should call START STOP UNIT on resume

That's probably why it hangs when used as-is by itself.
I may do some further testing.

Anyone else out there playing with this yet?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVAMUXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVAMUXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVAMTix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:38:53 -0500
Received: from one.firstfloor.org ([213.235.205.2]:56771 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261430AbVAMTgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:36:40 -0500
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, ecashin@coraid.com,
       jgarzik@pobox.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
References: <20050113000949.A7449@flint.arm.linux.org.uk>
	<20050113085035.GC2815@suse.de>
From: Andi Kleen <ak@muc.de>
Date: Thu, 13 Jan 2005 20:36:38 +0100
In-Reply-To: <20050113085035.GC2815@suse.de> (Jens Axboe's message of "Thu,
 13 Jan 2005 09:50:35 +0100")
Message-ID: <m1wtuh2kah.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Thu, Jan 13 2005, Russell King wrote:
>> In addition, please shoot the author in the other foot for:
>> 
>> config ATA_OVER_ETH
>>         tristate "ATA over Ethernet support"
>>         depends on NET
>>         default m               <==== this line.
>> 
>> That's not nice for embedded guys who do a "make xxx_defconfig" and
>> unsuspectingly end up with ATA over Ethernet built in for their
>> platform.
>
> That annoyed me, too. There's no reason for standard kernel driver
> modules to assume they should be selected, especially true for something
> as special case as ata over ethernet.

In general I think it was a bad idea to merge this driver at all.
The protocol is obviously broken by design - they use a 16 bit sequence
number space which has been proven for many years (in ip fragmentation)
to be far too small for modern network performance.

Also the memory allocation without preallocation in the block write
out path looks quite broken too and will most likely will lead to deadlocks
under high load.

(I wrote a detailed review when it was posted but apparently it 
disappeared or I never got any answer at least) 

IMHO this thing should have never been merged in this form. Can it 
still be backed out?

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUFQTQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUFQTQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFQTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:16:01 -0400
Received: from meetpoint.leesburg-geeks.org ([66.63.28.250]:65289 "EHLO
	meetpoint.home") by vger.kernel.org with ESMTP id S261865AbUFQTPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:15:16 -0400
Message-ID: <40D1EDB7.3030401@leesburg-geeks.org>
Date: Thu, 17 Jun 2004 15:15:03 -0400
From: Ken Ryan <linuxryan@leesburg-geeks.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org,
       pla@morecom.no
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40D1B110.7020409@leesburg-geeks.org> <40D1C18B.1030907@techsource.com> <40D1D2F0.7080102@namesys.com>
In-Reply-To: <40D1D2F0.7080102@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Timothy Miller wrote:
>
>> Doesn't Reiser4 do wear-leveling for flash?
>
>
> No, we don't.  We do have wandering logs, so it would be feasible to 
> code, but bitmap blocks and super blocks get written to the same 
> locations repeatedly.
>
> Actually, most compact flash devices DO do wear leveling, from what I 
> have heard.


The ones I've seen, only sort of.  They'll allocate writes from 
available erased pages to try to distribute their use, but if you
have a disk that's, say, 70% read-only data and 30% read-write then the 
wear-levelling will only happen on that
30% of the disk.  True wear levelling will actually scrub read-only or 
rarely-written data, forcing it to get off its
duff so the flash cells they're sitting on can get some exercise, and 
give the more worn cells a rest (that scrub
helps ECC fix soft errors from weak cells too).  True wear-levelling is 
really hard, and obviously requires
budgeting extra bandwidth and storage devices for safely shuffling 
around data that the application has no
intention of moving (picture losing power in the middle of a scrub).  
It's not worth it for the consumer CF
usage model of "take photos until the card is full, then copy them all 
to the PC and wipe the card clean".

[Yes, I tend to see this from the inside-out: I'm actually an FPGA/ASIC 
weenie not a kernel hacker.  One of my current
projects is part of a controller chip for a solid-state storage system 
with ${bignum} NAND flash chips.  Alas, my specialty
is video and graphics, so I'm still coming up the learning curve on 
storage systems].

               ken




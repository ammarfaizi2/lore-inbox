Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWELKLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWELKLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWELKLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:11:50 -0400
Received: from vvv.conterra.de ([212.124.44.162]:61317 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1751113AbWELKLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:11:50 -0400
Message-ID: <44645F5A.7000209@conterra.de>
Date: Fri, 12 May 2006 12:11:38 +0200
From: =?UTF-8?B?RGlldGVyIFN0w7xrZW4=?= <stueken@conterra.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, hzhong@gmail.com
Subject: Re: ext3 metadata performace
References: <4463461C.3070201@conterra.de> <44642CBD.4000305@aitel.hist.no>
In-Reply-To: <44642CBD.4000305@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Dieter Stüken wrote:
>> Would it be make sense for ext3, to disable synchronous writes even
>> for metadata (similar to the "data=writeback" option)?
> 
> Turning off synchronous writes like this won't work!
> The battery-backed cache can help you in that you can consider
> data "written" once it is transferred to that cache.  Metadata must still
> go synchronously into the cache though, or you get a broken fs
> if ever your machine crash in the middle of a transaction. (Leaving
> an update halfway in that battery cache, and halfway in main memory.
> Then main memory dies from the power cut / reboot.)
> 
> The caching controller should report back to the linux device driver
> that "data is committed" as soon as it hits the cache - no need to
> wait for it to actually hit the platters.  This can help performance with
> bursty writes tremendously - but it won't help you with long-lasting writes
> as you will then be limited by platter speed as soon as the battery cache
> is completely full.

The battery buffered cache is about 100Mb compared to 8k or 16k of the
disk buffer cache itself. So it won't become full that fast...

I just tested the same with my other controller (a 3ware 9550SX) which
has an option to configure explicitly if a write is acknowledged as
soon as the data is saved to the (buffered) memory or if it will delay
the acknowledge until data got written to disk. So this is similar to
enabling/disabling the disk cache on a plain disk. I did not found a
way to configure this on my older 3ware 9500S controller, even if it
has a battery backup, too (will ask 3ware about this).

Hua Zhong wrote:
>> If you mean the disk cache is reliable with the battery, then it 
 >> should be done by the block layer that a write barrier doesn't
>> translate into a SYNC (or whatever it is called). Instead, data is 
 >> considered synced to disk as soon as it hits the cache.
>> 
>> It's really nothing to do with EXT3. It's doing the right thing.

I read something about "write barriers", but I don't know if these are
already used by my current 2.6.15 (I may try to use the actual kernel
tomorrow). Is there a difference between a SATA disk and a SCSI disk?
(which is emulated by my 3Ware controllers).

Dieter.

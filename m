Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752807AbWKBX3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbWKBX3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbWKBX3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:29:37 -0500
Received: from alpha.polcom.net ([83.143.162.52]:30129 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1752807AbWKBX3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:29:36 -0500
Date: Fri, 3 Nov 2006 00:29:27 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.63.0611030022110.14187@alpha.polcom.net>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Mikulas Patocka wrote:
>>  On Thu, 2 Nov 2006, Mikulas Patocka wrote:
>> >  As my PhD thesis, I am designing and writing a filesystem, and it's now 
>> >  in a state that it can be released. You can download it from 
>> >  http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>>
>>  "Disk that can atomically write one sector (512 bytes) so that the sector
>>  contains either old or new content in case of crash."
>>
>>  Well, maybe I am completly wrong but as far as I understand no disk
>>  currently will provide such requirement. Disks can have (after halted
>>  write):
>>  - old data,
>>  - new data,
>>  - nothing (unreadable sector - result of not full write and disk internal
>>  checksum failute for that sector, happens especially often if you have
>>  frequent power outages).
>>
>>  And possibly some broken drives may also return you something that they
>>  think is good data but really is not (shouldn't happen since both disks
>>  and cables should be protected by checksums, but hey... you can never be
>>  absolutely sure especially on very big storages).
>>
>>  So... isn't this making your filesystem a little flawed in design?
>
> There was discussion about it here some times ago, and I think the result was 
> that the IDE bus is reset prior to capacitors discharge and total loss of 
> power and disk has enough time to finish a sector --- but if you have crap 
> power supply (doesn't signal power loss), crap motherboard (doesn't reset 
> bus) or crap disk (doesn't respond to reset), it can fail.

Hmm, maybe. But I think I saw couple of such bad sectors that were only 
bad because of power loss in the wild.


> BTW. reiserfs and xfs depend on this feature too. ext3 is the only one that 
> doesn't.

Well, at least for XFS everybody tell that it should be used with UPS only 
if you really care about your data. I think it has something to do with 
heavy in-RAM caching this filesystem does.

Anyway, it looks strange to list something very fragile and potentially 
not existing in the requirements... :-)

Could you explain where exactly do you depend on this requirement? And 
what could happen if it is not true?


Thanks,

Grzegorz Kulewski


PS. Do you have any benchmarks of your filesystem? Did you do any longer 
automated tests to prove it is not going to loose data to easily?


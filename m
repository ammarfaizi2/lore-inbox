Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWHYKY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWHYKY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWHYKY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:24:26 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:58571 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751425AbWHYKYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:24:25 -0400
Message-ID: <44EECF16.6060602@aitel.hist.no>
Date: Fri, 25 Aug 2006 12:21:10 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Aleksey Gorelov <dared1st@yahoo.com>
CC: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vget.kernel.org, satinder.jeet@gmail.com
Subject: Re: Generic Disk Driver in Linux
References: <20060824181935.90856.qmail@web83102.mail.mud.yahoo.com>
In-Reply-To: <20060824181935.90856.qmail@web83102.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
>> From: linux-kernel-owner@vger.kernel.org 
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
>>     
>>> I was curious that can we develop a generic disk driver that could
>>> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
>>>       
>> ide_generic
>> sd_mod
>>
>> All there, what more do you want?
>>     
>
> Unfortunately, not _all_. DMRAID does not support all fake raids yet. Moreover, there is usually
> some gap for bleeding edge hw support.
>   
Nobody will want to use bleeding edge hardware with an int13 driver,
because the performance will necessarily be much worse than using more
moderate hardware with the generic IDE driver.

Int13 for new hardware makes no sense to me.  The same goes for
fake raids - linux will usually be able to see the disks as single
disks, and you can then use them as such with a plain
software raid on top.  The fakeraid functionality is not needed,
it has no performance edge precicely because it is fake.

If fakeraid support is necessary to read some existing filesystem,
then implement support in md or dmraid or even as a userspace
filesystem.  Either choice will perform better, and also be
easier to do than making a working and stable int13 driver.


Helge Hafting

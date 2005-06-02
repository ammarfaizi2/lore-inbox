Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFBMA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFBMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFBMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 08:00:59 -0400
Received: from mail.tmr.com ([64.65.253.246]:33415 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261380AbVFBMAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 08:00:44 -0400
Message-ID: <429EF4E2.2050907@tmr.com>
Date: Thu, 02 Jun 2005 08:00:34 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com> <429EC91A.7020704@aitel.hist.no>
In-Reply-To: <429EC91A.7020704@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> Bill Davidsen wrote:
>
>> Matthias Andree wrote:
>>
>>> On Sun, 29 May 2005, Greg Stark wrote:
>>>
>>>
>>>> Oracle, Sybase, Postgres, other databases have hard requirements. They
>>>> guarantee that when they acknowledge a transaction commit the data 
>>>> has been
>>>> written to non-volatile media and will be recoverable even in the 
>>>> face of a
>>>> routine power loss.
>>>>
>>>> They meet this requirement just fine on SCSI drives (where write 
>>>> caching
>>>> generally ships disabled) and on any OS where fsync issues a cache 
>>>> flush. If
>>>
>>>
>>>
>>>
>>> I don't know what facts "generally ships disabled" is based on, all of
>>> the more recent SCSI drives (non SCA type though) I acquired came with
>>> write cache enabled and some also with queue algorithm modifier set 
>>> to 1.
>>>
>>>
>>>> Worse, if the disk flushes the data to disk out of order it's quite
>>>> likely the entire database will be corrupted on any simple power
>>>> outage. I'm not clear whether that's the case for any common drives.
>>>
>>>
>>>
>>>
>>> It's a matter of enforcing write order. In how far such ordering
>>> constraints are propagated by file systems, VFS layer, down to the
>>> hardware, is the grand question.
>>>
>> The problem is that in many options required to make that happen in 
>> the o/s, hardware, and application are going to kill performance. And 
>> even if you can control order of write, unless you can get write to 
>> final non-volatile media control you can get a sane database but 
>> still lose transactions.
>>
>> If there was a way for the o/s to know when a physical write was done 
>> other than using flushes to force completion, then overall 
>> performance could be higher, but individual transaction might have 
>> greater latency. And the app could use fsync to force order of write 
>> as needed. In many cases groups of writes can be done in any order as 
>> long as they are all done before the next logical step takes place. 
>
>
> There is a workaround.  Get an UPS just for the disks.  It don't have 
> to be
> big, just enough to keep the disks going long enough to commit their
> caches after the rest of the machine died from a power loss.  Such a 
> small
> unit could possibly fit inside the cabinet, avoiding the trouble with
> people stepping on the power cord.
>
> With this in place, any write that makes it from the controller to the
> disk is safely stored for all practical purposes.


Unfortunately even drives in a dual power tray with redundany power from 
separate UPS sources will occasionally have a power failure. Proved that 
last month, the power strip in the rack failed, dumped all the load on 
the other leg, the surge tripped a breaker. Had an APC UPS in my office 
fail in a mode which dropped power, waited for the battery to trickle 
charge to charge the battery a bit, then repeat. Looks to be losing half 
of a full wave rectifier.

The point is that power failures WILL HAPPEN, even with good backups. 
The goal should be to prevent excessive and avoidable data damage when 
it does.

Shameless plug: for office use I changed from APC to Belkin on all new 
units, they have had Linux drivers for some time now, and I like to 
support those who support Linux.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


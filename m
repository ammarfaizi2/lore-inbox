Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVFBI6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVFBI6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFBI5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:57:36 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:7684 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261284AbVFBIsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:48:08 -0400
Message-ID: <429EC91A.7020704@aitel.hist.no>
Date: Thu, 02 Jun 2005 10:53:46 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com>
In-Reply-To: <429E062B.60909@tmr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Matthias Andree wrote:
>
>> On Sun, 29 May 2005, Greg Stark wrote:
>>
>>
>>> Oracle, Sybase, Postgres, other databases have hard requirements. They
>>> guarantee that when they acknowledge a transaction commit the data 
>>> has been
>>> written to non-volatile media and will be recoverable even in the 
>>> face of a
>>> routine power loss.
>>>
>>> They meet this requirement just fine on SCSI drives (where write 
>>> caching
>>> generally ships disabled) and on any OS where fsync issues a cache 
>>> flush. If
>>
>>
>>
>> I don't know what facts "generally ships disabled" is based on, all of
>> the more recent SCSI drives (non SCA type though) I acquired came with
>> write cache enabled and some also with queue algorithm modifier set 
>> to 1.
>>
>>
>>> Worse, if the disk flushes the data to disk out of order it's quite
>>> likely the entire database will be corrupted on any simple power
>>> outage. I'm not clear whether that's the case for any common drives.
>>
>>
>>
>> It's a matter of enforcing write order. In how far such ordering
>> constraints are propagated by file systems, VFS layer, down to the
>> hardware, is the grand question.
>>
> The problem is that in many options required to make that happen in 
> the o/s, hardware, and application are going to kill performance. And 
> even if you can control order of write, unless you can get write to 
> final non-volatile media control you can get a sane database but still 
> lose transactions.
>
> If there was a way for the o/s to know when a physical write was done 
> other than using flushes to force completion, then overall performance 
> could be higher, but individual transaction might have greater 
> latency. And the app could use fsync to force order of write as 
> needed. In many cases groups of writes can be done in any order as 
> long as they are all done before the next logical step takes place. 

There is a workaround.  Get an UPS just for the disks.  It don't have to be
big, just enough to keep the disks going long enough to commit their
caches after the rest of the machine died from a power loss.  Such a small
unit could possibly fit inside the cabinet, avoiding the trouble with
people stepping on the power cord.

With this in place, any write that makes it from the controller to the
disk is safely stored for all practical purposes.

Helge Hafting

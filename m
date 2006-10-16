Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWJPQuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWJPQuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWJPQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:50:23 -0400
Received: from alpha.polcom.net ([83.143.162.52]:33481 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S932102AbWJPQuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:50:22 -0400
Date: Mon, 16 Oct 2006 18:50:16 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, dm-crypt@saout.de,
       mingo@elte.hu, akpm@osdl.org
Subject: Re: Strange SIGSEGV problem around dmcrypt, evms and jfs
In-Reply-To: <1161016116.6997.24.camel@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.63.0610161840580.14187@alpha.polcom.net>
References: <Pine.LNX.4.63.0610161737250.14187@alpha.polcom.net>
 <1161016116.6997.24.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Dave Kleikamp wrote:
> On Mon, 2006-10-16 at 18:12 +0200, Grzegorz Kulewski wrote:
>> I was begining to play with dmcrypt, evms and jfs on one spare disk I
>> have (currently empty and only for tests). I produced some partitions with
>> evms and made volumes on them. Nothing strange, normal configuration. The
>> partition layout seems ok. Then I used dmcrypt mappings on top of two of
>> them to make encrypted swaps and swapon'ed them. Still everything was ok.
>> Then I tested different ciphers performance by doing dmcrypt mappings on
>> top of some other volume with different settings and dd'ed data from and
>> to them to test the speed. Then I choosen one cipher setup and and did the
>> final mapping and created and mounted  jfs on it. Then I copied one large
>> (like 4GB) file on it several times to make sure everything is ok. I
>> checked sha1sums and everything was indeed ok.
>>
>> But then all big applications (firefox, oo2, acroread, ..., opera was the
>> notable exception) couldn't start being killed by SIGSEGVs out of nowhere.
>> I reproduced it two time already (after a clean reboot): today and
>> yesterday. Maybe someone knows what is happening? For me it looks like
>> something broken some kernel memory and the kernel started doing stupid
>> things. But nothing strange has shown in logs.
>>
>> One time I couldn't even shut down the machine normally, only SysRQ-B
>> worked (shutdown scripts were probably killed too or something). Every
>> application works ok (and did so for at least a year) before I will start
>> playing with dmcrypt and jfs. I am not sure where exactly the problems
>> start but will be investigating it shortly.
>>
>> I am rather sure that my hardware is ok. Everything was and is fine till I
>> will start doing these tests.
>
> What were you running before?  jfs?  evms?  Is dm-crypt the only new
> element?  Trying a different file system on the same partition should
> give you an idea whether jfs is a factor or not.

On my main disk I am using ext3. Both dm-crypt and evms were not used. But 
evms was on and was detecting partitions and created it's mappings on 
booting. Also I played with dm-crypt some longer time ago but it was 
unused recently here.

On my testing disk I didn't use anything since it was in store not so long 
ago. But I tested jfs on it (without anything like dm* under) and it was 
working well.


>> BTW. Why booting my machine with 2.6.18.1 with nearly all debuging on I
>> got the following. While I am nearly sure it is not the problem I am
>> writing about I will report it:
>>
>> Oct 16 17:29:33 kangur [   74.485627] =============================================
>> Oct 16 17:29:33 kangur [   74.485767] [ INFO: possible recursive locking detected ]
>> Oct 16 17:29:33 kangur [   74.485840] ---------------------------------------------
>
> This is caused by CONFIG_DEBUG_LOCKDEP.  This will show false positives
> against code that hasn't been annotated for lockdep.  I know the jfs
> code hasn't been annotated yet, and from the look of this, neither has
> the device-mapper code.  You should disable that option, since I doubt
> it would be very helpful in tracking down a segfault, even if the code
> was properly annotated.  The lockdep code is primarily for detecting
> possible opportunities for a deadlock.

Ok, I knew that it was caused by lockdep and what lockdep does, but I 
reported it since it was touching dm, just to be sure.


Thanks,

Grzegorz Kulewski


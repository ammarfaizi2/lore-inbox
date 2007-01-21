Return-Path: <linux-kernel-owner+w=401wt.eu-S1751171AbXAUEGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXAUEGN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 23:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXAUEGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 23:06:13 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:20638 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbXAUEGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 23:06:12 -0500
Date: Sat, 20 Jan 2007 23:06:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Abysmal disk performance, how to debug?
In-reply-to: <45B2E0DD.9020807@seclark.us>
To: linux-kernel@vger.kernel.org, Stephen.Clark@seclark.us
Cc: Willy Tarreau <w@1wt.eu>, Sunil Naidu <akula2.shark@gmail.com>,
       Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Message-id: <200701202306.09087.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200701201920.54620.ismail@pardus.org.tr>
 <20070120200916.GB25307@1wt.eu> <45B2E0DD.9020807@seclark.us>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2007 22:41, Stephen Clark wrote:
>Willy Tarreau wrote:
>>On Sat, Jan 20, 2007 at 02:56:20PM -0500, Stephen Clark wrote:
>>>Sunil Naidu wrote:
>>>>On 1/20/07, Willy Tarreau <w@1wt.eu> wrote:
>>>>>It is not expected to increase write performance, but it should help
>>>>>you do something else during that time, or also give more
>>>>> responsiveness to Ctrl-C. It is possible that you have fast and
>>>>> slow RAM, or that your video card uses shared memory which slows
>>>>> down some parts of memory which are not used anymore with those
>>>>> parameters.
>>>>
>>>>I did test some SATA drives, am getting these value for 2.6.20-rc5:-
>>>>
>>>>[sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
>>>>1024+0 records in
>>>>1024+0 records out
>>>>1073741824 bytes (1.1 GB) copied, 21.0962 seconds, 50.9 MB/s
>>>>
>>>>What can you suggest here w.r.t my RAM & disk?
>>>>
>>>>>Willy
>>>>
>>>>Thanks,
>>>>
>>>>~Akula2
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe
>>>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>Hi,
>>>whitebook vbi s96f core 2 duo t5600 2gb hitachi ATA     
>>> HTS721060G9AT00 using libata
>>>time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
>>>1024+0 records in
>>>1024+0 records out
>>>1073741824 bytes (1.1 GB) copied, 10.0092 seconds, 107 MB/s
>>>
>>>real    0m10.196s
>>>user    0m0.004s
>>>sys     0m3.440s
>>
>>You have too much RAM, it's possible that writes did not complete
>> before the end of your measurement. Try this instead :
>>
>>$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
>>
>>Willy
>
>Yeah that make a difference:
> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
>1024+0 records in
>1024+0 records out
>1073741824 bytes (1.1 GB) copied, 8.86719 seconds, 121 MB/s
>
>real    0m43.601s
>user    0m0.004s
>sys     0m3.912s

I'd reconsider my new years resolutions for figures like that:

#> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 24.1455 seconds, 44.5 MB/s

real    0m25.218s
user    0m0.009s
sys     0m5.763s

but then I also have only a gig of ram.  So does this look normal?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.

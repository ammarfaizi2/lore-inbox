Return-Path: <linux-kernel-owner+w=401wt.eu-S1751170AbXAUDlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXAUDlT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 22:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbXAUDlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 22:41:18 -0500
Received: from smtpout10-04.prod.mesa1.secureserver.net ([64.202.165.238]:53582
	"HELO smtpout10-04.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751170AbXAUDlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 22:41:18 -0500
Message-ID: <45B2E0DD.9020807@seclark.us>
Date: Sat, 20 Jan 2007 22:41:17 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Sunil Naidu <akula2.shark@gmail.com>,
       =?ISO-8859-1?Q?Ismail_D=F6nme?= =?ISO-8859-1?Q?z?= 
	<ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu> <200701201952.54714.ismail@pardus.org.tr> <20070120180344.GA23841@1wt.eu> <8355959a0701201144x290362d8ja6cd5bc1408475da@mail.gmail.com> <45B273E4.8040302@seclark.us> <20070120200916.GB25307@1wt.eu>
In-Reply-To: <20070120200916.GB25307@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

>On Sat, Jan 20, 2007 at 02:56:20PM -0500, Stephen Clark wrote:
>  
>
>>Sunil Naidu wrote:
>>
>>    
>>
>>>On 1/20/07, Willy Tarreau <w@1wt.eu> wrote:
>>>
>>>
>>>      
>>>
>>>>It is not expected to increase write performance, but it should help
>>>>you do something else during that time, or also give more responsiveness
>>>>to Ctrl-C. It is possible that you have fast and slow RAM, or that your
>>>>video card uses shared memory which slows down some parts of memory
>>>>which are not used anymore with those parameters.
>>>>  
>>>>
>>>>        
>>>>
>>>I did test some SATA drives, am getting these value for 2.6.20-rc5:-
>>>
>>>[sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
>>>1024+0 records in
>>>1024+0 records out
>>>1073741824 bytes (1.1 GB) copied, 21.0962 seconds, 50.9 MB/s
>>>
>>>What can you suggest here w.r.t my RAM & disk?
>>>
>>>
>>>
>>>      
>>>
>>>>Willy
>>>>  
>>>>
>>>>        
>>>>
>>>Thanks,
>>>
>>>~Akula2
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>>
>>>      
>>>
>>Hi,
>>whitebook vbi s96f core 2 duo t5600 2gb hitachi ATA      HTS721060G9AT00 
>>using libata
>>time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
>>1024+0 records in
>>1024+0 records out
>>1073741824 bytes (1.1 GB) copied, 10.0092 seconds, 107 MB/s
>>
>>real    0m10.196s
>>user    0m0.004s
>>sys     0m3.440s
>>    
>>
>
>You have too much RAM, it's possible that writes did not complete before
>the end of your measurement. Try this instead :
>
>$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
>
>Willy
>
>
>  
>
Yeah that make a difference:
 time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 8.86719 seconds, 121 MB/s

real    0m43.601s
user    0m0.004s
sys     0m3.912s


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)




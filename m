Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUDCMtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 07:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUDCMtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 07:49:46 -0500
Received: from mail.tmr.com ([216.238.38.203]:33034 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261735AbUDCMto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 07:49:44 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.4 : 100% CPU use on EIDE disk operarion, VIA chipset
Date: Sat, 03 Apr 2004 07:51:44 -0500
Organization: TMR Associates, Inc
Message-ID: <c4mbp9$pm8$1@gatekeeper.tmr.com>
References: <fa.ld6rcgc.1lhmd9q@ifi.uio.no> <406E9EE5.7030509@A88a2.a.pppool.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1080996457 26312 192.168.12.10 (3 Apr 2004 12:47:37 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <406E9EE5.7030509@A88a2.a.pppool.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann wrote:
> Mikhail Ramendik wrote:
> 
>> Hello,
>>
>> I have an computer with an AMD Duron, and the motehrboard chipset is VIA
>> KT133. The hard drive is a Seagate Barracuda 7200.7 ; no other EIDE
>> devices are attached.
>>
>> I run an RH9-based distro, and added a 2.6.4 kernel to it. The following
>> problem was tested with two kernel variants: 2.6.4+wolk2/0 with
>> preeemption enabled, and 2.6.4 plain from kernel.org with preemption
>> disabled. No difference.
>>
>> I noticed performance problems with 2.6.4, and tracked them to strange
>> HDD behavior.
>>
>> It turned out that on disk-intensive operation, the "system" CPU usage
>> skyrockets. With a mere "cp" of a large file to the same direstory
>> (tested with ext3fs and FAT32 file systems), it is 100% practically all
>> of the time !
> 
> 
> Which tool do you use for measure? xosview?
> 
> I'm having here the same problem. But it depends on the tool which is 
> used for measuring. If I use top from procps 3.2, I can't see this high 
> system load. "time" can't see it, too.
> 
> This is what top says during cp of 512MB-file:
> Cpu(s):  2.0% us,  8.3% sy,  0.0% ni,  0.0% id, 89.0% wa,  0.7% hi,  
> 0.0% si
> 
> New is "wa", what probably means "wait". This value is very high as long 
> as the HD is writing or reading datas:
> 
> cp dummy /dev/null
> produces this top-line:
> Cpu(s):  3.0% us,  5.3% sy,  0.0% ni,  0.0% id, 91.0% wa,  0.7% hi,  
> 0.0% si

Yes "wa" is not intuitive, some other operating systems use "wio" for 
"wait i/o" time. As noted in the other thread, you can try the deadline 
elevator or increased readahead for your load.
> 
> and time says:
> real    0m53.195s
> user    0m0.013s
> sys     0m2.124s
> 
> 
> But you're right, 2.6.4 is slower than 2.4.25. See the thread "Very poor 
> performance with 2.6.4" here in the list.

Much discussed, not overly fixed :-(

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

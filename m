Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUIKJLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUIKJLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 05:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUIKJLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 05:11:49 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:10442 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S267961AbUIKJLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 05:11:05 -0400
Date: Sat, 11 Sep 2004 13:15:20 +0400
From: Kirill Korotaev <dev@sw.ru>
Reply-To: Kirill Korotaev <dev@swsoft.mipt.ru>
Organization: SW Soft
X-Priority: 3 (Normal)
Message-ID: <784312683.20040911131520@swsoft.mipt.ru>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       torvalds@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re[2]: [PATCH] adding per sb inode list to make invalidate_inodes() faster
In-Reply-To: <200409102314.24906.vda@port.imtp.ilyichevsk.odessa.ua>
References: <4140791F.8050207@sw.ru> <20040909120818.7f127d14.akpm@osdl.org>
 <41416BCA.3020005@sw.ru> <200409102314.24906.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Denis,

Saturday, September 11, 2004, 12:14:24 AM, you wrote:

>> >> The only motive I'm aware of is for latency in the presence of things
>> >> such as autofs. It's also worth noting that in the presence of things
>> >> such as removable media umount is also much more common. I personally
>> >> find this sufficiently compelling. Kirill may have additional
>> >> ammunition.
>> >
>> > Well.  That's why I'm keeping the patch alive-but-unmerged.  Waiting to
>> > see who wants it.
>> >
>> > There are people who have large machines which are automounting hundreds
>> > of different NFS servers.  I'd certainly expect such a machine to
>> > experience ongoing umount glitches.  But no reports have yet been sighted
>> > by this little black duck.
>>
>> I think It's not always evident where the problem is. For many people
>> waiting 2 seconds is ok and they pay no much attention to this small
>> little hangs.
>>
>> 1. I saw the bug in bugzilla from NFS people you pointed to me last time
>> yourself where the same problem was detected.

DV> What bug? Are you talking about umount being not so fast or something else?
yup. umount requires traversing of ALL inodes in the system (even
inodes from other super blocks). So umount and quota off can last very
very LONG time.

Have you faced this bug before?

-- 
Best regards,
 Kirill                            mailto:dev@sw.ru


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTAYF6G>; Sat, 25 Jan 2003 00:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTAYF6F>; Sat, 25 Jan 2003 00:58:05 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:14244 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S264885AbTAYF6E> convert rfc822-to-8bit; Sat, 25 Jan 2003 00:58:04 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: linux-kernel@vger.kernel.org
Subject: NFS/UDP/IP performance - 2.4.19 v/s 2.4.20, 2.4.20-pre3
Date: Sat, 25 Jan 2003 01:05:27 -0500
User-Agent: KMail/1.4.3
Cc: ADharankar@ATTBI.Com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301250105.27293.ADharankar@ATTBI.Com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

There seem to be a remarkable performance difference
between 2.4.19 and 2.4.20/2.4.21-pre3 in regards to
NFS writes/reads. I am not sure, but the problem may not
in NFS but somewhere lower (UDP/IP or core).



For example, in my kernel and network configuration a 
write to a new file over NFS on 2.4.19 for 5MB takes 2.5
seconds or so. With everything same (including kernel
configuration) 2.4.20 and 2.4.21-pre3 the same takes
11 or more seconds.

Also, when this file write is in progress, the system
time goes up to 15% on 2.4.19, whereas on 2.4.20/21-pre3,
it is about 4%. (I use sar/sysstat for this).


Memory accesses dont seem to be the issue either. Test
program to check this show same times and are ok (as I
expect on the board I use).


"netstat -s" or ifconfig or tcpdump traces dont seem to
point to dropped messages, collisions, retransmissions
etc.


The hardware configuration is PowerPC based, and there
are no changes in the board specific IO subsystem between 
2.4.19 and 2.4.20/21-pre3. The same compiler is used for 
building both the kernels, and have tried this even with 
GCC 3.2, with same results. 

So, I dont suspect this is either board or compiler
related issue.


Also, I see some differences in handling of the bottom
halves in net/core/dev.c between 2.4.19 and 2.4.20/21-pre3.
Although, I have not gone through these in details to
assert that this is indeed the problem area.



Questions:

  - Has anyone seen this? Perhaps on other platforms (x86 etc)?
    Is there some tunable that has been added (or is different)
    after 2.4.19, and which needs to be tuned?


  - I have tried to enable kernel profiling to find any
    potential problem code areas. But given the low cpu
    utilization during these copies, I am not sure if this
    can give any useful info.

    Could anyone offer any ideas to debug this?



I would appreciate if you copy me on any responses to this post, I
dont subscribe to this list.

Best regards,
-Arun.
ADharankar@ATTBI.Com



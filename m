Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTAIJ30>; Thu, 9 Jan 2003 04:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTAIJ30>; Thu, 9 Jan 2003 04:29:26 -0500
Received: from f12.law7.hotmail.com ([216.33.237.12]:52237 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262258AbTAIJ3Y>;
	Thu, 9 Jan 2003 04:29:24 -0500
X-Originating-IP: [212.143.73.102]
From: "yuval yeret" <yuval_yeret@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: yuval@exanet.com
Subject: 2.4.18-14 kernel stuck during ext3 umount with ping still responding
Date: Thu, 09 Jan 2003 11:38:02 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F12N44yQegpeDBHkKx400013b3e@hotmail.com>
X-OriginalArrivalTime: 09 Jan 2003 09:38:02.0413 (UTC) FILETIME=[CDCD7DD0:01C2B7C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running a 2.4.18-14 kernel with a heavy IO profile using ext3 over RAID 
0+1 volumes.

>From time to time I get a black screen stuck machine while trying to umount 
a volume during an IO workload (as part of a failback solution - but after 
killing all IO processes ), with ping still responding, but everything else 
mostly dead.

I tried using the forcedumount patch to solve this problem - to no avail. 
Also tried upgrading the qlogic drivers to the latest drivers from Qlogic.

After one of the occurences I managed to get some output using the sysrq 
keys.

This seems similar to what is described in 
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=77508 but with a 
different call trace

What I have here is what I managed to copy down (for some reason pgup/pgdown 
didn't work so not all information is full...) together with a manual lookup 
of the call trace
from /proc/ksyms :

process umount
EIP c01190b8			(set_running_and_schedule)
call trace:
c01144c9	f25f9ec0	IO_APIC_get_PCI_irq_vector
c010a8b0	f25f9ed0	enable_irq
c014200c	f25f9ef0	fsync_buffers_list
c0155595	f25f9efc	clear_inode
c015553d	f25f9f2c	invalidate_inodes
c01461d8	f25f9f78	get_super
c014a629	f25f9f94	path_release
c0157c58	f25f9fc0	sys_umount
c0108cab			sys_sigaltstack

Any idea what can cause this ?

I'm hoping the ext3fix.patch will solve this problem... am trying that now.


Thanks,
Yuval

P.S. please CC me for questions/replies as I'm not currently subscribed to 
the list.

--
Yuval Yeret
Exanet
http://www.exanet.com
Tel.  972-9-9717782
Fax. 972-9-9717778








_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963


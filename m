Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVHIOAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVHIOAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVHIOAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:00:07 -0400
Received: from burnt-tech.com ([66.98.218.53]:23502 "HELO burntmail.com")
	by vger.kernel.org with SMTP id S964780AbVHIOAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:00:06 -0400
From: "vinay" <vinays@burntmail.com>
To: "vinay" <vinays@burntmail.com>, "Xavier Roche" <roche+kml2@exalead.com>,
       linux-kernel@vger.kernel.org
Importance: Normal
Sensitivity: Normal
Message-ID: <W9530026198290071123596000@burntmail>
X-Mailer: Mintersoft VisualMail, Build 4.0.111601
X-Originating-IP: [203.200.200.70]
Date: Tue, 09 Aug 2005 14:00:00 +0000
Subject: Swapper crash / Kernels Out Of Memoy(OOM) killer Problem ?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Why I wanted to force OOM killer to send SIGTERM is that -
When my application receives SIGKILL from OOM killer, the application (and it's related threads) are getting killed. But after some time the swapper process is getting crashed and system goes for a reboot. This I feel is due to the cleanup handler (signal handler) not being called when the application receives SIGKILL. 
Could you please through some light on this issue.
Below is the stack dump from /var/log/messages -

CPU:    0
EIP:    0010:[<d086da5a>]    Tainted: PF
EFLAGS: 00010246
eax: 0000007c   ebx: 00000042   ecx: 00000000   edx: 0000007c
esi: d0849579   edi: c0377e5b   ebp: c0377dcc   esp: c0377da0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0377000)
Stack: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000007c
       00427e10 35000080 00000042 c0377e2c d086db60 00000035 00000000 00000000
       0000007c 00000042 cfe29800 c0377e08 c0377e0c 00000001 000000a0 05000000
Call Trace: [<d086db60>]  [<d0849560>]  [<d0871850>]  [<d0874830>]  [<d0874830>
Code: 8b 40 08 3b 42 10 0f 94 c0 0f b6 c0 89 45 e0 e9 92 00 00 00
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 


>-----Original Message-----
>From: vinay [mailto:vinays@burntmail.com]
>Sent: Tuesday, August 9, 2005 09:23 AM
>To: 'Xavier Roche', linux-kernel@vger.kernel.org
>Subject: Re:  Kernels Out Of Memoy(OOM) killer Problem ?
>
>Hello Xavier.
>
>
>
>Thanks for replying.
>
>I checked that the /proc/sys/vm/overcommit_memory is already set to 0.
>
>
>
>In my case the problem is that I don't have many options like changing
>
>the overcommit_memory etc.
>
>Only thing I need to do is, have a proper cleanup will exiting the application.  As the application is receiving SIKILL from OMM killer the required signal handler is not getting called and no cleanup is happening.
>
>So could you please suggest me that what could be done in this regard.
>
>
>
>Thanks and Regards
>
>
>
>Vinay.
>
>
>
>> -----Original Message-----
>
>> From: Xavier Roche [mailto:roche+kml2@exalead.com]
>
>> Sent: Tuesday, August 9, 2005 08:06 AM
>
>> To: linux-kernel@vger.kernel.org
>
>> Subject: Re: Kernels Out Of Memoy(OOM) killer Problem ?
>
>> 
>
>> vinay wrote:
>
>> > I have a problem with linux kernel's Out Of Memory (OOM) killer.
>
>> > I wanted to know, is there any way that we can force OOM killer to send a signal other than SIGKILL to kill a process when ever OOM detects a system memory crunch. 
>
>> 
>
>> As far as I understand the kernel, oom is called when the system has no
>
>> memory pages left, and MUST get one to continue normal (ie. kernel)
>
>> processing. The kernel just do not have the time to execute some
>
>> user-space code, it MUST get free pages where they are (and hence, kill
>
>> immediately some innocent process).
>
>> 
>
>> This condition should not occur without using overcommit. Are you sure
>
>> you are not using overcommit ? (cat /proc/sys/vm/overcommit_memory)
>
>> 
>
>> To dasable it:
>
>> echo 0 > /proc/sys/vm/overcommit_memory
>
>> 
>
>> Overcommit is quite dangerous on production systems, because it leads to
>
>> oom kills on heavy loads (at least, this is what I experienced).
>
>> 
>
>> -
>
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>
>> the body of a message to majordomo@vger.kernel.org
>
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>> 
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



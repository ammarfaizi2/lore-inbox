Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUFPS4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUFPS4c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUFPS4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:56:32 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:53509 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S264515AbUFPS4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:56:05 -0400
Date: Wed, 16 Jun 2004 18:56:02 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: Holger Kiehl <Holger.Kiehl@dwd.de>
cc: Corey Minyard <minyard@acm.org>, Alex Williamson <alex.williamson@hp.com>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: IPMI hangup in 2.6.6-rc3
In-Reply-To: <Pine.LNX.4.58.0406161822280.13439@praktifix.dwd.de>
Message-Id: <Pine.LNX.4.58.0406161842180.13439@praktifix.dwd.de>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de> 
 <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org>
 <1086887543.4182.46.camel@tdi> <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de>
 <40D056E2.4010605@acm.org> <40D05779.9080203@acm.org>
 <Pine.LNX.4.58.0406161822280.13439@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004, Holger Kiehl wrote:

> On Wed, 16 Jun 2004, Corey Minyard wrote:
> 
> > I missed a part of the patch, here is a new one with the include file changes.
> > 
> > -Corey
> > 
> > Corey Minyard wrote:
> > 
> > > Unfortuantely, that fix has some problems, but it was on the right track.  I
> > > have a new patch attached; can you try it out?  Also, the kernel interface
> > > has not changed.  It should be exactly the same as before.
> > > 
> > > -Corey
> > 
> Yes, with this patch it no longer hangs. But ipmitool still crashes
> 
>     root@apollo:~# ipmitool -I open sdr list
>     Segmentation fault
> 
Just when I send the mail I noticed that each time I call ipmitool I get
an oops:

Jun 16 18:43:40 apollo kernel:  <1>Unable to handle kernel paging request at virtual address 00100104
Jun 16 18:43:40 apollo kernel:  printing eip:
Jun 16 18:43:40 apollo kernel: c013ba4a
Jun 16 18:43:40 apollo kernel: *pde = 00000000
Jun 16 18:43:40 apollo kernel: Oops: 0000 [#54]
Jun 16 18:43:40 apollo kernel: SMP 
Jun 16 18:43:40 apollo kernel: Modules linked in: bonding
Jun 16 18:43:40 apollo kernel: CPU:    1
Jun 16 18:43:40 apollo kernel: EIP:    0060:[<c013ba4a>]    Not tainted
Jun 16 18:43:40 apollo kernel: EFLAGS: 00010086   (2.6.7) 
Jun 16 18:43:40 apollo kernel: EIP is at kfree+0x37/0x66
Jun 16 18:43:40 apollo kernel: eax: 00000001   ebx: ffffffea   ecx: 00100100   edx: c1000000
Jun 16 18:43:40 apollo kernel: esi: 000015ec   edi: 00000202   ebp: ffffffff   esp: f6dcce84
Jun 16 18:43:40 apollo kernel: ds: 007b   es: 007b   ss: 0068
Jun 16 18:43:40 apollo kernel: Process ipmitool (pid: 19786, threadinfo=f6dcc000 task=c2269360)
Jun 16 18:43:40 apollo kernel: Stack: ffffffea f6dccf6c f6dcceb0 c01dedca f6dccf78 00000000 00000000 ffffffff 
Jun 16 18:43:40 apollo kernel:        00000000 f7b8f7c8 000015ec 00000500 c000000f f61ebd80 00000282 f7c8be2c 
Jun 16 18:43:40 apollo kernel:        c02e9600 f6e8b008 f6e8b008 00000000 00000004 f6dccf6c bffff2c0 f6dccf6c 
Jun 16 18:43:40 apollo kernel: Call Trace:
Jun 16 18:43:40 apollo kernel:  [<c01dedca>] handle_send_req+0xd3/0xe7
Jun 16 18:43:40 apollo kernel:  [<c01df205>] ipmi_ioctl+0x427/0x474
Jun 16 18:43:40 apollo kernel:  [<c015ece7>] sys_select+0x21c/0x482
Jun 16 18:43:40 apollo kernel:  [<c015e036>] sys_ioctl+0xef/0x223
Jun 16 18:43:40 apollo kernel:  [<c0104cf1>] sysenter_past_esp+0x52/0x71
Jun 16 18:43:40 apollo kernel: 
Jun 16 18:43:40 apollo kernel: Code: 8b 1c 81 8b 03 3b 43 04 73 18 89 74 83 10 83 03 01 57 9d 8b


>>EIP; c013ba4a No symbols available   <=====

Trace; c01dedca No symbols available
Trace; c01df205 No symbols available
Trace; c015ece7 No symbols available
Trace; c015e036 No symbols available
Trace; c0104cf1 No symbols available

Code;  c013ba4a No symbols available
00000000 <_EIP>:
Code;  c013ba4a No symbols available   <=====
   0:   8b 1c 81                  mov    (%ecx,%eax,4),%ebx   <=====
Code;  c013ba4d No symbols available
   3:   8b 03                     mov    (%ebx),%eax
Code;  c013ba4f No symbols available
   5:   3b 43 04                  cmp    0x4(%ebx),%eax
Code;  c013ba52 No symbols available
   8:   73 18                     jae    22 <_EIP+0x22>
Code;  c013ba54 No symbols available
   a:   89 74 83 10               mov    %esi,0x10(%ebx,%eax,4)
Code;  c013ba58 No symbols available
   e:   83 03 01                  addl   $0x1,(%ebx)
Code;  c013ba5b No symbols available
  11:   57                        push   %edi
Code;  c013ba5c No symbols available
  12:   9d                        popf   
Code;  c013ba5d No symbols available
  13:   8b 00                     mov    (%eax),%eax

This must be the reason why ipmitool crashes.

Holger

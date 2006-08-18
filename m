Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWHRI1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWHRI1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHRI1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:27:33 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:16003 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751140AbWHRI1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:27:32 -0400
Message-ID: <44E57931.1010607@aitel.hist.no>
Date: Fri, 18 Aug 2006 10:24:17 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1  BUG null pointer deref while saving a file
References: <20060813012454.f1d52189.akpm@osdl.org>	 <44E30517.10603@aitel.hist.no> <1155738526.9367.6.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1155738526.9367.6.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:
> On Wed, 2006-08-16 at 13:44 +0200, Helge Hafting wrote:
>   
>> Aug 16 13:20:30 hh kernel: BUG: unable to handle kernel NULL pointer 
>> dereference at virtual address 00000000
>> Aug 16 13:20:30 hh kernel:  printing eip:
>> Aug 16 13:20:30 hh kernel: c0468863
>> Aug 16 13:20:30 hh kernel: *pde = 00000000
>> Aug 16 13:20:30 hh kernel: Oops: 0002 [#1]
>> Aug 16 13:20:30 hh kernel: 4K_STACKS
>> Aug 16 13:20:30 hh kernel: last sysfs file: 
>> /devices/platform/i2c-9191/9191-0290/in0_input
>> Aug 16 13:20:30 hh kernel: CPU:    0
>> Aug 16 13:20:30 hh kernel: EIP:    0060:[<c0468863>]    Not tainted VLI
>> Aug 16 13:20:30 hh kernel: EFLAGS: 00010002   (2.6.18-rc4-mm1 #7)
>> Aug 16 13:20:30 hh kernel: EIP is at __down+0x5c/0xed
>> Aug 16 13:20:30 hh kernel: eax: 00000000   ebx: d462e7e4   ecx: 
>> c14e7e40   edx: dde06f0c
>> Aug 16 13:20:30 hh kernel: esi: 00000286   edi: c3365550   ebp: 
>> d462e7ec   esp: dde06efc
>> Aug 16 13:20:30 hh kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 16 13:20:30 hh kernel: Process lyx (pid: 9353, ti=dde06000 
>> task=c3365550 task.ti=dde06000)
>> Aug 16 13:20:30 hh kernel: Stack: dde06f0c 00000001 c3365550 c0116941 
>> d462e7ec 00000000 00000008 d851a9a8
>> Aug 16 13:20:30 hh kernel:        d462e7c0 d32a1200 c0466bc7 c14e7e40 
>> dde06000 c01ed987 00000008 00000000
>> Aug 16 13:20:30 hh kernel:        00000000 00000000 d7a31c00 caf9be0c 
>> 00000000 00001dbb d462e7e4 00000008
>> Aug 16 13:20:30 hh kernel: Call Trace:
>> Aug 16 13:20:30 hh kernel:  [<c0466bc7>] __down_failed+0x7/0xc
>> Aug 16 13:20:30 hh kernel: DWARF2 unwinder stuck at __down_failed+0x7/0xc
>> Aug 16 13:20:31 hh kernel: Leftover inexact backtrace:
>> Aug 16 13:20:31 hh kernel:  [<c01ed987>] .text.lock.file+0x54/0x9d
>> Aug 16 13:20:31 hh kernel:  [<c01516bd>] __fput+0xb2/0x163
>> Aug 16 13:20:31 hh kernel:  [<c014ee9d>] filp_close+0x3e/0x62
>> Aug 16 13:20:31 hh kernel:  [<c0150168>] sys_close+0x5c/0x6b
>> Aug 16 13:20:31 hh kernel:  [<c01028c9>] sysenter_past_esp+0x56/0x79
>>     
>
> By any chance would you be using cifs?  This looks just like the bug
> that is fixed by this patch:
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/sfrench/cifs-2.6.git;a=commitdiff;h=e466e4876bf39474e15d0572f2204578137ae7f5
>   
Yes, this is on cifs.  I should have mentioned that.  Is this patch going
in anyway, or should I test it?  I don't know a way of reproducing
the problem.


Helge Hafting

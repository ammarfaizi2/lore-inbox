Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTLGWZB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLGWZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 17:25:00 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:30980
	"EHLO diablo.hd.free.fr") by vger.kernel.org with ESMTP
	id S264534AbTLGWY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 17:24:58 -0500
Message-ID: <3FD3A8AF.7030508@free.fr>
Date: Sun, 07 Dec 2003 23:24:47 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <3FC4E8C8.4070902@free.fr> <200312070125.56251.baldrick@free.fr> <3FD39722.8000500@free.fr> <200312072224.32417.baldrick@free.fr>
In-Reply-To: <200312072224.32417.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> On Sunday 07 December 2003 22:09, Vince wrote:
> 
>>Duncan Sands wrote:
>>
>>>Does this help?  It isn't finished - it represents the current state of
>>>my fix. Warning: have barf bag ready.
>>>
>>
>> > [patch cut]
>>
>>Yes, your patch fixes the problem: no more oops and modem_run now exits
>>cleanly. Thank you very much !
> 
> 
> Hi Vincent, that's great!  I think the fix is solid, but can you please beat on it
> a bit just to be sure...
> 
> Thanks,
> 
> Duncan.

Yes, I was doing just that, and perhaps I've spoken too early as I got 
this (non-fatal) oops in the log (the kernel is tainted as this time 
I've loaded X and therefore the nvidia kernel driver; however I've never 
experienced this bug before; I'll try to reproduce without it):

------------[ cut here ]------------
kernel BUG at include/linux/list.h:148!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c016d3a3>]    Tainted: PF  VLI
EFLAGS: 00010206
EIP is at prune_dcache+0x1d3/0x1e0
eax: 00000000   ebx: c259dbc0   ecx: c259dbd4   edx: c7009e1c
esi: c259dc30   edi: c1190000   ebp: c1191e84   esp: c1191e6c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=c1190000 task=c1195340)
Stack: c70dfa40 c1191e70 0000007b 00000080 c1190000 0000000d c1191e90 
c016d892
        00000080 c1191ec4 c014524f 00000080 000000d0 000069a8 00110162 
00000000
        00000029 00000000 c7ffeb60 000000ad c02ec9f4 00000001 c1191f08 
c014662e
Call Trace:
  [<c016d892>] shrink_dcache_memory+0x22/0x30
  [<c014524f>] shrink_slab+0x10f/0x160
  [<c014662e>] balance_pgdat+0x1ce/0x1f0
  [<c0146729>] kswapd+0xd9/0xf0
  [<c0120640>] autoremove_wake_function+0x0/0x50
  [<c02a2f66>] ret_from_fork+0x6/0x14
  [<c0120640>] autoremove_wake_function+0x0/0x50
  [<c0146650>] kswapd+0x0/0xf0
  [<c010a2a9>] kernel_thread_helper+0x5/0xc

Code: 4f 14 a8 08 75 11 8b 47 08 ff 4f 14 a8 08 74 b3 e8 83 1a fb ff eb 
ac e8 7c 1a fb ff eb e8 0f 0b 95 00 5d 84 2b c0 e9 33 ff ff ff <0f> 0b 
94 00 5d 84 2b c0 e9 1a ff ff ff 55 89 e5 57 56 53 83 ec
  <6>note: kswapd0[7] exited with preempt_count 2



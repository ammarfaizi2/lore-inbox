Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263645AbTCUQKA>; Fri, 21 Mar 2003 11:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263648AbTCUQKA>; Fri, 21 Mar 2003 11:10:00 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:6272 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S263645AbTCUQJw>;
	Fri, 21 Mar 2003 11:09:52 -0500
Message-ID: <3E7B3BEE.4060901@portrix.net>
Date: Fri, 21 Mar 2003 17:21:02 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with bttv in latest bk
References: <3E78BB99.3070605@portrix.net> <87he9z7z95.fsf@bytesex.org> <3E796530.2010707@portrix.net> <87znnqmitn.fsf@bytesex.org> <3E79ED9F.1000402@portrix.net> <87y939x1sk.fsf@bytesex.org> <3E7AFD4C.2000205@portrix.net> <87bs04lqc8.fsf@bytesex.org>
In-Reply-To: <87bs04lqc8.fsf@bytesex.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> Jan Dittmer <j.dittmer@portrix.net> writes:
> 
> 
>>>>bttv: driver version 0.9.7 loaded
>>>
>>>As it kills the X-Server I guess you are using the X-Servers v4l
>>>module and the Xvideo extention, correct?
>>>
>>
>>yes, using the nv driver. xfree 4.2.1.
> 
> 
> Hmm, I can't reproduce that locally.  Pushed my latest bits to
> http://bytesex.org/patches/2.5/
> 
> Can you try it again?  If it still oopses for you, can you please load
> the driver with bttv_debug=2 insmod option and mail me that log?
> 
Works if loaded as module. Compiled in I now get the following lock up 
at boot time. Bug was introduced with recent i2c changes in bk tree, I 
suspect.

Jan


bttv0: PLL: 28636363 => 35468950 .. ok

Unable to handle kernel NULL pointer dereference at virtual address 00000068
  printing eip:
c026db63
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c026db63>]    Not tainted
EFLAGS: 00010202
EIP is at kobject_get+0x13/0x40
eax: c151c000   ebx: 00000058   ecx: ffffffff   edx: c0522e38
esi: c0522e14   edi: c0522e64   ebp: fffffffc   esp: c151df58
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c151c000 task=dff8e040)
Stack: c0522e54 c026d8bd 00000058 c0522e54 c026da97 c0522e54 c051e644
c0522e04
        c02d7a7d c0522e54 c02d78af c0522e54 00000042 c0522e04 c0522e00
00000000
        00000000 c02d7ddf c0522e38 00001237 00000000 c059d6a8 00000000
c037307f

Call Trace:
  [<c026d8bd>] kobject_init+0x2d/0x50
  [<c026da97>] kobject_register+0x17/0x70
  [<c02d7a7d>] get_bus+0x1d/0x40
  [<c02d78af>] bus_add_driver+0x5f/0xf0
  [<c02d7ddf>] driver_register+0x2f/0x40
  [<c037307f>] i2c_add_driver+0x9f/0x110
  [<c02fc0bf>] msp3400_init_module+0xf/0x20
  [<c01050a3>] init+0x33/0x190
  [<c0105070>] init+0x0/0x190
  [<c010923d>] kernel_thread_helper+0x5/0x18




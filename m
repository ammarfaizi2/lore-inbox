Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbTGDISo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbTGDISo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:18:44 -0400
Received: from [195.95.38.160] ([195.95.38.160]:38397 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S265862AbTGDISm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:18:42 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: Unable to handle NULL point when doing lsof
Date: Fri, 4 Jul 2003 10:34:55 +0200
User-Agent: KMail/1.5.2
References: <3F0539E5.6030905@portrix.net>
In-Reply-To: <3F0539E5.6030905@portrix.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307041034.55785.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 July 2003 10:25, Jan Dittmer wrote:
> Just executing lsof gives a segmentation fault.
> This is 2.5.73-mm3 and reproducable on dual p3 and single p3-800.
> Will try 2.5.74-mm1 now.

I can confirm this on 2.5.74-mm1, machine Single p3 650.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c013b6b0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[kfree+48/112]    Not tainted VLI
EFLAGS: 00010006
EIP is at kfree+0x30/0x70
eax: 00140000   ebx: c5de6aa0   ecx: c5d38630   edx: 00000000
esi: 00000100   edi: 00000206   ebp: c5d38630   esp: cf683f48
ds: 007b   es: 007b   ss: 0068
Process lsof (pid: 1762, threadinfo=cf682000 task=c68ff310)
Stack: 00000100 c5de6ab8 c5de6aa0 c3b9fb60 c5d38630 c016e1e5 00000100 00000000 
       c3b9fb60 c5f7dca0 cffcf220 c015038a c5d38630 c3b9fb60 c85d0580 c3b9fb60 
       c5f7dca0 00000000 cf682000 c014e95d c3b9fb60 c5f7dca0 c5f7dca0 c3b9fb60 
Call Trace:
 [seq_release_private+37/72] seq_release_private+0x25/0x48
 [__fput+266/288] __fput+0x10a/0x120
 [filp_close+77/128] filp_close+0x4d/0x80
 [sys_close+97/160] sys_close+0x61/0xa0
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 24 0c 8b 74 24 18 89 5c 24 08 89 7c 24 10 85 f6 74 2a 9c 5f fa 8b 15 38 
d2 33 c0 8d 86 00 00 00 40 c1 e8 0c 8d 04 80 8b 54 c2 08 <8b> 1a 8b 03 3b 43 
04 73 18 89 74 83 10 ff 03 57 9d 8b 5c 24 08 


Jan
-- 
Penguin laptop (i686) running GNU/Linux 2.5.74-mm1 #1 Fri Jul 4 07:26:32 CEST 
2003
Giving money and power to governments is like giving whiskey and
car keys to teenage boys.
	-- P.J. O'Rourke


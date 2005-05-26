Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVEZR7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVEZR7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVEZR7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:59:06 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:51432 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261668AbVEZR5e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:57:34 -0400
Date: Thu, 26 May 2005 19:57:33 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1 OOPS
Message-ID: <20050526195733.41e54ab6@discovery.hal.lan>
X-Mailer: Sylpheed-Claws 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i got these error, leading to an unstable system, which freezed after i
typed "shutdown -r now":

Unable to handle kernel paging request at virtual address b7997000
 printing eip:
c03655c2
*pde = 32293067
*pte = 3ce52025
Oops: 0003 [#1]
PREEMPT 
Modules linked in: nvidia
CPU:    0
EIP:    0060:[<c03655c2>]    Tainted: P      VLI
EFLAGS: 00010206   (2.6.12-rc5-mm1)
EIP is at videobuf_vm_close+0x22/0xe0
eax: 464c457e   ebx: f5546000   ecx: f2f0b4b8   edx: f2f0b330
esi: 00000000   edi: b7997000   ebp: f740b280   esp: f5547f24
ds: 007b   es: 007b   ss: 0068
Process tvtime (pid: 15952, threadinfo=f5546000 task=f74bc0b0)
Stack: b78bf000 b7997000 f2f0b388 f5547f5c f5546000 f5546000 f25d19e0
f2f0b330 c015191c f2f0b330 f2f0b358 f752f548 00000000 f740b280 b78bf000
c01533af f2f0b330 f2f0b330 b7997000 f2f0b330 c01537cf f740b280 f2f0b330
f2f0b490 Call Trace:
 [<c015191c>] remove_vm_struct+0x8c/0xa0
 [<c01533af>] unmap_vma_list+0x1f/0x30
 [<c01537cf>] do_munmap+0x11f/0x180
 [<c0153874>] sys_munmap+0x44/0x70
 [<c01032eb>] sysenter_past_esp+0x54/0x75
Code: c4 14 5b c3 90 8d 74 26 00 57 56 53 83 ec 14 83 3d f4 f4 62 c0 01
8b 54 24 24 8b 7a 50 8b 77 0c 0f 8f 93 00 00 00 8b 07 48 85 c0 <89> 07
0f 85 7f 00 00 00 a1 f4 f4 62 c0 85 c0 7e 14 89 74 24 08 <1>Unable to
handle kernel paging request at virtual address 6fedd468 printing eip:
c03f099a *pde = 00000000
Oops: 0002 [#2]
PREEMPT
Modules linked in: nvidia
CPU:    0
EIP:    0060:[<c03f099a>]    Tainted: P      VLI
EFLAGS: 00010286   (2.6.12-rc5-mm1)
EIP is at snd_pcm_mmap_data_close+0xa/0x20
eax: 6fedd3c4   ebx: f0dae000   ecx: f26dfcf8   edx: c03f0990
esi: e2bc44e0   edi: f26df960   ebp: f7b13040   esp: f0daff44
ds: 007b   es: 007b   ss: 0068
Process beep-media-play (pid: 6473, threadinfo=f0dae000 task=e21d8a10)
Stack: c015191c f26df960 f26df988 f769d9d0 00000000 f7b13040 b589b000
c01533af f26df960 f26df960 b58ab000 f26df960 c01537cf f7b13040 f26df960
f26df228 b589b000 b58ab000 f26df228 f7b13040 f7b13070 08324848 f0dae000
c0153874 Call Trace:
 [<c015191c>] remove_vm_struct+0x8c/0xa0
 [<c01533af>] unmap_vma_list+0x1f/0x30
 [<c01537cf>] do_munmap+0x11f/0x180
 [<c0153874>] sys_munmap+0x44/0x70
 [<c01032eb>] sysenter_past_esp
+0x54/0x75
Code: c7 40 44 fc bf 58 c0 89 50 50 8b 42 60 ff 80 a4 00 00 00 31 c0 c3
8d 74 26 00 8d bc 27 00 00 00 00 8b 44 24 04 8b 40 50 8b 40 60 <ff> 88
a4 00 00 00 c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90

Well, i dont know. where this tvtime error came from, but the error in
beep-media-player happend right while the programm tried to switch to
the next song.
After i saw that beep-media-player was frozen, i didn´t wonder too
much, couse it´s an unstable version that freezes all day long, but i
was geting some king of nervous when that "killall beep-media-player
-9" also freezed. "ps aux" freezed at the line, where i guess it should
print the beep-media-player line. After that, the only thing left to do
was to hit the reset button :(

Kind regards

Florian Engelhardt

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination

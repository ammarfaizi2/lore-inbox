Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266316AbUGUNoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266316AbUGUNoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 09:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUGUNoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 09:44:55 -0400
Received: from smtp.variomedia.de ([81.28.224.28]:13520 "EHLO
	smtp.variomedia.de") by vger.kernel.org with ESMTP id S266316AbUGUNow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 09:44:52 -0400
From: Frederik <frederik@padjen.de>
To: linux-kernel@vger.kernel.org
Subject: Oops when modprobing cx8800
Date: Wed, 21 Jul 2004 15:45:30 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407211545.31058.frederik@padjen.de>
X-Relay-User: frederik@padjen.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

first off, this is my first post to the list and i have zero debugging 
experience, so please try and be kind if i make stupid mistakes :)

I own a Hauppauge TV card with the Conexant cx88 chipset on a VIA chipset 
motherboard.I use i2c for temperature monitoring.When the i2c_core module
is loaded, and i additionally modprobe cx8800, i get the following oops:

Jul 21 15:30:21 athene kernel: cx8800[0]: i2c attach [client=eeprom]
Jul 21 15:30:21 athene kernel: cx8800[0]: i2c register ok
Jul 21 15:30:21 athene kernel: Unable to handle kernel paging request at 
virtual address 88c987f8
Jul 21 15:30:21 athene kernel:  printing eip:
Jul 21 15:30:21 athene kernel: c0209e37
Jul 21 15:30:21 athene kernel: *pde = 00000000
Jul 21 15:30:21 athene kernel: Oops: 0000 [#1]
Jul 21 15:30:21 athene kernel: PREEMPT
Jul 21 15:30:21 athene kernel: Modules linked in: cx8800 cx88xx video_buf 
i2c_algo_bit btcx_risc md5 ipv6 raid0 eeprom i2c_viapro w83781d i2c_sensor 
i2c_isa i2c_dev i2c_core
Jul 21 15:30:21 athene kernel: CPU:    0
Jul 21 15:30:21 athene kernel: EIP:    0060:[<c0209e37>]    Not tainted
Jul 21 15:30:21 athene kernel: EFLAGS: 00010a06   (2.6.8-rc2)
Jul 21 15:30:21 athene kernel: EIP is at vsnprintf+0x37/0x4a0
Jul 21 15:30:21 athene kernel: eax: 00d0ceb0   ebx: c987f800   ecx: 88c987f8   
edx: 00000000
Jul 21 15:30:21 athene kernel: esi: 00d0ceb1   edi: 00000000   ebp: 80d0ceaf 
esp: c9f7de29
Jul 21 15:30:21 athene kernel: ds: 007b   es: 007b   ss: 0068
Jul 21 15:30:21 athene kernel: Process modprobe (pid: 147, threadinfo=c9f7c000 
task=c9e52680)
Jul 21 15:30:21 athene kernel: Stack: 65c987fa 80000048 64c987f8 80c987f8 
28000000 c0c987f8 64d0cb9e 50c987f8
Jul 21 15:30:21 athene kernel:        01c9f7de 50000000 c987f800 cff4ac00 
00000000 c987f828 c020a377 00d0ceb1
Jul 21 15:30:21 athene kernel:        7fffffff 88c987f8 c9f7de91 c020a39f 
00d0ceb1 88c987f8 c9f7de91 d0cc1078
Jul 21 15:30:21 athene kernel: Call Trace:
Jul 21 15:30:21 athene kernel:  [<c020a377>] vsprintf+0x27/0x30
Jul 21 15:30:21 athene kernel:  [<c020a39f>] sprintf+0x1f/0x30
Jul 21 15:30:21 athene kernel:  [<d0cc1078>] cx8800_initdev+0x78/0x7a0 
[cx8800]
Jul 21 15:30:21 athene kernel: Code: 80 39 00 74 27 8d 74 26 00 0f b6 01 3c 25 
74 3f 39 ee 77 06

I have tested this on 2.6.5, 2.6.7 and 2.6.8-rc2.
2.6.5 works fine, the latter two give the oops.Both modules (cx8800 and 
i2c_core) work fine alone on all kernels tested.

Hopefully relevant lspci output:
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:0a.0 Multimedia video controller: Conexant: Unknown device 8800 (rev 03)
00:0a.1 Multimedia controller: Conexant: Unknown device 8811 (rev 03)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)

If anyone wants me to try something else, lead on and i will follow.

Have a nice day
Frederik



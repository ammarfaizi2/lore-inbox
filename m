Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTE1EME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTE1EMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:12:03 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:27074 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264494AbTE1EMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:12:02 -0400
Date: Wed, 28 May 2003 14:26:10 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030528042610.GD6501@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

removed my xircom pcmcia realport card and put in another. End result was
total loss of ps2 keyboard functionality (everything else, inc the ps2 mouse
still works). I then removed the xircom card. The following was in dmesg:

Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c020522b
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c020522b>]    Not tainted
EFLAGS: 00010282
EIP is at pci_remove_bus_device+0x47/0x74
eax: 6b6b6b6b   ebx: 00000000   ecx: c04a9a64   edx: 6b6b6b6b
esi: c138291c   edi: 00000080   ebp: cfdc7f40   esp: cfdc7f34
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 10, threadinfo=cfdc6000 task=c136e060)
Stack: c1382968 c138210c cfe1089c cfdc7f54 c020527c c138291c cfe1089c c1305044 
       cfdc7f64 c02c746d cfe1089c c1305044 cfdc7f88 c02c4564 c1305044 c1305044 
       c1305050 c1305044 c1305044 00000080 c136e060 cfdc7f98 c02c46d8 c1305044 
Call Trace:
 [<c020527c>] pci_remove_behind_bridge+0x24/0x48
 [<c02c746d>] cb_free+0x1d/0x30
 [<c02c4564>] shutdown_socket+0x70/0xe8
 [<c02c46d8>] socket_shutdown+0x38/0x40
 [<c02c4ae6>] pccardd+0x10e/0x1c4
 [<c02c49d8>] pccardd+0x0/0x1c4
 [<c0119110>] default_wake_function+0x0/0x20
 [<c0119110>] default_wake_function+0x0/0x20
 [<c0107211>] kernel_thread_helper+0x5/0xc

Code: 89 50 04 89 02 8b 56 04 8b 06 83 c4 04 89 50 04 89 02 56 e8 
 <1>Unable to handle kernel paging request at virtual address 50601a3c
 printing eip:
50601a3c
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<50601a3c>]    Not tainted
EFLAGS: 00010012
EIP is at 0x50601a3c
eax: 50601a3c   ebx: 2a456029   ecx: 00000003   edx: cfdc7fe4
esi: 00000001   edi: 5374872e   ebp: c12a9f48   esp: c12a9f2c
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c12a8000 task=c12acc80)
Stack: c0119163 cfdc7fd8 00000003 00000000 c12a8000 00000246 c0551218 c12a9f68 
       c0119198 c13051c4 00000003 00000001 00000000 c1305044 00000080 c12a9f74 
       c02c4bda c05511e0 c12a9f8c c02c982f c1305044 00000080 c12a8000 c02c97f4 
Call Trace:
 [<c0119163>] __wake_up_common+0x33/0x4c
 [<c0119198>] __wake_up+0x1c/0x40
 [<c02c4bda>] parse_events+0x3e/0x44
 [<c02c982f>] yenta_bh+0x3b/0x44
 [<c02c97f4>] yenta_bh+0x0/0x44
 [<c01283ff>] worker_thread+0x1a3/0x270
 [<c012825c>] worker_thread+0x0/0x270
 [<c02c97f4>] yenta_bh+0x0/0x44
 [<c0119110>] default_wake_function+0x0/0x20
 [<c0119110>] default_wake_function+0x0/0x20
 [<c0107211>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.
 <6>note: events/0[3] exited with preempt_count 1

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbULDWpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbULDWpW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbULDWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:45:22 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:24767 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261184AbULDWpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:45:08 -0500
Message-ID: <41B23DF2.4010303@g-house.de>
Date: Sat, 04 Dec 2004 23:45:06 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [FYI] linux 2.6 still not working with PReP (ppc32)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,

upon receiving some calls about the status on this issue, i decided to
update http://bugme.osdl.org/show_bug.cgi?id=1494 , which i reported a
while back. yes, this is "just a PReP" and i am fully aware that PReP is
not used in recent setups any more and i too will not my PReP for HPC
applications. but perhaps someone has an idea about what's goin on here.

the bugreport should give you th full details, in short: linux 2.5.30 is
the last working kernel for ppc32/PReP with networking enabled.
(net)booting a recent 2.6 kernels spit out lots of these:

(with tulip NIC)
Dec  3 23:56:39 192.168.10.9 irq 9: nobody cared!
Dec  3 23:56:39 192.168.10.9 Call trace:
Dec  3 23:56:39 192.168.10.9 [c002e99c] __report_bad_irq+0x34/0xac
Dec  3 23:56:39 192.168.10.9 [c002eb00] note_interrupt+0xd0/0x104
Dec  3 23:56:39 192.168.10.9 [c002e480] __do_IRQ+0x174/0x184
Dec  3 23:56:39 192.168.10.9 [c00053e0] do_IRQ+0x38/0x98
Dec  3 23:56:39 192.168.10.9 [c00044cc] ret_from_except+0x0/0x14
Dec  3 23:56:39 192.168.10.9 [c002e748] setup_irq+0xd8/0x138
Dec  3 23:56:39 192.168.10.9 [c002e938] request_irq+0x90/0xc0
Dec  3 23:56:39 192.168.10.9 [c0103504] tulip_open+0x30/0xb6c
Dec  3 23:56:39 192.168.10.9 [c0117274] dev_open+0xb0/0xd8
Dec  3 23:56:39 192.168.10.9 [c0118a7c] dev_change_flags+0x6c/0x144
Dec  3 23:56:39 192.168.10.9 [c0123db4] netpoll_setup+0x1c4/0x364
Dec  3 23:56:39 192.168.10.9 [c0106fe0] init_netconsole+0x3c/0x94
Dec  3 23:56:39 192.168.10.9 [c0003a64] init+0xb8/0x230
Dec  3 23:56:39 192.168.10.9 [c0006524] kernel_thread+0x44/0x60
Dec  3 23:56:39 192.168.10.9 handlers:
Dec  3 23:56:39 192.168.10.9 [<c010101c>] (tulip_interrupt+0x0/0xd3c)
Dec  3 23:56:39 192.168.10.9 Disabling IRQ #9

(with 3c59x NIC)
192.168.10.9 NETDEV WATCHDOG: eth0: transmit timed out
192.168.10.9 eth0: transmit timed out, tx_status 00 status e800.
192.168.10.9 diagnostics: net 0cc0 media 8802 dma 002000b3 fifo 0000
192.168.10.9 eth0: Interrupt posted but not delivered -- IRQ blocked by
another device?
192.168.10.9 Flags; bus-master 1, dirty 67(3) current 68(4)
192.168.10.9 Transmit list 806fe480 vs. c06fe3e0.
192.168.10.9 0: @c06fe200  length 80000054 status 00000054
192.168.10.9 1: @c06fe2a0  length 8000005e status 0000005e
192.168.10.9 2: @c06fe340  length 80000064 status 00000064
192.168.10.9 3: @c06fe3e0  length 80000075 status 00000075
192.168.10.9 4: @c06fe480  length 8000005b status 0000005b
192.168.10.9 5: @c06fe520  length 80000051 status 00000051
192.168.10.9 6: @c06fe5c0  length 8000005a status 0000005a
192.168.10.9 7: @c06fe660  length 8000005a status 0000005a
192.168.10.9 8: @c06fe700  length 8000005a status 0000005a
192.168.10.9 9: @c06fe7a0  length 8000005a status 0000005a
192.168.10.9 10: @c06fe840  length 8000005a status 0000005a
192.168.10.9 11: @c06fe8e0  length 8000005a status 0000005a
192.168.10.9 12: @c06fe980  length 8000005a status 0000005a
192.168.10.9 13: @c06fea20  length 8000005a status 0000005a
192.168.10.9 14: @c06feac0  length 8000005a status 0000005a
192.168.10.9 13: @c06fea20  length 8000005a status 0000005a
192.168.10.9 14: @c06feac0  length 8000005a status 0000005a
192.168.10.9 15: @c06feb60  length 8000005a status 0000005a

is it possible to use another irq for the network-device driver?
Documentation/kernel-parameters.txt gives some options about other
drivers, but i can't tell how to specify "use this irq" for tulip/3c59x.

especially the "IRQ blocked by another device?" message makes me think,
that manual irq config could help here. but maybe i'm wrong.

the results posted on http://nerdbynature.de/bits/sheep/2.6.10-rc2/ are
from current 2.6 kernels: the offical tree and the linuxppc25 tree was used.

thank you for comments,
Christian.
- --
BOFH excuse #441:

Hash table has woodworm
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBsj3y+A7rjkF8z0wRAldLAJ9QFTfr8UeOtXbnSCGWBVJr7IAAKgCgiHRV
iB/ozetyCDIMSfAa+1MRxVc=
=b5BK
-----END PGP SIGNATURE-----

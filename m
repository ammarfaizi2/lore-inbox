Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbUKEQFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUKEQFc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKEQFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:05:32 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13696 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262709AbUKEQE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:04:29 -0500
Message-Id: <200411050424.iA54OoZa004798@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@novell.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm2 and Yet *Another* NVidia Breakage...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_490609566P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Nov 2004 23:24:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_490609566P
Content-Type: text/plain; charset=us-ascii

Yes, I know NVidia is evil and all that - this is just a heads-up (I know
there's at least one NVidia person lurking on lkml), and sooner or later
we'll have others tripping over it as well.

2.6.10-rc1-mm2 with the NVidia 6111 drivers hits a BUG() introduced with
fix-iounmap-and-a-pageattr-memleak-x86-and-x86-64.patch - driver comes up
just fine if I 'patch -R' that one out.

I suspect that this is caused by the same wonky memory management inside
the NVidia driver that lead to the __PAGE_OFFSET issues a while back (looking
at the code in change_page_attr(), it's more likely that NVidia is passing
a wonky pointer than the patch is buggy)...

Recommended action(s):
1) Andi/Andrea/Andrew - just note it's a known issue
2) NVidia probably needs to fix their memory management
3) Anybody else who complains, point them at this posting and
they're free to 'patch -R' as a *temporary* workaround.

Nov  4 00:05:27 turing-police kernel: kernel BUG at arch/i386/mm/pageattr.c:133!
Nov  4 00:05:27 turing-police kernel: invalid operand: 0000 [#2]
Nov  4 00:05:27 turing-police kernel: PREEMPT
Nov  4 00:05:27 turing-police kernel: Modules linked in: agpgart sunrpc ip_conntrack_ftp ipt_pkttype ipt_REJECT ipt_state ip_con
ntrack ipt_LOG ipt_limit iptable_filter ip_tables microcode nvidia i8k thermal processor fan button battery ac ohci1394 ieee1394
 floppy
Nov  4 00:05:27 turing-police kernel: CPU:    0
Nov  4 00:05:27 turing-police kernel: EIP:    0060:[__change_page_attr+175/298]    Tainted: P      VLI
Nov  4 00:05:27 turing-police kernel: EFLAGS: 00013002   (2.6.10-rc1-mm2)
Nov  4 00:05:27 turing-police kernel: EIP is at __change_page_attr+0xaf/0x12a
Nov  4 00:05:27 turing-police kernel: eax: 038001e3   ebx: 039a0000   ecx: c100a3a0   edx: 038001e3
Nov  4 00:05:27 turing-police kernel: esi: c051dc38   edi: 00000163   ebp: c4d35dd8   esp: c4d35dc4
Nov  4 00:05:27 turing-police kernel: ds: 007b   es: 007b   ss: 0068
Nov  4 00:05:27 turing-police kernel: Process X (pid: 9483, threadinfo=c4d34000 task=c4d33830)
Nov  4 00:05:27 turing-police kernel: Stack: c1000000 c39a0000 00000010 c1073400 00000011 c4d35df8 c0117549 00003282
Nov  4 00:05:27 turing-police kernel:        00000000 00000163 c1073200 c48f8d00 cadf7c00 c4d35e08 c0116f94 00010000
Nov  4 00:05:27 turing-police kernel:        d0f80000 c4d35e10 d154a5ac c4d35e40 d13883f0 d0f80000 00010000 c4d35e40
Nov  4 00:05:27 turing-police kernel: Call Trace:
Nov  4 00:05:27 turing-police kernel:  [show_stack+118/126] show_stack+0x76/0x7e
Nov  4 00:05:27 turing-police kernel:  [show_registers+234/338] show_registers+0xea/0x152
Nov  4 00:05:27 turing-police kernel:  [die+361/605] die+0x169/0x25d
Nov  4 00:05:27 turing-police kernel:  [do_invalid_op+218/228] do_invalid_op+0xda/0xe4
Nov  4 00:05:27 turing-police kernel:  [error_code+45/56] error_code+0x2d/0x38
Nov  4 00:05:27 turing-police kernel:  [change_page_attr+199/369] change_page_attr+0xc7/0x171
Nov  4 00:05:27 turing-police kernel:  [iounmap+98/126] iounmap+0x62/0x7e
Nov  4 00:05:27 turing-police kernel:  [pg0+285140396/1068114944] os_unmap_kernel_space+0xb/0xd [nvidia]
Nov  4 00:05:27 turing-police kernel:  [pg0+283296752/1068114944] _nv001521rm+0x20/0x2c [nvidia]
Nov  4 00:05:27 turing-police kernel:  [pg0+283286625/1068114944] _nv002080rm+0xe9/0x184 [nvidia]
Nov  4 00:05:27 turing-police kernel:  [pg0+283321788/1068114944] rm_teardown_agp+0x48/0x50 [nvidia]
Nov  4 00:05:27 turing-police kernel:  [pg0+285132382/1068114944] nv_agp_teardown+0x50/0x81 [nvidia]
Nov  4 00:05:28 turing-police kernel:  [pg0+283305579/1068114944] _nv001523rm+0x73/0xa0 [nvidia]
Nov  4 00:05:28 turing-police kernel:  [pg0+283309249/1068114944] _nv001190rm+0x81/0xb0 [nvidia]
Nov  4 00:05:28 turing-police kernel:  [pg0+283319615/1068114944] rm_disable_adapter+0x5f/0x90 [nvidia]
Nov  4 00:05:28 turing-police kernel:  [pg0+285121502/1068114944] nv_kern_close+0x186/0x1f7 [nvidia]
Nov  4 00:05:28 turing-police kernel:  [__fput+89/317] __fput+0x59/0x13d
Nov  4 00:05:28 turing-police kernel:  [filp_close+91/101] filp_close+0x5b/0x65
Nov  4 00:05:28 turing-police kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Nov  4 00:05:28 turing-police kernel: Code: 90 53 c0 c1 f9 05 c1 e1 0c 0b 0d 38 5a 45 c0 e8 02 fe ff ff 89 d9 ff 41 04 eb 18 a9 
80 00 00 00 75 09 09 fb 89 1e ff 49 04 eb 08 <0f> 0b 85 00 77 f4 3f c0 8b 41 04 40 75 08 0f 0b 88 00 77 f4 3f

--==_Exmh_490609566P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiwCScC3lWbTT17ARAhG1AKDsWpXPvC4+DPqMbdJWmYc9b70qMgCgt9rZ
5lNnu63e45nQMgH7kAwDQdM=
=47Uv
-----END PGP SIGNATURE-----

--==_Exmh_490609566P--

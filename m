Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFIEXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFIEXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 00:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVFIEXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 00:23:49 -0400
Received: from h80ad254e.async.vt.edu ([128.173.37.78]:32017 "EHLO
	h80ad254e.async.vt.edu") by vger.kernel.org with ESMTP
	id S261315AbVFIEXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 00:23:45 -0400
Message-Id: <200506090423.j594NWts004829@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.12-rc6-mm1 OOPS in tcp_push_one()
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118291011_3588P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Jun 2005 00:23:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118291011_3588P
Content-Type: text/plain; charset=us-ascii

Am at home, running PPP over a modem.  I get a request to push a patch to a
Sourceforge project I have CVS commit access to.  So I do a 'export CVS_RSH=ssh'
and then do a 'cvs commit', and ker-blammo.

Very reproducible - this is about the 6th time in the past hour, always on
a cvs-over-ssh.  Oddly enough, if I trigger it while logged on one of the
virtual consoles, I can c-a-f2 to another console, login, and run dmesg
to capture the wreckage.  Doing it from an xterm window with the X server
running causes the system to lock up hard - I'm betting the oops dies with a
lock held, and the X server immediately hangs because it tries to do some
networking/socket stuff....

[17179956.772000] Unable to handle kernel paging request at virtual address a56b6b75
[17179956.776000]  printing eip:
[17179956.788000] c0307f4c
[17179956.792000] *pde = 00000000
[17179956.804000] Oops: 0000 [#1]
[17179956.804000] PREEMPT 
[17179956.804000] Modules linked in: ppp_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc tcp_bic orinoco_cs orinoco hermes pcmcia firmware_class ip_conntrack_ftp ipt_pkttype ipt_REJECT ipt_state ip_conntrack ipt_LOG ipt_limit ipt_u32 iptable_filter ip_tables ip6t_LOG ip6t_limit ip6table_filter ip6_tables thermal processor fan button battery ac i8k ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core intel_agp agpgart floppy
[17179956.804000] CPU:    0
[17179956.804000] EIP:    0060:[<c0307f4c>]    Not tainted VLI
[17179956.804000] EFLAGS: 00010202   (2.6.12-rc6-mm1) 
[17179956.804000] EIP is at tcp_transmit_skb+0x568/0x62b
[17179956.804000] eax: a56b6b6b   ebx: 000004df   ecx: 00000000   edx: c64de048
[17179956.804000] esi: c1ff2b88   edi: 00000001   ebp: c1c29dd4   esp: c1c29da0
[17179956.804000] ds: 007b   es: 007b   ss: 0068
[17179956.804000] Process ssh (pid: 2981, threadinfo=c1c28000 task=c3126a60)
[17179956.804000] Stack: c64de048 c64de080 00000020 00000000 c1ff2b88 c64deb88 c64debc0 c1c29dd4 
[17179956.804000]        c1fc71bc c64deb88 c1ff2b88 c64deb88 c64debc0 c1c29df4 c0308f8c 000005a8 
[17179956.804000]        0001f742 00000001 c64deb88 c1ff2b88 000005a8 c1c29e5c c02ffba8 00000000 
[17179956.804000] Call Trace:
[17179956.804000]  [<c0103586>] show_stack+0x7a/0x83
[17179956.804000]  [<c01036d6>] show_registers+0x130/0x1a1
[17179956.804000]  [<c0103892>] die+0xd0/0x150
[17179956.804000]  [<c0111930>] do_page_fault+0x454/0x5e0
[17179956.804000]  [<c01031f3>] error_code+0x4f/0x54
[17179956.804000]  [<c0308f8c>] tcp_push_one+0xea/0x190
[17179956.804000]  [<c02ffba8>] tcp_sendmsg+0x71f/0x8f6
[17179956.804000]  [<c0319c14>] inet_sendmsg+0x3c/0x49
[17179956.804000]  [<c02de154>] sock_aio_write+0x117/0x124
[17179956.804000]  [<c014e47d>] do_sync_write+0x89/0xb9
[17179956.804000]  [<c014e56b>] vfs_write+0xbe/0x156
[17179956.804000]  [<c014e69e>] sys_write+0x3b/0x60
[17179956.804000]  [<c0102725>] syscall_call+0x7/0xb
[17179956.804000] Code: e0 04 8b 80 50 bb 4f c0 ff 40 2c 8b 8e d8 02 00 00 31 d2 8b 45 cc ff 11 89 c7 85 c0 0f 8e c2 00 00 00 8b 55 cc 8b 82 a4 00 00 00 <0f> b7 58 0a 66 c7 86 1a 03 00 00 00 00 80 be 26 02 00 00 01 0f 
[17179956.804000]

This look familiar to anybody?

(On a related note, how did tcp_bic get loaded? I requested all the new
congestion stuff be built as modules, didn't specifically request any of
them to actually be loaded....


--==_Exmh_1118291011_3588P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCp8RDcC3lWbTT17ARAr0GAKDZ9d3f4vKePmA6jo/wS1nHllRmwwCgx3bv
uMi0pYbHo4FqUDVK90C58kg=
=GQ+6
-----END PGP SIGNATURE-----

--==_Exmh_1118291011_3588P--

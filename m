Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTDYLws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTDYLws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:52:48 -0400
Received: from pointblue.com.pl ([62.89.73.6]:47114 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263879AbTDYLwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:52:43 -0400
Subject: [oups]
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Xander D Harkness <xander@harkness.co.uk>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051272292.980.5.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 13:04:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarded from :Xander D Harkness <xander - harkness.co.uk>
-------------------------------------------------------------------------
I have recently taken over a server in an office running Red Hat 8 with 
JFS on Raid 5 in degraded mode.

I do not want to stick another hard drive in until I do a full back up. 
This is especially required because the software raid has been set up 
incorrectly, using multiple drives on the same ribbon.  The Howto says 
this is a big no no as one failing drive on a ribbon will pull the other
down.

The server dies every couple of weeks and no one knows why.  It seems 
that it may be brought down by programs failing to close.  It died 
yesterday, even after being quite responsive with a load of 400+

Processes that fail to die have included du, java, imapd

I was hoping that someone might have seen this before and know why it is
happening.

This might provide a clue :-)
Apr 25 10:33:58 server kernel:
Apr 25 10:33:58 server kernel: Code: 8b 55 34 8b 45 30 89 d1 31 f9 31 f0
09 c1 0f 84 ab 03 00 00
Apr 25 10:33:59 server kernel:  <1>Unable to handle kernel paging 
request at virtual address 8683d141
Apr 25 10:33:59 server kernel:  printing eip:
Apr 25 10:33:59 server kernel: c01b9d00
Apr 25 10:33:59 server kernel: *pde = 00000000
Apr 25 10:33:59 server kernel: Oops: 0000
Apr 25 10:33:59 server kernel: soundcore autofs 3c59x iptable_filter 
ip_tables ide-scsi ide-cd cdrom st mousedev keybdev hid
input usb-uhci ehci-hcd usbcore raid5 xor raid1 aic7xxx sd_mod s
Apr 25 10:33:59 server kernel: CPU:    0
Apr 25 10:33:59 server kernel: EIP:    0010:[<c01b9d00>]    Not tainted
Apr 25 10:33:59 server kernel: EFLAGS: 00010282
Apr 25 10:33:59 server kernel:
Apr 25 10:33:59 server kernel: EIP is at xfs_next_bit_R501ed594 [] 
0x2b7d0 (2.4.18-26SGI_XFS_1.2.0)
Apr 25 10:33:59 server kernel: eax: e515b720   ebx: c5af409c   ecx: 
e51df7a5   edx: 2018f585
Apr 25 10:33:59 server kernel: esi: 3810a330   edi: 00000000   ebp: 
8683d10d   esp: f4de1da0
Apr 25 10:33:59 server samba(pam_unix)[18010]: session opened for user 
sam by (uid=0)
Apr 25 10:33:59 server kernel: ds: 0018   es: 0018   ss: 0018
Apr 25 10:33:59 server kernel: Process smbd (pid: 18009,
stackpage=f4de1000)
Apr 25 10:33:59 server kernel: Stack: c344f338 00000000 00000000 
00000000 c344f338 f7609c00 3810a330 c015633b
Apr 25 10:33:59 server kernel:        f7609c00 c1e312f0 00000000 
00000000 8683d10d c5af409c c5af4080 3810a330
Apr 25 10:33:59 server kernel:        00000000 c01ba367 c5af4080 
f75ee000 00000000 3810a330 00000000 00000000
Apr 25 10:33:59 server kernel: Call Trace: [<c015633b>] 
iget4_locked_R88152af1 [] 0xdb (0xf4de1dbc))
Apr 25 10:33:59 server kernel: [<c01ba367>] xfs_next_bit_R501ed594 [] 
0x2be37 (0xf4de1de4))
Apr 25 10:33:59 server kernel: [<c01d3167>] xfs_next_bit_R501ed594 [] 
0x44c37 (0xf4de1e24))
Apr 25 10:33:59 server kernel: [<c01d80e5>] xfs_next_bit_R501ed594 [] 
0x49bb5 (0xf4de1e58))
Apr 25 10:33:59 server kernel: [<c01e4abc>] pagebuf_offset_R84ceb85b [] 
0x550c (0xf4de1e88))
Apr 25 10:33:59 server kernel: [<c014aee7>] path_release_R19c7d4fe [] 
0x177 (0xf4de1eb0))
Apr 25 10:33:59 server kernel: [<c014b44f>] follow_down_Reb2b9315 [] 
0x49f (0xf4de1ecc))
Apr 25 10:33:59 server kernel: [<c014ba39>] path_walk_Rc1775230 [] 0x2e9
(0xf4de1f0c))
Apr 25 10:33:59 server kernel: [<c014bcd9>] __user_walk_R26e547e3 [] 
0x49 (0xf4de1f1c))
Apr 25 10:33:59 server kernel: [<c0147dcf>] vfs_stat_Rafb0bdd7 [] 0x1f 
(0xf4de1f38))
Apr 25 10:33:59 server kernel: [<c014844b>] sys_readlink_R4149a0d5 [] 
0x1ab (0xf4de1f70))
Apr 25 10:33:59 server kernel: [<c013f9fe>] sys_close_R268cc6a2 [] 0x4e 
(0xf4de1fb0))
Apr 25 10:33:59 server kernel: [<c010a24e>] show_stack_R680ab6cc [] 
0xdbe (0xf4de1fb8))
Apr 25 10:33:59 server kernel: [<c0109147>] sys_sigaltstack_Rab65536b []
0xf87 (0xf4de1fc0))

--------------------------------------------------------------------------

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs


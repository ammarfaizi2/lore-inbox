Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUJHI6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUJHI6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268177AbUJHI6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:58:43 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:25222 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S268127AbUJHI6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:58:38 -0400
Date: Fri, 8 Oct 2004 10:58:37 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.26: kernel BUG at checkpoint.c:587
Message-ID: <20041008105837.67442205@phoebee>
X-Mailer: Sylpheed-Claws 0.9.12cvs53 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.7-rc2-mm2 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Organization: Technotrend AG
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__8_Oct_2004_10_58_37_+0200_FQRh8+6Gsze3P+C8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__8_Oct_2004_10_58_37_+0200_FQRh8+6Gsze3P+C8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi there!

I got this oops today after an uptime of many days.
On the machine runs a squid and the fs's are ext3.
It also exports some directories over nfs and has some
iptables rules.


Oct  8 10:08:18 router kernel: kernel BUG at checkpoint.c:587!
Oct  8 10:08:18 router kernel: invalid operand: 0000
Oct  8 10:08:18 router kernel: CPU:    0
Oct  8 10:08:18 router kernel: EIP:    0010:[<c015f934>]    Not tainted
Oct  8 10:08:18 router kernel: EFLAGS: 00010286
Oct  8 10:08:18 router kernel: eax: 00000069   ebx: c2d9b9a0   ecx: cfb82000   edx: 00000000
Oct  8 10:08:18 router kernel: esi: cfe76800   edi: c2d9b9a0   ebp: cc2c0a60   esp: cfb83e20
Oct  8 10:08:18 router kernel: ds: 0018   es: 0018   ss: 0018
Oct  8 10:08:18 router kernel: Process kjournald (pid: 56, stackpage=cfb83000)
Oct  8 10:08:18 router kernel: Stack: c02aff60 c02b0161 c02aff41 0000024b c02b0144 cc2c0a60 c015f7e2 cfe76800 
Oct  8 10:08:18 router kernel:        c2d9b9a0 cc90cda0 cc2c0a60 c015f21b cc2c0a60 cc2c0a60 c015f772 cc2c0a60 
Oct  8 10:08:18 router kernel:        cfe76800 cfe76800 cfe76838 c2d9b7a0 00000001 c4d9b5a0 c4d9b5a0 c015dbb3  
Oct  8 10:08:18 router kernel: Call Trace:    [<c015f7e2>] [<c015f21b>] [<c015f772>] [<c015dbb3>] [<c0204059>]
Oct  8 10:08:18 router kernel:   [<c0114f9d>] [<c01603f6>] [<c01602d0>] [<c0106e98>]
Oct  8 10:08:18 router kernel:
Oct  8 10:08:18 router kernel: Code: 0f 0b 4b 02 41 ff 2a c0 83 c4 14 90 83 7b 1c 00 74 2a 68 80

here the resolved syms:

>>EIP; c015f934 <__journal_drop_transaction+60/288>   <=====

Trace; c015f7e2 <__journal_remove_checkpoint+52/6c>
Trace; c015f21b <__try_to_free_cp_buf+1b/3c>
Trace; c015f772 <__journal_clean_checkpoint_list+4e/6c>
Trace; c015dbb3 <journal_commit_transaction+1d3/f07>
Trace; c0204059 <ide_do_rw_disk+31/38>
Trace; c0114f9d <schedule+2d1/2f8>
Trace; c01603f6 <kjournald+116/1cc>
Trace; c01602d0 <commit_timeout+0/c>
Trace; c0106e98 <arch_kernel_thread+28/38>

Code;  c015f934 <__journal_drop_transaction+60/288>
00000000 <_EIP>:
Code;  c015f934 <__journal_drop_transaction+60/288>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015f936 <__journal_drop_transaction+62/288>
   2:   4b                        dec    %ebx
Code;  c015f937 <__journal_drop_transaction+63/288>
   3:   02 41 ff                  add    0xffffffff(%ecx),%al
Code;  c015f93a <__journal_drop_transaction+66/288>
   6:   2a c0                     sub    %al,%al
Code;  c015f93c <__journal_drop_transaction+68/288>
   8:   83 c4 14                  add    $0x14,%esp
Code;  c015f93f <__journal_drop_transaction+6b/288>
   b:   90                        nop    
Code;  c015f940 <__journal_drop_transaction+6c/288>
   c:   83 7b 1c 00               cmpl   $0x0,0x1c(%ebx)
Code;  c015f944 <__journal_drop_transaction+70/288>
  10:   74 2a                     je     3c <_EIP+0x3c>
Code;  c015f946 <__journal_drop_transaction+72/288>
  12:   68 80 00 00 00            push   $0x80


After this oops squid hung in the kernel and was unkillable.
Also a reboot did not work. Had to manually reset the server.

Regards,
Martin

-- 
MyExcuse:
kernel panic: write-only-memory (/dev/wom0) capacity exceeded.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Fri__8_Oct_2004_10_58_37_+0200_FQRh8+6Gsze3P+C8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBZla9mjLYGS7fcG0RApOrAKCF9+1OMDO4rBrQ83sGHa9I2bL1wQCcDJ0T
qtBbQ8f7TE+T4/mvizoAwwU=
=x1cd
-----END PGP SIGNATURE-----

--Signature=_Fri__8_Oct_2004_10_58_37_+0200_FQRh8+6Gsze3P+C8--

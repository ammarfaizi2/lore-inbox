Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVKRGhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVKRGhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 01:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVKRGhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 01:37:37 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:58852 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S932505AbVKRGhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 01:37:35 -0500
Date: Thu, 17 Nov 2005 22:37:34 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: unkillable process dselect 2.6.15-rc1 and 2.6.15-rc1-mm1
Message-ID: <20051118063734.GA1769@the-penguin.otak.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
X-Operating-System: Linux 2.6.15-rc1-mm1 on an i686
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I have a system that has processes that can't be or even zombied. Most
easily triggered by dpkg. but "make clean" in the Linux source seems to
cause it too.

Seems related to SCSI and a root XFS file system. No oops but I did get
a call trace. Not sure if it's generically a SCSI thing or specific to
my card.

lspci says it's a AIC-7892A.

Question comments patches are welcome.

BTW I've put other bugs in the bugzilla not related to this one, and
received what I would characterize as deafening silence. Should I
bother?

Nov 17 22:21:33 guillemot kernel:=20
Nov 17 22:21:33 guillemot kernel:                                          =
      sibling
Nov 17 22:21:33 guillemot kernel:   task             PC      pid father chi=
ld younger older
Nov 17 22:21:33 guillemot kernel: init          S C0137FF3     0     1     =
 0     2               (NOTLB)
Nov 17 22:21:33 guillemot kernel: dffc1ec4 000000d0 dffc1ebc c0137ff3 00000=
001 dffc1ee4 c015e84a dffc1f14=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f9e40 00000000 c14d6b9=
8 c14d6a70 ce512800 003d090d dffc0000=20
Nov 17 22:21:33 guillemot kernel:        24004f00 00000000 dffc1ed8 00003ec=
a 0000000b dffc1ef8 c039a1f9 c01623c3=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: ksoftirqd/0   S DFFC3FC4     0     2     =
 1             3       (L-TLB)
Nov 17 22:21:33 guillemot kernel: dffc3fb8 dffc1f04 00399697 dffc3fc4 00000=
096 dffc1f08 00fc1f80 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 0000000a dffc3f98 c14d667=
8 c14d6550 4ca5ce00 003d08fe dffc2000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dffc2000 dffc1f7=
c 00000000 dffc3fc4 c011ba10 fffffffc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [ksoftirqd+96/176] ksoftirqd+0x60/0xb0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: watchdog/0    S DFFC5F6C     0     3     =
 1             4     2 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dffc5f6c 00000004 dffc5f6c dffc5f6c dffc5=
f40 c0339ba5 0000012b 00000001=20
Nov 17 22:21:33 guillemot kernel:        00000000 8b6fcc00 003d090b c14d615=
8 c14d6030 1db5dd00 003d090e dffc4000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dffc5f80 00003c3=
0 00000000 dffc5fa0 c039a1f9 00000096=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout_interruptible+23/32] s=
chedule_timeout_interruptible+0x17/0x20
Nov 17 22:21:33 guillemot kernel:  [msleep_interruptible+67/96] msleep_inte=
rruptible+0x43/0x60
Nov 17 22:21:33 guillemot kernel:  [watchdog+65/112] watchdog+0x41/0x70
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: events/0      R running     0     4      =
1             5     3 (L-TLB)
Nov 17 22:21:33 guillemot kernel: khelper       S 00000000     0     5     =
 1             6     4 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dffcdf5c 00000000 dbb4be00 00000000 00000=
000 00000000 00000000 0000007b=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000001 00000003 c14cf69=
8 c14cf570 79216e00 003d08ca dffcc000=20
Nov 17 22:21:33 guillemot kernel:        00b71b00 00000000 dffeb528 0000020=
2 dbb4be00 dffcdfc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kthread       S 00000000     0     6     =
 1     8     144     5 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dff97f5c dff96000 00000000 00000000 dff96=
000 df7ffdb8 00000001 00000003=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000001 00000003 c14cf17=
8 c14cf050 6dd90700 003d08c1 dff96000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dffeb628 0000028=
6 df7ffdb0 dff97fc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kblockd/0     S C02C77B2     0     8     =
 6            11       (L-TLB)
Nov 17 22:21:33 guillemot kernel: c1503f5c c02b45df c1503f3c c02c77b2 c1503=
f20 dfc2835c c1503f3c dfcac190=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000001 00000003 c14e16b=
8 c14e1590 fe764400 003d0905 c1502000=20
Nov 17 22:21:33 guillemot kernel:        007a1200 00000000 dffeb968 0000029=
6 dfc2835c c1503fc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: khubd         S 00000005     0    11     =
 6            13     8 (L-TLB)
Nov 17 22:21:33 guillemot kernel: c1509f94 c03bc7fb df4d26b0 00000005 00000=
002 00000000 00000002 c03a8c04=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000002 00000000 dffbe67=
8 dffbe550 cc42f300 003d08c1 c1508000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 c1508000 c150800=
0 c1509fa4 c1509fc4 c024b3bd dffbe678=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [hub_thread+205/256] hub_thread+0xcd/0x1=
00
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kacpid        S DE6083DE     0    13     =
 6           142    11 (L-TLB)
Nov 17 22:21:33 guillemot kernel: c150df5c 84de6184 6084de60 de6083de 83de6=
083 5f83de5f c150df48 dff00f0c=20
Nov 17 22:21:33 guillemot kernel:        00000000 dff00a90 c150df48 dff00bb=
8 dff00a90 a1275a00 003d08ba c150c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 c150c000 dffc1f3=
4 dffebaa0 c150dfc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: pdflush       S 00000000     0   142     =
 6           143    13 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc59f8c dfc59f8c c0139ab5 00000000 00000=
000 dfc59f7c 00000400 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 c154069=
8 c1540570 79eab600 003d090d dfc58000=20
Nov 17 22:21:33 guillemot kernel:        03197500 00000000 dfc59fb8 dfc59fa=
c dfc58000 dfc59fa4 c013a24f 00000297=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [__pdflush+111/336] __pdflush+0x6f/0x150
Nov 17 22:21:33 guillemot kernel:  [pdflush+30/32] pdflush+0x1e/0x20
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: pdflush       S 00000000     0   143     =
 6           145   142 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc5bf8c 00000000 00000000 00000000 00000=
000 00000400 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 c154017=
8 c1540050 1eb35a00 003d08c5 dfc5a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfc5bfb8 dfc5bfa=
c dfc5a000 dfc5bfa4 c013a24f 00000297=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [__pdflush+111/336] __pdflush+0x6f/0x150
Nov 17 22:21:33 guillemot kernel:  [pdflush+30/32] pdflush+0x1e/0x20
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kprefetchd    S 00000000     0   145     =
 6           146   143 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc5ff70 00000000 00000000 00000000 00000=
000 00000000 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 c157c69=
8 c157c570 a389b400 003d08ba dfc5e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfc5e000 dffc1f6=
c 00000000 dfc5ffa4 c039a225 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout_interruptible+23/32] s=
chedule_timeout_interruptible+0x17/0x20
Nov 17 22:21:33 guillemot kernel:  [kprefetchd+170/208] kprefetchd+0xaa/0xd0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: aio/0         S 00000000     0   146     =
 6           147   145 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc61f5c 00000000 00000000 00000000 00000=
000 00000000 dfc61f48 c157c4cc=20
Nov 17 22:21:33 guillemot kernel:        00000000 c157c050 dfc61f48 c157c17=
8 c157c050 a389b400 003d08ba dfc60000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfc60000 dffc1f3=
8 c157ffa0 dfc61fc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: xfslogd/0     S 00000000     0   147     =
 6           148   146 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc63f5c c15584c0 c14e28e0 00000000 dfc63=
f30 c01fe1bf 00000000 00000296=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000001 00000003 dfc1fbd=
8 dfc1fab0 79eab600 003d090d dfc62000=20
Nov 17 22:21:33 guillemot kernel:        00f42400 00000000 c157fa28 0000029=
2 ddf04618 dfc63fc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: xfsdatad/0    S 00000000     0   148     =
 6           149   147 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc65f5c 00000000 00000000 00000000 00000=
000 00000000 dfc65f48 dfc1fa0c=20
Nov 17 22:21:33 guillemot kernel:        00000000 dfc1f590 dfc65f48 dfc1f6b=
8 dfc1f590 a389b400 003d08ba dfc64000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfc64000 dffc1ee=
0 c157f9e0 dfc65fc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kswapd0       S C0120071     0   144     =
 1           969     6 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc5dfa8 00000000 dfc5df64 c0120071 c14d5=
e40 c0121f8b c03f9040 dfc5df7c=20
Nov 17 22:21:33 guillemot kernel:        00000000 dfc5c000 dfc5df84 c157cbb=
8 c157ca90 a389b400 003d08ba dfc5c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 c03f9e9c 0000000=
0 c03f9980 dfc5dfe4 c013d625 c03aff8e=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [kswapd+261/272] kswapd+0x105/0x110
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: xfsbufd       S 00000086     0   149     =
 6           736   148 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc67f68 02200282 ddf4ea60 00000086 df8fe=
800 dfc67f40 dfcac000 dfc2835c=20
Nov 17 22:21:33 guillemot kernel:        00000000 f439bf00 003d090d dfc1f19=
8 dfc1f070 f439bf00 003d090d dfc66000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfc67f7c 00003bb=
3 ddf04bc8 dfc67f9c c039a1f9 dfc2835c=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout_interruptible+23/32] s=
chedule_timeout_interruptible+0x17/0x20
Nov 17 22:21:33 guillemot kernel:  [xfsbufd+76/416] xfsbufd+0x4c/0x1a0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kseriod       S C040BB28     0   736     =
 6           757   149 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfdc1f98 dfdc1f5c c02b5f26 c040bb28 c0408=
840 c040bb3c dfdc1f80 c02b56b4=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03acbfc c03c215a c153269=
8 c1532570 dbce0000 003d08ba dfdc0000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfdc0000 dfdc000=
0 dfdc1fa4 dfdc1fc4 c029fdef c14d6a70=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [serio_thread+191/240] serio_thread+0xbf=
/0xf0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: kpsmoused     S 00000000     0   757     =
 6           780   736 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfc17f5c c14cf570 00000000 00000000 c157b=
4e0 c157b4e8 dfc17f48 c158ba0c=20
Nov 17 22:21:33 guillemot kernel:        00000000 c158b590 dfc17f48 c158b6b=
8 c158b590 c33f6100 003d08ba dfc16000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfc16000 dffc1f4=
0 c1587b20 dfc17fc4 c0125b45 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: scsi_eh_0     S C0399697     0   780     =
 6           818   757 (L-TLB)
Nov 17 22:21:33 guillemot kernel: c1611fb4 00000000 dffc1d78 c0399697 c1611=
fc4 00000096 dff97f2c dffc1d7c=20
Nov 17 22:21:33 guillemot kernel:        00000000 c1611f8c c0113bcb c159b6b=
8 c159b590 d0d66200 003d08ba c1610000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfcac800 c161000=
0 dfcac800 c1611fc4 c02c5e45 fffffffc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [scsi_error_handler+69/176] scsi_error_h=
andler+0x45/0xb0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: scsi_eh_1     S C0399697     0   818     =
 6           865   780 (L-TLB)
Nov 17 22:21:33 guillemot kernel: c151ffb4 00000000 dffc1c88 c0399697 c151f=
fc4 00000096 dff97f2c dffc1c8c=20
Nov 17 22:21:33 guillemot kernel:        00000000 c151ff8c c0113bcb c153217=
8 c1532050 30367100 003d08bf c151e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 c161f400 c151e00=
0 c161f400 c151ffc4 c02c5e45 fffffffc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [scsi_error_handler+69/176] scsi_error_h=
andler+0x45/0xb0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: xfssyncd      S C1558640     0   865     =
 6          1189   818 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfdc7f60 dfdc7f20 c020a849 c1558640 c14e2=
8e0 dfdc7f38 c01fca9a 00007862=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000031 dffe1400 c159b19=
8 c159b070 4aa5fe00 003d090c dfdc6000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfdc7f74 000056b=
6 dfdc7fb0 dfdc7f94 c039a1f9 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout_interruptible+23/32] s=
chedule_timeout_interruptible+0x17/0x20
Nov 17 22:21:33 guillemot kernel:  [xfssyncd+40/384] xfssyncd+0x28/0x180
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: udevd         S C15C0554     0   969     =
 1          1236   144 (NOTLB)
Nov 17 22:21:33 guillemot kernel: dfc13ec4 00000001 c1354760 c15c0554 c1566=
144 dfc13f28 c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 6acb8c00 003d08d9 c159bbd=
8 c159bab0 6b089500 003d08d9 dfc12000=20
Nov 17 22:21:33 guillemot kernel:        1312d000 00000000 dfae4340 0000010=
0 00000008 dfc13ef8 c039a225 dfc13ee4=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: ata/0         S C0113230     0  1189     =
 6          1269   865 (L-TLB)
Nov 17 22:21:33 guillemot kernel: df673f5c df5e26bc df673f1c c0113230 00000=
007 df673f74 df673f48 df5e2a0c=20
Nov 17 22:21:33 guillemot kernel:        00000000 df5e2590 df673f48 df5e26b=
8 df5e2590 60420600 003d08c1 df672000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 df672000 df7fff3=
4 df128420 df673fc4 c0125b45 df73a570=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [worker_thread+485/512] worker_thread+0x=
1e5/0x200
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: khpsbpkt      S C0113107     0  1236     =
 1          1239   969 (L-TLB)
Nov 17 22:21:33 guillemot kernel: df003f94 dff00050 df003f60 c0113107 00000=
000 dff00050 dff00050 d49b2e00=20
Nov 17 22:21:33 guillemot kernel:        00000000 c0113205 c04bd480 df7c0bd=
8 df7c0ab0 d49b2e00 003d08c1 df002000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 e0a1f4a4 0000029=
6 df002000 df003fc4 c039ab93 e0a1f4ac=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [__down_interruptible+115/273] __down_in=
terruptible+0x73/0x111
Nov 17 22:21:33 guillemot kernel:  [__down_failed_interruptible+10/16] __do=
wn_failed_interruptible+0xa/0x10
Nov 17 22:21:33 guillemot kernel:  [pg0+542067079/1068536832] .text.lock.ie=
ee1394_core+0x1b/0x24 [ieee1394]
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: knodemgrd_0   S C018A333     0  1239     =
 1          5196  1236 (L-TLB)
Nov 17 22:21:33 guillemot kernel: dfa9df7c 0000a1ff dfa9df48 c018a333 df28d=
d80 df28dd80 00000000 0000a1ff=20
Nov 17 22:21:33 guillemot kernel:        00000000 c018a39b c0399020 dff0017=
8 dff00050 d49b2e00 003d08c1 dfa9c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 df7d5a50 0000029=
6 dfa9c000 dfa9dfac c039ab93 df7d5a58=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [__down_interruptible+115/273] __down_in=
terruptible+0x73/0x111
Nov 17 22:21:33 guillemot kernel:  [__down_failed_interruptible+10/16] __do=
wn_failed_interruptible+0xa/0x10
Nov 17 22:21:33 guillemot kernel:  [pg0+542093077/1068536832] .text.lock.no=
demgr+0x112/0x1ad [ieee1394]
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: scsi_eh_2     S C0399697     0  1269     =
 6          1270  1189 (L-TLB)
Nov 17 22:21:33 guillemot kernel: df671fb4 df73a570 df7ffd6c c0399697 df671=
fc4 00000096 dff97f2c df7ffdbc=20
Nov 17 22:21:33 guillemot kernel:        00000000 df671f8c c0113bcb df2efb9=
8 df2efa70 6dd90700 003d08c1 df670000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 c1728000 df67000=
0 c1728000 df671fc4 c02c5e45 fffffffc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [scsi_error_handler+69/176] scsi_error_h=
andler+0x45/0xb0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: scsi_eh_3     S C0399697     0  1270     =
 6                1269 (L-TLB)
Nov 17 22:21:33 guillemot kernel: df34bfb4 df73a570 df7ffd6c c0399697 df34b=
fc4 00000096 dff97f2c df7ffdbc=20
Nov 17 22:21:33 guillemot kernel:        00000000 df34bf8c c0113bcb df84b19=
8 df84b070 6dd90700 003d08c1 df34a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 def96000 df34a00=
0 def96000 df34bfc4 c02c5e45 fffffffc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [scsi_error_handler+69/176] scsi_error_h=
andler+0x45/0xb0
Nov 17 22:21:33 guillemot kernel:  [kthread+155/160] kthread+0x9b/0xa0
Nov 17 22:21:33 guillemot kernel:  [kernel_thread_helper+5/24] kernel_threa=
d_helper+0x5/0x18
Nov 17 22:21:33 guillemot kernel: dhclient      S C03F9E40     0  5196     =
 1          5207  1239 (NOTLB)
Nov 17 22:21:33 guillemot kernel: de0cbec4 00000000 00000010 c03f9e40 c13f7=
4a0 de0cbe90 bfbe13d8 000000d0=20
Nov 17 22:21:33 guillemot kernel:        00000000 de0cbf60 00000246 df0e915=
8 df0e9030 ad2d4500 003d090d de0ca000=20
Nov 17 22:21:33 guillemot kernel:        007a1200 00000000 de0cbed8 028e160=
9 00000007 de0cbef8 c039a1f9 de0cbf60=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: portmap       S DFA06D40     0  5207     =
 1          5410  5196 (NOTLB)
Nov 17 22:21:33 guillemot kernel: de711f20 00000246 db5ab000 dfa06d40 de711=
ef4 c01623c3 dfa27398 00000246=20
Nov 17 22:21:33 guillemot kernel:        00000000 df68c6c0 de711f0c de2526b=
8 de252590 b118ef00 003d08c9 de710000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 de711f6=
c de711f68 de711f54 c039a225 c03347df=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_poll+155/192] do_poll+0x9b/0xc0
Nov 17 22:21:33 guillemot kernel:  [sys_poll+251/624] sys_poll+0xfb/0x270
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: syslogd       S C012BC09     0  5410     =
 1          5416  5207 (NOTLB)
Nov 17 22:21:33 guillemot kernel: de0a3ec4 00000001 de0a3ecc c012bc09 00000=
000 c03f93d0 c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f9e40 c1275800 df4a8b9=
8 df4a8a70 3e2e6900 003d0907 de0a2000=20
Nov 17 22:21:33 guillemot kernel:        057bcf00 00000000 df850620 0000000=
2 00000001 de0a3ef8 c039a225 de0a3f60=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: klogd         R running     0  5416      =
1          5502  5410 (NOTLB)
Nov 17 22:21:33 guillemot kernel: acpid         S C03F9E40     0  5502     =
 1          5508  5416 (NOTLB)
Nov 17 22:21:33 guillemot kernel: df695f20 df695ef0 de7996c0 c03f9e40 00000=
000 00000010 c03f9e40 00000246=20
Nov 17 22:21:33 guillemot kernel:        00000000 df749d20 df695f0c df7c06b=
8 df7c0590 1cdcd300 003d08ca df694000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 00000000 df695f6=
c df695f68 df695f54 c039a225 c03347df=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_poll+155/192] do_poll+0x9b/0xc0
Nov 17 22:21:33 guillemot kernel:  [sys_poll+251/624] sys_poll+0xfb/0x270
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: cupsd         S 00000001     0  5508     =
 1          5531  5502 (NOTLB)
Nov 17 22:21:33 guillemot kernel: ddc65ec4 00000001 00000000 00000001 dcb02=
348 ddc65f28 c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f9e40 00000246 df52fbb=
8 df52fa90 9bd37700 003d090a ddc64000=20
Nov 17 22:21:33 guillemot kernel:        0e111300 00000000 ddc65ed8 0000400=
7 00000004 ddc65ef8 c039a1f9 c01623c3=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: dbus-daemon-1 S DF957F74     0  5531     =
 1          5536  5508 (NOTLB)
Nov 17 22:21:33 guillemot kernel: df957f20 c13942a0 dfa0c780 df957f74 00000=
0d0 dfa71a40 df957f9c 00000246=20
Nov 17 22:21:33 guillemot kernel:        00000000 dfa0c780 df957f0c df86469=
8 df864570 785a9100 003d08c9 df956000=20
Nov 17 22:21:33 guillemot kernel:        00b71b00 00000000 00000000 df957f6=
c df957f68 df957f54 c039a225 c03347df=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_poll+155/192] do_poll+0x9b/0xc0
Nov 17 22:21:33 guillemot kernel:  [sys_poll+251/624] sys_poll+0xfb/0x270
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: hald          S C03F9E40     0  5536     =
 1          5628  5531 (NOTLB)
Nov 17 22:21:33 guillemot kernel: de013f20 00000000 00000010 c03f9e40 c12c0=
780 d3f29340 00000296 00000246=20
Nov 17 22:21:33 guillemot kernel:        00000000 dfa0c640 de013f0c df73a69=
8 df73a570 e032cb00 003d090d de012000=20
Nov 17 22:21:33 guillemot kernel:        1443fd00 00000000 de013f34 00003c2=
8 de013f68 de013f54 c039a1f9 c03347df=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_poll+155/192] do_poll+0x9b/0xc0
Nov 17 22:21:33 guillemot kernel:  [sys_poll+251/624] sys_poll+0xfb/0x270
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: exim4         S 00000006     0  5628     =
 1          5674  5536 (NOTLB)
Nov 17 22:21:33 guillemot kernel: df955ec4 00000001 00000001 00000006 df955=
eb4 c02f237a c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f9e40 c137ff00 dff0069=
8 dff00570 84835c00 003d08c9 df954000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 df78d480 0000002=
0 00000005 df955ef8 c039a225 de76e400=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: hddtemp       S 00000000     0  5674     =
 1          5679  5628 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db81bec4 00000001 c016a97e 00000000 dffef=
e20 00000009 c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f9e40 c13a94e0 df5efbd=
8 df5efab0 8ab64600 003d08c9 db81a000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 db81bed8 000cd73=
6 00000001 db81bef8 c039a1f9 de76e800=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: inetd         S C03F9BE0     0  5679     =
 1          5691  5674 (NOTLB)
Nov 17 22:21:33 guillemot kernel: df12bec4 00000001 c13a9518 c03f9be0 00000=
212 df12be8c c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        001e8480 c03f9e40 00000246 df471b9=
8 df471a70 87d9da00 003d08c9 df12a000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 dbccfd40 0000040=
0 0000000a df12bef8 c039a225 dbe60c00=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: sshd          S C03F9BE0     0  5691     =
 1          5702  5679 (NOTLB)
Nov 17 22:21:33 guillemot kernel: ddbcdec4 00000001 c137c6f8 c03f9be0 00200=
212 ddbcde8c c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f9e40 c137c6e0 dffbe15=
8 dffbe030 9570db00 003d08c9 ddbcc000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 dfa71e00 0000001=
0 00000004 ddbcdef8 c039a225 db8136c0=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: xfs           S 00000040     0  5702     =
 1          5766  5691 (NOTLB)
Nov 17 22:21:33 guillemot kernel: ddaafec4 00000001 00001000 00000040 00001=
000 00000000 c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 6acb8c00 003d08d9 df4a867=
8 df4a8550 6acb8c00 003d08d9 ddaae000=20
Nov 17 22:21:33 guillemot kernel:        029f6300 00000000 ddaafed8 000165e=
1 00000004 ddaafef8 c039a1f9 ddaaff60=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: rpc.statd     S C03F9E40     0  5766     =
 1          5786  5702 (NOTLB)
Nov 17 22:21:33 guillemot kernel: dbb4fec4 00000000 00000010 c03f9e40 c136a=
bc0 df73a050 bf907070 000000d0=20
Nov 17 22:21:33 guillemot kernel:        00000000 dbb4ff60 00000246 df73a17=
8 df73a050 b118ef00 003d08c9 dbb4e000=20
Nov 17 22:21:33 guillemot kernel:        007a1200 00000000 dbe298a0 0000008=
0 00000007 dbb4fef8 c039a225 dbe60800=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: atd           S 352AD700     0  5786     =
 1          5789  5766 (NOTLB)
Nov 17 22:21:33 guillemot kernel: de395ed8 00000042 de1f3430 352ad700 00000=
e52 351e7708 00000042 de395f50=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f93cc de395ed0 df26369=
8 df263570 b9342100 003d08c9 de394000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 de395f50 de39400=
0 de395f24 de395ef0 c039a517 de395efc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_ktimer+135/160] schedule_ktime=
r+0x87/0xa0
Nov 17 22:21:33 guillemot kernel:  [schedule_ktimer_interruptible+43/64] sc=
hedule_ktimer_interruptible+0x2b/0x40
Nov 17 22:21:33 guillemot kernel:  [__ktimer_nanosleep+56/192] __ktimer_nan=
osleep+0x38/0xc0
Nov 17 22:21:33 guillemot kernel:  [ktimer_nanosleep+52/64] ktimer_nanoslee=
p+0x34/0x40
Nov 17 22:21:33 guillemot kernel:  [sys_nanosleep+81/96] sys_nanosleep+0x51=
/0x60
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: cron          S 01312D00     0  5789     =
 1          5815  5786 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db81ded8 00000149 df68e0d0 01312d00 00000=
185 00fdd090 00000149 db81df50=20
Nov 17 22:21:33 guillemot kernel:        00000000 c03f93cc db81ded0 df2ef15=
8 df2ef030 c04bd900 003d0906 db81c000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 db81df50 db81c00=
0 db81df24 db81def0 c039a517 db81defc=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_ktimer+135/160] schedule_ktime=
r+0x87/0xa0
Nov 17 22:21:33 guillemot kernel:  [schedule_ktimer_interruptible+43/64] sc=
hedule_ktimer_interruptible+0x2b/0x40
Nov 17 22:21:33 guillemot kernel:  [__ktimer_nanosleep+56/192] __ktimer_nan=
osleep+0x38/0xc0
Nov 17 22:21:33 guillemot kernel:  [ktimer_nanosleep+52/64] ktimer_nanoslee=
p+0x34/0x40
Nov 17 22:21:33 guillemot kernel:  [sys_nanosleep+81/96] sys_nanosleep+0x51=
/0x60
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S DBB4DE8C     0  5815     =
 1  5816    5919  5789 (NOTLB)
Nov 17 22:21:33 guillemot kernel: dbb4dec4 c03f9be0 c1356560 dbb4de8c c0137=
7dc 0000002c c03f9c00 dbb4deb4=20
Nov 17 22:21:33 guillemot kernel:        00000000 88992700 003d08f8 df52f17=
8 df52f050 f439bf00 003d090d dbb4c000=20
Nov 17 22:21:33 guillemot kernel:        007a1200 00000000 dbb4ded8 00003b8=
1 db773640 dbb4def8 c039a1f9 c1356560=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+73/192] schedule_timeo=
ut+0x49/0xc0
Nov 17 22:21:33 guillemot kernel:  [do_select+560/704] do_select+0x230/0x2c0
Nov 17 22:21:33 guillemot kernel:  [sys_select+489/880] sys_select+0x1e9/0x=
370
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 000033CB     0  5816   58=
15          5823       (NOTLB)
Nov 17 22:21:33 guillemot kernel: dbb53e40 dfa39a98 dbb53e08 000033cb dbb53=
e08 c01f4c45 00400000 dbb53e34=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 de1d319=
8 de1d3070 ea515f00 003d08c9 dbb52000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 dd4b1a2=
0 dbb53eac dbb53e74 c039a225 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [wait_for_packet+272/304] wait_for_packe=
t+0x110/0x130
Nov 17 22:21:33 guillemot kernel:  [skb_recv_datagram+95/176] skb_recv_data=
gram+0x5f/0xb0
Nov 17 22:21:33 guillemot kernel:  [unix_accept+105/224] unix_accept+0x69/0=
xe0
Nov 17 22:21:33 guillemot kernel:  [sys_accept+120/272] sys_accept+0x78/0x1=
10
Nov 17 22:21:33 guillemot kernel:  [sys_socketcall+190/608] sys_socketcall+=
0xbe/0x260
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S DB048F3C     0  5823   58=
15          5825  5816 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db229ef0 db229eb0 c0141fd7 db048f3c db048=
f3c db229ec4 c0142016 db041054=20
Nov 17 22:21:33 guillemot kernel:        000f4240 db7f0d64 dbcd2ea0 df263bb=
8 df263a90 eb458300 003d08c9 db228000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 db463e38 db229ef=
8 c015c7f0 db229f14 c015c46c 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
Nov 17 22:21:33 guillemot kernel:  [pipe_readv+447/768] pipe_readv+0x1bf/0x=
300
Nov 17 22:21:33 guillemot kernel:  [pipe_read+31/48] pipe_read+0x1f/0x30
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 685F7061     0  5827   58=
15          5828  5825 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db22bec0 6e5f6564 00706f6f 685f7061 5f6b6=
361 5f727061 616d6e66 00686374=20
Nov 17 22:21:33 guillemot kernel:        00000000 5f6b6361 685f7061 df73abb=
8 df73aa90 eb458300 003d08c9 db22a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db22a000 db22bf0=
8 08131c7c db22bef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00657465     0  5828   58=
15          5829  5827 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db22dec0 6d626473 6c65645f 00657465 685f7=
061 5f6b6361 635f7061 65746e6f=20
Nov 17 22:21:33 guillemot kernel:        00000000 74676e65 69665f68 df2ef67=
8 df2ef550 eb458300 003d08c9 db22c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db22c000 db22df0=
8 08131c7c db22def4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 370E0600     0  5829   58=
15          5830  5828 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db22fec0 00005d8a 0002a201 370e0600 09060=
000 06000013 00000297 00028c06=20
Nov 17 22:21:33 guillemot kernel:        00000000 00005d6b 005daa05 df86417=
8 df864050 eb458300 003d08c9 db22e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db22e000 db22ff0=
8 08131c7c db22fef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 01D90100     0  5832   58=
15          5833  5831 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db235ec0 5501c018 09c8d84b 01d90100 00001=
3f3 000873e2 07dec94b 01d90100=20
Nov 17 22:21:33 guillemot kernel:        00000000 000873f5 874f4a00 de235bb=
8 de235a90 eb458300 003d08c9 db234000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db234000 db235f0=
8 08131c7c db235ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 5B58FFFF     0  5833   58=
15          5834  5832 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db237ec0 0014b2c3 2006e800 5b58ffff 0000c=
3c9 454c4946 4f4f5000 4c46004c=20
Nov 17 22:21:33 guillemot kernel:        00000000 50414548 41525400 df84b6b=
8 df84b590 eb458300 003d08c9 db236000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db236000 db237f0=
8 08131c7c db237ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000000     0  5834   58=
15          5835  5833 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db239ec0 00000000 00000000 00000000 00000=
000 00000000 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 c14e1bd=
8 c14e1ab0 eb458300 003d08c9 db238000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db238000 db239f0=
8 08131c7c db239ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 000A0012     0  5835   58=
15          5836  5834 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db23bec0 00017260 000000b7 000a0012 00000=
4ae 0000e2c0 00000045 000a0012=20
Nov 17 22:21:33 guillemot kernel:        00000000 00018220 00000099 df0e967=
8 df0e9550 eb458300 003d08c9 db23a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db23a000 db23bf0=
8 08131c7c db23bef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 5F74656B     0  5836   58=
15          5837  5835 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db23dec0 7270615f 6375625f 5f74656b 6f6c6=
c61 65645f63 6f727473 63610079=20
Nov 17 22:21:33 guillemot kernel:        00000000 646f6d5f 00656c75 df0e9b9=
8 df0e9a70 eb458300 003d08c9 db23c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db23c000 db23df0=
8 08131c7c db23def4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 79706372     0  5842   58=
15          5843  5841 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db249ec0 65736d65 74730074 79706372 616d7=
500 62006b73 00646e69 7473696c=20
Nov 17 22:21:33 guillemot kernel:        00000000 75657465 75006469 df52f69=
8 df52f570 eb458300 003d08c9 db248000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db248000 db249f0=
8 08131c7c db249ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S BD8B52FF     0  5843   58=
15          5844  5842 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db24bec0 8d52118b ffe75c93 bd8b52ff fffff=
ee0 56308b57 6268036a 8d000002=20
Nov 17 22:21:33 guillemot kernel:        00000000 bde850ff 83ffffef c158bbd=
8 c158bab0 eb458300 003d08c9 db24a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db24a000 db24bf0=
8 08131c7c db24bef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S EA62E8FF     0  5844   58=
15          5845  5843 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db24dec0 8b000001 ffdf5885 ea62e8ff 858bf=
fff ffffdf40 fffa56e9 000bb9ff=20
Nov 17 22:21:33 guillemot kernel:        00000000 ffffed3f df18b58b c158b19=
8 c158b070 eb458300 003d08c9 db24c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db24c000 db24df0=
8 08131c7c db24def4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 75794E06     0  5845   58=
15          5846  5844 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db24fec0 5d005c00 0001d97b 75794e06 01010=
000 000e315d b16a2200 01000025=20
Nov 17 22:21:33 guillemot kernel:        00000000 6b220000 000025b1 df5ef6b=
8 df5ef590 eb458300 003d08c9 db24e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db24e000 db24ff0=
8 08131c7c db24fef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 75C08510     0  5846   58=
15          5847  5845 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db251ec0 f962e850 c483ffff 75c08510 168b5=
138 78858b52 50ffffff 50e4458d=20
Nov 17 22:21:33 guillemot kernel:        00000000 10c483ff 850fc085 de1d3bd=
8 de1d3ab0 eb458300 003d08c9 db250000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db250000 db251f0=
8 08131c7c db251ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000000     0  5852   58=
15          5853  5851 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db25dec0 00000000 00000000 00000000 00000=
000 00000000 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 db7186b=
8 db718590 eb458300 003d08c9 db25c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db25c000 db25df0=
8 08131c7c db25def4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000000     0  5853   58=
15          5854  5852 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db25fec0 00000000 00000000 00000000 00000=
000 00000000 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 db71819=
8 db718070 eb458300 003d08c9 db25e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db25e000 db25ff0=
8 08131c7c db25fef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 0C000849     0  5854   58=
15          5855  5853 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db261ec0 02000000 1f130023 0c000849 13230=
2a4 23020000 09c71304 a50c0000=20
Nov 17 22:21:33 guillemot kernel:        00000000 08230200 034a4413 db765b9=
8 db765a70 eb458300 003d08c9 db260000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db260000 db261f0=
8 08131c7c db261ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 01AD840F     0  5855   58=
15          5856  5854 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db263ec0 dc4589c0 213c068a 01ad840f 5e3c0=
000 01a5840f f2890000 00e445c7=20
Nov 17 22:21:33 guillemot kernel:        00000000 dc458ac0 8902e0c1 db76567=
8 db765550 eb458300 003d08c9 db262000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db262000 db263f0=
8 08131c7c db263ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S FD3885C7     0  5856   58=
15          5857  5855 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db265ec0 b589ffff fffffd04 fd3885c7 0001f=
fff 85c60000 fffffd16 1785c620=20
Nov 17 22:21:33 guillemot kernel:        00000000 ffeadce9 04468dff db76515=
8 db765030 eb458300 003d08c9 db264000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db264000 db265f0=
8 08131c7c db265ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S FFFFF530     0  5862   58=
15          5863  5861 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db271ec0 58680000 e9000005 fffff530 02bca=
3ff 60680000 e9000005 fffff520=20
Nov 17 22:21:33 guillemot kernel:        00000000 68680000 e9000005 db77019=
8 db770070 eb458300 003d08c9 db270000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db270000 db271f0=
8 08131c7c db271ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 1779C085     0  5863   58=
15          5864  5862 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db273ec0 89ffff82 10c483c6 1779c085 ff7a3=
be8 83008bff d87404f8 8d087546=20
Nov 17 22:21:33 guillemot kernel:        00000000 31c35d5f f4658dc0 db210b9=
8 db210a70 eb458300 003d08c9 db272000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db272000 db273f0=
8 08131c7c db273ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 09000023     0  5864   58=
15          5865  5863 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db275ec0 fb8e4d00 02000000 09000023 00000=
a79 70b88f4d 53020000 e0000071=20
Nov 17 22:21:33 guillemot kernel:        00000000 9004ac4d 4d000017 db21067=
8 db210550 eb458300 003d08c9 db274000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db274000 db275f0=
8 08131c7c db275ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 660B0000     0  5865   58=
15          5866  5864 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db277ec0 7f9f3100 72b70000 660b0000 76320=
301 9f650b00 0000007f 16ad0408=20
Nov 17 22:21:33 guillemot kernel:        00000000 0500007f 0500090e db21015=
8 db210030 eb458300 003d08c9 db276000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db276000 db277f0=
8 08131c7c db277ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 0B00000D     0  5866   58=
15          5867  5865 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db279ec0 02000016 a2155423 0b00000d 013d0=
1df 23020000 0eab155c e00b0000=20
Nov 17 22:21:33 guillemot kernel:        00000000 60230200 0325b115 db21bbb=
8 db21ba90 eb458300 003d08c9 db278000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db278000 db279f0=
8 08131c7c db279ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 27BC8D00     0  5872   58=
15          5873  5871 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2c5ec0 b48dc35d 00000026 27bc8d00 00000=
000 8534468b 52d175c0 468b006a=20
Nov 17 22:21:33 guillemot kernel:        00000000 d9e85034 83fffd56 db287b9=
8 db287a70 eb828c00 003d08c9 db2c4000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2c4000 db2c5f0=
8 08131c7c db2c5ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 27BC8DF6     0  5873   58=
15          5874  5872 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2c7ec0 5e5bf465 89c35d5f 27bc8df6 00000=
000 8d08ec83 8b501045 e8562077=20
Nov 17 22:21:33 guillemot kernel:        00000000 c483c689 0fc08510 db28767=
8 db287550 eb828c00 003d08c9 db2c6000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2c6000 db2c7f0=
8 08131c7c db2c7ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 94041023     0  5874   58=
15          5875  5873 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2c9e2c 00000001 02000001 94041023 2c000=
005 00012a39 c03f9e40 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 c0333be0 00000009 db28715=
8 db287030 eb828c00 003d08c9 db2c8000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db813240 0000000=
0 7fffffff db2c9e60 c039a225 c014dac4=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [inet_csk_wait_for_connect+209/288] inet=
_csk_wait_for_connect+0xd1/0x120
Nov 17 22:21:33 guillemot kernel:  [inet_csk_accept+171/384] inet_csk_accep=
t+0xab/0x180
Nov 17 22:21:33 guillemot kernel:  [inet_accept+31/160] inet_accept+0x1f/0x=
a0
Nov 17 22:21:33 guillemot kernel:  [sys_accept+120/272] sys_accept+0x78/0x1=
10
Nov 17 22:21:33 guillemot kernel:  [sys_socketcall+190/608] sys_socketcall+=
0xbe/0x260
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S DB004C24     0  5825   58=
15          5827  5823 (NOTLB)
Nov 17 22:21:33 guillemot kernel: dbb51ef0 dbb51eb0 c0141fd7 db004c24 db004=
c24 dbb51ec4 c0142016 db041054=20
Nov 17 22:21:33 guillemot kernel:        00000000 db7f0d64 dbcd2ea0 c1540bb=
8 c1540a90 eb458300 003d08c9 dbb50000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db463e38 dbb51ef=
8 c015c7f0 dbb51f14 c015c46c 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [pipe_wait+108/144] pipe_wait+0x6c/0x90
Nov 17 22:21:33 guillemot kernel:  [pipe_readv+447/768] pipe_readv+0x1bf/0x=
300
Nov 17 22:21:33 guillemot kernel:  [pipe_read+31/48] pipe_read+0x1f/0x30
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 16170000     0  5830   58=
15          5831  5829 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db231ec0 23020000 0bc20300 16170000 00004=
6c4 03042302 0008d034 46c41717=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 dffbeb9=
8 dffbea70 eb458300 003d08c9 db230000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db230000 db231f0=
8 08131c7c db231ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000000     0  5831   58=
15          5832  5830 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db233ec0 00000000 00000000 00000000 00000=
000 db233e80 db233e80 db233e88=20
Nov 17 22:21:33 guillemot kernel:        00000000 db233e90 db233e90 de23517=
8 de235050 eb458300 003d08c9 db232000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db232000 db233f0=
8 08131c7c db233ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S B90F0000     0  5837   58=
15          5838  5836 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db23fec0 00000002 6666040b b90f0000 01000=
066 00001d78 003e8009 66b90900=20
Nov 17 22:21:33 guillemot kernel:        00000000 09000000 00000071 df47167=
8 df471550 eb458300 003d08c9 db23e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db23e000 db23ff0=
8 08131c7c db23fef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 006A50D4     0  5838   58=
15          5839  5837 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db241ec0 70336808 458b0809 006a50d4 a4680=
46a 68000002 08096a10 011513e8=20
Nov 17 22:21:33 guillemot kernel:        00000000 fff9cfe9 08ec83ff df47115=
8 df471030 eb458300 003d08c9 db240000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db240000 db241f0=
8 08131c7c db241ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S C4833043     0  5839   58=
15          5840  5838 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db243ec0 69e85750 89ffff38 c4833043 0c558=
b0c 5038428b 51384e8b 3852e857=20
Nov 17 22:21:33 guillemot kernel:        00000000 0cc48338 8b0c458b c1532bb=
8 c1532a90 eb458300 003d08c9 db242000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db242000 db243f0=
8 08131c7c db243ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 23020000     0  5840   58=
15          5841  5839 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db245ec0 0009cf2f 1c905e15 23020000 44140=
b14 5f150006 0000338b 0b182302=20
Nov 17 22:21:33 guillemot kernel:        00000000 148c6115 23020000 de252bd=
8 de252ab0 eb458300 003d08c9 db244000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db244000 db245f0=
8 08131c7c db245ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 0006451A     0  5841   58=
15          5842  5840 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db247ec0 00003bda 00082302 0006451a 04070=
100 00003bd4 0322a606 f72d2000=20
Nov 17 22:21:33 guillemot kernel:        00000000 000009a0 018c2e20 de25219=
8 de252070 eb458300 003d08c9 db246000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db246000 db247f0=
8 08131c7c db247ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 02000023     0  5847   58=
15          5848  5846 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db253ec0 00869f04 bcf22200 02000023 a4040=
c23 22000003 0024b7f5 48230200=20
Nov 17 22:21:33 guillemot kernel:        00000000 8ff62200 03000025 c14e119=
8 c14e1070 eb458300 003d08c9 db252000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db252000 db253f0=
8 08131c7c db253ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 0000003B     0  5848   58=
15          5849  5847 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db255ec0 8afc0d00 0e4e0001 0000003b 0d002=
302 00003df3 003b0f4e 23020000=20
Nov 17 22:21:33 guillemot kernel:        00000000 104e0005 000087c0 db6b7bb=
8 db6b7a90 eb458300 003d08c9 db254000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db254000 db255f0=
8 08131c7c db255ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 0000A773     0  5849   58=
15          5850  5848 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db257ec0 d4040700 080000a6 0000a773 0000a=
6d4 00002109 3d000800 00001a0c=20
Nov 17 22:21:33 guillemot kernel:        00000000 54010000 029c273d db6b769=
8 db6b7570 eb458300 003d08c9 db256000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db256000 db257f0=
8 08131c7c db257ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S B68DC675     0  5850   58=
15          5851  5849 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db259ec0 00000008 a6f3de89 b68dc675 00000=
000 5bf4658d c35d5f5e 26b48d90=20
Nov 17 22:21:33 guillemot kernel:        00000000 85e4458b 83e974c0 db6b717=
8 db6b7050 eb458300 003d08c9 db258000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db258000 db259f0=
8 08131c7c db259ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000000     0  5851   58=
15          5852  5850 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db25bec0 00000000 00000000 00000000 00000=
000 00000000 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 db718bd=
8 db718ab0 eb458300 003d08c9 db25a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db25a000 db25bf0=
8 08131c7c db25bef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 27BC8D00     0  5857   58=
15          5858  5856 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db267ec0 00000000 768dc35d 27bc8d00 00000=
000 57e58955 ec835356 0000e81c=20
Nov 17 22:21:33 guillemot kernel:        00000000 01265ec3 0c7d8b00 db779bb=
8 db779a90 eb458300 003d08c9 db266000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db266000 db267f0=
8 08131c7c db267ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000000     0  5858   58=
15          5859  5857 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db269ec0 e0b64d30 00000000 00000000 00000=
000 00000000 00000000 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 db77969=
8 db779570 eb458300 003d08c9 db268000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db268000 db269f0=
8 08131c7c db269ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 72616E69     0  5859   58=
15          5860  5858 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db26bec0 6f636e65 625f6564 72616e69 70610=
079 6361685f 70615f6b 61685f72=20
Nov 17 22:21:33 guillemot kernel:        00000000 00747865 685f7061 db77917=
8 db779050 eb458300 003d08c9 db26a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db26a000 db26bf0=
8 08131c7c db26bef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 645F656C     0  5860   58=
15          5861  5859 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db26dec0 72706100 6261745f 645f656c 70610=
06f 61745f72 5f656c62 706d6f63=20
Nov 17 22:21:33 guillemot kernel:        00000000 72747300 00797063 db770bd=
8 db770ab0 eb458300 003d08c9 db26c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db26c000 db26df0=
8 08131c7c db26def4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 72706100     0  5861   58=
15          5862  5860 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db26fec0 6d5f7465 78657475 72706100 6c6c6=
15f 7461636f 735f726f 6d5f7465=20
Nov 17 22:21:33 guillemot kernel:        00000000 72706100 6c6c615f db7706b=
8 db770590 eb458300 003d08c9 db26e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db26e000 db26ff0=
8 08131c7c db26fef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 004A778D     0  5867   58=
15          5868  5866 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db27bec0 de0d0010 2e00000f 004a778d 4b600=
800 04680000 2e440000 16c30a8f=20
Nov 17 22:21:33 guillemot kernel:        00000000 000000e6 0a002302 db21b69=
8 db21b570 eb458300 003d08c9 db27a000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db27a000 db27bf0=
8 08131c7c db27bef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 23020000     0  5868   58=
15          5869  5867 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db27dec0 0700000f 1c470273 23020000 72531=
20c 74070001 004cc202 10230200=20
Nov 17 22:21:33 guillemot kernel:        00000000 02750700 00001360 db21b17=
8 db21b050 eb458300 003d08c9 db27c000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db27c000 db27df0=
8 08131c7c db27def4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 00000267     0  5869   58=
15          5870  5868 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db27fec0 0000067c 00000000 00000267 00000=
657 00000801 000003fe 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 000006d1 00000000 db225bd=
8 db225ab0 eb458300 003d08c9 db27e000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db27e000 db27ff0=
8 08131c7c db27fef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S FC458914     0  5870   58=
15          5871  5869 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2c1ec0 83e58955 458d24ec fc458914 104d8=
b50 08558b51 5dd06852 458b0808=20
Nov 17 22:21:33 guillemot kernel:        00000000 c9fffda0 909090c3 db2256b=
8 db225590 eb458300 003d08c9 db2c0000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2c0000 db2c1f0=
8 08131c7c db2c1ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 1300054C     0  5871   58=
15          5872  5870 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2c3ec0 08000010 870b2613 1300054c 00003=
327 00230200 00869f0b 82281300=20
Nov 17 22:21:33 guillemot kernel:        00000000 0c000423 00006148 db22519=
8 db225070 eb458300 003d08c9 db2c2000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2c2000 db2c3f0=
8 08131c7c db2c3ef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S BC230300     0  5875   58=
15          5876  5874 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2cbec0 63200000 001f2603 bc230300 bf5c1=
209 64200006 003b7203 c0230300=20
Nov 17 22:21:33 guillemot kernel:        00000000 66200004 003b7e03 db292bb=
8 db292a90 eb828c00 003d08c9 db2ca000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2ca000 db2cbf0=
8 08131c7c db2cbef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 011C5300     0  5876   58=
15          5877  5875 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2cdec0 0000007c 00e0ae18 011c5300 00008=
2bc 0082c808 d8090100 0000007e=20
Nov 17 22:21:33 guillemot kernel:        00000000 011d5300 000082d4 db29269=
8 db292570 eb828c00 003d08c9 db2cc000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2cc000 db2cdf0=
8 08131c7c db2cdef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 0B3C1234     0  5877   58=
15          5878  5876 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2cfec0 026402ca 23020000 0b3c1234 cc210=
000 00599402 3c230200 001fab12=20
Nov 17 22:21:33 guillemot kernel:        00000000 0000009a 12402302 db29217=
8 db292050 eb828c00 003d08c9 db2ce000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db2ce000 db2cff0=
8 08131c7c db2cfef4 c039a225 c012c833=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [futex_wait+406/464] futex_wait+0x196/0x=
1d0
Nov 17 22:21:33 guillemot kernel:  [do_futex+84/160] do_futex+0x54/0xa0
Nov 17 22:21:33 guillemot kernel:  [sys_futex+82/288] sys_futex+0x52/0x120
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: apache2       S 8DF88900     0  5878   58=
15                5877 (NOTLB)
Nov 17 22:21:33 guillemot kernel: db2d1e2c ffffff2f 00000cbf 8df88900 5e5bf=
465 e8c35d5f fffedac8 14e9388b=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000016 ffff0ae9 db29cbd=
8 db29cab0 eb828c00 003d08c9 db2d0000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 db813240 0000000=
0 7fffffff db2d1e60 c039a225 c1366260=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [inet_csk_wait_for_connect+209/288] inet=
_csk_wait_for_connect+0xd1/0x120
Nov 17 22:21:33 guillemot kernel:  [inet_csk_accept+171/384] inet_csk_accep=
t+0xab/0x180
Nov 17 22:21:33 guillemot kernel:  [inet_accept+31/160] inet_accept+0x1f/0x=
a0
Nov 17 22:21:33 guillemot kernel:  [sys_accept+120/272] sys_accept+0x78/0x1=
10
Nov 17 22:21:33 guillemot kernel:  [sys_socketcall+190/608] sys_socketcall+=
0xbe/0x260
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: login         S 00000000     0  5919     =
 1  6037    5920  5815 (NOTLB)
Nov 17 22:21:33 guillemot kernel: daf2bf54 4ac31700 c13a3880 00000000 c13a3=
880 daf2bf20 c01338c8 00000001=20
Nov 17 22:21:33 guillemot kernel:        00000000 4ac31700 003d08cc dae05b9=
8 dae05a70 4b002000 003d08cc daf2a000=20
Nov 17 22:21:33 guillemot kernel:        007a1200 00000000 dae05b1c 0000000=
1 00000004 daf2bfa4 c0119f71 c17326a4=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [do_wait+593/912] do_wait+0x251/0x390
Nov 17 22:21:33 guillemot kernel:  [sys_wait4+50/64] sys_wait4+0x32/0x40
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: login         S 00000000     0  5920     =
 1  6082    5921  5919 (NOTLB)
Nov 17 22:21:33 guillemot kernel: daf27f54 bf989cc4 c13f32c0 00000000 c13f3=
2c0 daf27f20 c01338c8 00000001=20
Nov 17 22:21:33 guillemot kernel:        00000000 0eed7900 003d08ef df5e2bd=
8 df5e2ab0 101ea600 003d08ef daf26000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 df5e2b5c 0000000=
1 00000004 daf27fa4 c0119f71 db2a1f94=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [do_wait+593/912] do_wait+0x251/0x390
Nov 17 22:21:33 guillemot kernel:  [sys_wait4+50/64] sys_wait4+0x32/0x40
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: getty         S C03F9BE0     0  5921     =
 1          5922  5920 (NOTLB)
Nov 17 22:21:33 guillemot kernel: daee1ebc 00000246 00000000 c03f9be0 c1354=
458 c03f9be0 00000286 00000020=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000020 daee1eec dae0567=
8 dae05550 4eee3500 003d08ca daee0000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 dae8600=
0 daea6000 daee1ef0 c039a225 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [read_chan+792/1312] read_chan+0x318/0x5=
20
Nov 17 22:21:33 guillemot kernel:  [tty_read+126/176] tty_read+0x7e/0xb0
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: getty         S C03F9BE0     0  5922     =
 1          5923  5921 (NOTLB)
Nov 17 22:21:33 guillemot kernel: daeddebc 00000246 00000000 c03f9be0 c1354=
458 c03f9be0 00000286 00000020=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000020 daeddeec db29c19=
8 db29c070 4eee3500 003d08ca daedc000=20
Nov 17 22:21:33 guillemot kernel:        003d0900 00000000 00000000 dda0580=
0 dacc5000 daeddef0 c039a225 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [read_chan+792/1312] read_chan+0x318/0x5=
20
Nov 17 22:21:33 guillemot kernel:  [tty_read+126/176] tty_read+0x7e/0xb0
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: getty         S C03F9BE0     0  5923     =
 1          5924  5922 (NOTLB)
Nov 17 22:21:33 guillemot kernel: daf33ebc 00000246 00000000 c03f9be0 c1354=
458 c03f9be0 00000286 00000020=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000020 daf33eec c16cdbd=
8 c16cdab0 4eee3500 003d08ca daf32000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 dd5c800=
0 daef8000 daf33ef0 c039a225 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [read_chan+792/1312] read_chan+0x318/0x5=
20
Nov 17 22:21:33 guillemot kernel:  [tty_read+126/176] tty_read+0x7e/0xb0
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: getty         S C03F9BE0     0  5924     =
 1                5923 (NOTLB)
Nov 17 22:21:33 guillemot kernel: daf35ebc 00000246 00000000 c03f9be0 c1354=
458 c03f9be0 00000286 00000020=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000020 daf35eec c16cd6b=
8 c16cd590 4eee3500 003d08ca daf34000=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000000 00000000 dae8680=
0 daec2000 daf35ef0 c039a225 00000000=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [read_chan+792/1312] read_chan+0x318/0x5=
20
Nov 17 22:21:33 guillemot kernel:  [tty_read+126/176] tty_read+0x7e/0xb0
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: bash          S C03F9BE0     0  6037   59=
19  6072               (NOTLB)
Nov 17 22:21:33 guillemot kernel: daf45f3c 7ad8a700 c131c4e0 c03f9be0 c03f9=
e68 00000000 00000010 c03f9e68=20
Nov 17 22:21:33 guillemot kernel:        00000000 00000002 daf45f1c df26317=
8 df263050 7ad8a700 003d08e2 daf44000=20
Nov 17 22:21:33 guillemot kernel:        00f42400 00000000 df2630fc 0000000=
1 0000000e daf45f8c c0119f71 bfe704e8=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [do_wait+593/912] do_wait+0x251/0x390
Nov 17 22:21:33 guillemot kernel:  [sys_wait4+50/64] sys_wait4+0x32/0x40
Nov 17 22:21:33 guillemot kernel:  [sys_waitpid+39/41] sys_waitpid+0x27/0x29
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: dpkg          D D3F8ADAC     0  6072   60=
37                     (NOTLB)
Nov 17 22:21:33 guillemot kernel: daf37e04 d3f88260 00000296 d3f8adac dffe1=
400 daf37dd4 c020a689 00000000=20
Nov 17 22:21:33 guillemot kernel:        00000000 daf37de0 c01f35c6 df5e219=
8 df5e2070 03680900 003d08e6 daf36000=20
Nov 17 22:21:33 guillemot kernel:        5ee3fe00 00000000 0006d868 c14e28e=
0 dfcb9048 daf37e38 c039a225 c020a548=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [xlog_grant_log_space+437/640] xlog_gran=
t_log_space+0x1b5/0x280
Nov 17 22:21:33 guillemot kernel:  [xfs_log_reserve+156/176] xfs_log_reserv=
e+0x9c/0xb0
Nov 17 22:21:33 guillemot kernel:  [xfs_trans_reserve+147/480] xfs_trans_re=
serve+0x93/0x1e0
Nov 17 22:21:33 guillemot kernel:  [xfs_inactive_symlink_local+60/144] xfs_=
inactive_symlink_local+0x3c/0x90
Nov 17 22:21:33 guillemot kernel:  [xfs_inactive+899/1264] xfs_inactive+0x3=
83/0x4f0
Nov 17 22:21:33 guillemot kernel:  [linvfs_clear_inode+56/112] linvfs_clear=
_inode+0x38/0x70
Nov 17 22:21:33 guillemot kernel:  [clear_inode+173/272] clear_inode+0xad/0=
x110
Nov 17 22:21:33 guillemot kernel:  [generic_delete_inode+230/256] generic_d=
elete_inode+0xe6/0x100
Nov 17 22:21:33 guillemot kernel:  [generic_drop_inode+15/32] generic_drop_=
inode+0xf/0x20
Nov 17 22:21:33 guillemot kernel:  [iput+95/112] iput+0x5f/0x70
Nov 17 22:21:33 guillemot kernel:  [sys_unlink+225/272] sys_unlink+0xe1/0x1=
10
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 17 22:21:33 guillemot kernel: bash          S 00000001     0  6082   59=
20                     (NOTLB)
Nov 17 22:21:33 guillemot kernel: d40c5ebc c03a1fc0 c025c9f2 00000001 00000=
000 00000007 00000000 00000001=20
Nov 17 22:21:33 guillemot kernel:        00000000 df130800 de2ec000 de1d36b=
8 de1d3590 a7376400 003d090d d40c4000=20
Nov 17 22:21:33 guillemot kernel:        01312d00 00000000 00000000 db34280=
0 daec6000 d40c5ef0 c039a225 de2ec008=20
Nov 17 22:21:33 guillemot kernel: Call Trace:
Nov 17 22:21:33 guillemot kernel:  [schedule_timeout+117/192] schedule_time=
out+0x75/0xc0
Nov 17 22:21:33 guillemot kernel:  [read_chan+792/1312] read_chan+0x318/0x5=
20
Nov 17 22:21:33 guillemot kernel:  [tty_read+126/176] tty_read+0x7e/0xb0
Nov 17 22:21:33 guillemot kernel:  [vfs_read+147/336] vfs_read+0x93/0x150
Nov 17 22:21:33 guillemot kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Nov 17 22:21:33 guillemot kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDfXausgPkFxgrWYkRAkPmAJ49swHUnaCr50dNjmQoFhm653YYtgCaAiL3
Q+B7RmWgL0JqzbICsHqDvQg=
=/Alj
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

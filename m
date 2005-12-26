Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVLZVZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLZVZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 16:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLZVZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 16:25:20 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:52953 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750775AbVLZVZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 16:25:18 -0500
Date: Mon, 26 Dec 2005 22:23:39 +0100
From: Jules Villard <jvillard@ens-lyon.fr>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051226212339.GA9837@blatterie>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261201360.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512261201360.14098@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le lun, 26 d=E9c 2005 12:04:54 -0800, Linus Torvalds a =E9crit :
>=20
>=20
> On Mon, 26 Dec 2005, Jules Villard wrote:
> >=20
> > Resuming from a suspend on my ThinkPad T42 is broken in both -rc6 and
> > -rc7 releases. When X is not launched, everything goes fine, but when
> > resuming a running X, X looks frozen. I can ssh to my box and the
> > sysrq keys are still working, but I'm unable to kill the X process.
> > If I suspend from a vt (but still with a X running), the resume goes
> > fine until I switch back from the vt to X.
>=20
> Since you have sysrq working, can you do SysRQ-T and send us the output?=
=20
> With CONFIG_KALLSYMS (which is on by default unless you do something=20
> really strange).
>=20
> At least that should tell _where_ X is frozen, assuming it is frozen in=
=20
> the kernel (which is not necessarily a safe assumption, of course).

Attached.

Investigating a bit further, I found out that resume is quite innocent
about all this: what hangs X is switching from a vt to X. Moreover, When I
launch X only by typing "X" in a vt, switching back and forth makes
the box hang hard (ie no sysrq), so I had to do a startx to see a call
trace with sysrq-t (I know, it may sound like black art).

Regards,

Jules

PS: Sorry for messing up with the lkml's email...

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=syslog_sysrq_t_rc7_startx_frozen
Content-Transfer-Encoding: quoted-printable

Dec 26 22:01:47 blatterie kernel: [  413.081330] eth0: NETDEV_TX_BUSY retur=
ned; driver should report queue full via ieee_device->is_queue_full.
Dec 26 22:06:49 blatterie kernel: [  591.905822] mtrr: 0xe0000000,0x8000000=
 overlaps existing 0xe0000000,0x2000000
Dec 26 22:07:54 blatterie kernel: [  260.677255]        0003da23 00000007 d=
6e8fedc c0354cc4 d6e8feb4 0003da23 d690d9c0 c0457440=20
Dec 26 22:07:54 blatterie kernel: [  260.677260] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677262]  [<c0354cc4>] schedule_tim=
eout+0x50/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677265]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677268]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677271]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677274] fetchmail     S 00000000  =
   0  3133      1          3203  3129 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677280] d6d2dea0 d6f8bad0 c04513e0=
 00000000 0000003a 003eb38b 00000000 00000008=20
Dec 26 22:07:54 blatterie kernel: [  260.677284]        00000000 d765ea90 0=
00016eb 96da0d99 00000037 d6f8bad0 d6f8bbf8 d6d2deb4=20
Dec 26 22:07:54 blatterie kernel: [  260.677290]        000279c4 00000000 d=
6d2dedc c0354cc4 d6d2deb4 000279c4 bfc25e4c c0457410=20
Dec 26 22:07:54 blatterie kernel: [  260.677295] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677297]  [<c0354cc4>] schedule_tim=
eout+0x50/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677301]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677304]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677307]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677310] startx        S 00000044  =
   0  3141   2902  3153               (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677315] d7ff1f08 df65b5a0 c04513e0=
 00000044 00022431 c12c6760 00000010 c03b6908=20
Dec 26 22:07:54 blatterie kernel: [  260.677320]        00000216 d7ff1ef4 0=
0013b9c 0c4960a1 00000089 df65b5a0 df65b6c8 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677326]        df65b5a0 df65b64c d=
7ff1f80 c011d56d ffffffff 00000004 df65ba90 d7ff1f54=20
Dec 26 22:07:54 blatterie kernel: [  260.677332] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677333]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677338]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677341]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.677345]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677348] xinit         S D73ADF78  =
   0  3153   3141  3154               (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677353] d73adf20 df65ba90 c04513e0=
 d73adf78 d73adf08 d73adf40 c0354707 00000000=20
Dec 26 22:07:54 blatterie kernel: [  260.677358]        df65ba90 d765e0b0 0=
00007d4 3216c2c3 0000008a df65ba90 df65bbb8 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677364]        df65ba90 df65bb3c d=
73adf98 c011d56d ffffffff 00000004 d765e0b0 d765e0b0=20
Dec 26 22:07:54 blatterie kernel: [  260.677370] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677371]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677375]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677378]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677381] X             R running   =
  0  3154   3153          3185       (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677386] wmii          S 0247A7C0  =
   0  3185   3153  3197          3154 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677391] d6c6bf08 d765e0b0 c04513e0=
 0247a7c0 0000f058 00000000 c128ffe0 00000000=20
Dec 26 22:07:54 blatterie kernel: [  260.677396]        c128ffe0 d765ea90 0=
0000bea 160cfd73 0000003c d765e0b0 d765e1d8 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677402]        d765e0b0 d765e15c d=
6c6bf80 c011d56d ffffffff 00000004 d765e5a0 d6c6bf54=20
Dec 26 22:07:54 blatterie kernel: [  260.677407] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677409]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677412]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677416]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.677419]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677422] wmiiwm        S 0000006A  =
   0  3197   3185          9683       (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677428] d6b19ea0 df6dd0f0 c0451888=
 0000006a 00000020 44a47642 0000006a 00000000=20
Dec 26 22:07:54 blatterie kernel: [  260.677432]        00000000 df6dd0f0 0=
0000716 42aaf69a 00000055 df6dd5e0 df6dd708 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677438]        00000000 00000004 d=
6b19edc c0354d10 d6b19ec4 c03513fb d5b4c180 d69eeb58=20
Dec 26 22:07:54 blatterie kernel: [  260.677444] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677445]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677449]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677452]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677455]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677458] wmifs         S 00000044  =
   0  3203      1          3204  3133 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677464] d6b17ea0 d6c60520 c04513e0=
 00000044 00000012 c127a440 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.677469]        00000000 d765ea90 0=
00016c3 5572d111 0000006a d6c60520 d6c60648 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677474]        00000000 00000008 d=
6b17edc c0354d10 d6b17ec4 c03513fb d6e53b00 d423bcd8=20
Dec 26 22:07:54 blatterie kernel: [  260.677480] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677481]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677485]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677488]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677491]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677494] wmikeys       S 0000006A  =
   0  3204      1          3205  3203 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677500] d728dea0 d765ea90 c0451888=
 0000006a 00000020 4301e7f8 0000006a 00000ea9=20
Dec 26 22:07:54 blatterie kernel: [  260.677504]        00000000 d765ea90 0=
0000c4d 43020ab2 0000006a df6ddad0 df6ddbf8 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677510]        00000000 00000006 d=
728dedc c0354d10 d728dec4 c03513fb d43b9e00 d423b558=20
Dec 26 22:07:54 blatterie kernel: [  260.677515] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677517]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677521]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677524]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677527]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677530] wmibar        S 0000006A  =
   0  3205      1          3206  3204 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677535] d6b2fea0 d3ceb030 c0451888=
 0000006a 00000020 557278f7 0000006a 00000000=20
Dec 26 22:07:54 blatterie kernel: [  260.677540]        00000000 d3ceb030 0=
0000fa4 42ab73c1 00000055 df6dd0f0 df6dd218 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677546]        00000000 00000004 d=
6b2fedc c0354d10 d6b2fec4 c03513fb d72f99c0 d42b0c98=20
Dec 26 22:07:54 blatterie kernel: [  260.677552] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677553]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677557]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677560]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677563]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677566] wmimenu       S 0000008A  =
   0  3206      1          3420  3205 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677571] d54c9ea0 d6c60030 c04513e0=
 0000008a 0000000c c22ed06c 0000008a 00001789=20
Dec 26 22:07:54 blatterie kernel: [  260.677576]        00000000 d3cd5560 0=
00000db c22f708c 0000008a d6c60030 d6c60158 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677582]        00000000 00000006 d=
54c9edc c0354d10 d54c9ec4 c03513fb d56856c0 d423b858=20
Dec 26 22:07:54 blatterie kernel: [  260.677587] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677589]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677592]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677595]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677598]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677602] rc            S D4383F08  =
   0  3420      1  3447    3422  3206 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677607] d4383f08 d437ea90 c04513e0=
 d4383f08 c011ce60 d3cd5560 00000010 c03b6908=20
Dec 26 22:07:54 blatterie kernel: [  260.677613]        00000216 d765ea90 0=
0000437 a024a92d 00000033 d437ea90 d437ebb8 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677618]        d437ea90 d437eb3c d=
4383f80 c011d56d ffffffff 00000004 d3db4ad0 bfd14558=20
Dec 26 22:07:54 blatterie kernel: [  260.677624] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677625]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677629]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677632]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.677636]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677639] status.sh     S DDD0C987  =
   0  3422      1  8498    8379  3420 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677645] d6c6df08 d6c60a10 c04513e0=
 ddd0c987 0001a94d 00000000 c12747a0 00000000=20
Dec 26 22:07:54 blatterie kernel: [  260.677650]        c12747a0 d765ea90 0=
0001490 5476cc32 0000006a d6c60a10 d6c60b38 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677656]        d6c60a10 d6c60abc d=
6c6df80 c011d56d ffffffff 00000004 d3ceb030 d6c6df54=20
Dec 26 22:07:54 blatterie kernel: [  260.677661] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677663]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677666]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677670]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.677673]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677676] rc            S 00000000  =
   0  3447   3420          3448       (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677682] d3d51e90 d3db45e0 c04513e0=
 00000000 c011ea2d c04566c8 00000046 d3eccd16=20
Dec 26 22:07:54 blatterie kernel: [  260.677687]        00000000 d765ea90 0=
093f520 a8538a3f 00000033 d3db45e0 d3db4708 d3cd7ce4=20
Dec 26 22:07:54 blatterie kernel: [  260.677692]        d3d51eb8 d3d51eac d=
3d51ee4 c015fdc8 00000000 d3db45e0 c012c6ab d3d51ec4=20
Dec 26 22:07:54 blatterie kernel: [  260.677698] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677699]  [<c015fdc8>] pipe_wait+0x=
74/0x9c
Dec 26 22:07:54 blatterie kernel: [  260.677703]  [<c01603c2>] pipe_writev+=
0x22e/0x4aa
Dec 26 22:07:54 blatterie kernel: [  260.677707]  [<c0160671>] pipe_write+0=
x33/0x35
Dec 26 22:07:54 blatterie kernel: [  260.677710]  [<c0154d8e>] vfs_write+0x=
197/0x19c
Dec 26 22:07:54 blatterie kernel: [  260.677714]  [<c0154e53>] sys_write+0x=
4b/0x75
Dec 26 22:07:54 blatterie kernel: [  260.677717]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677720] wmir          S 00000044  =
   0  3448   3420                3447 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677725] d3de1ea0 d3db4ad0 c04513e0=
 00000044 0000002e c127df80 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.677730]        00000000 d3db40f0 0=
0008592 9fc8cd70 00000033 d3db4ad0 d3db4bf8 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677735]        00000000 00000004 d=
3de1edc c0354d10 d3de1ec4 c03513fb d72f93c0 d42b0398=20
Dec 26 22:07:54 blatterie kernel: [  260.677741] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677742]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677746]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677749]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677752]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677755] urxvt         S 00000044  =
   0  8379      1          8487  3422 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677761] d3f69ea0 d3ef65a0 c04513e0=
 00000044 00000020 c1273de0 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.677766]        00000000 d3ceb520 0=
01828ed 7228c26b 00000055 d3ef65a0 d3ef66c8 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677771]        00000000 00000008 d=
3f69edc c0354d10 d3f69ec4 c03513fb d43b4e40 d423b3d8=20
Dec 26 22:07:54 blatterie kernel: [  260.677777] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677778]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677782]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677785]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677788]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677791] urxvt         S 00000044  =
   0  8487      1          8491  8379 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677797] d3efbea0 d3ef6a90 c04513e0=
 00000044 00000020 c1286020 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.677802]        00000000 d3ef65a0 0=
0003175 717fa3ea 00000055 d3ef6a90 d3ef6bb8 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677807]        00000000 00000008 d=
3efbedc c0354d10 d3efbec4 c03513fb d3bb0c80 d423b0d8=20
Dec 26 22:07:54 blatterie kernel: [  260.677813] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677814]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677818]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677821]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677824]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677827] presize       S 59E010EC  =
   0  8491      1  8503    8493  8487 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677833] d73a9f08 d437e5a0 c04513e0=
 59e010ec 000155d8 00000000 c1269ca0 00000000=20
Dec 26 22:07:54 blatterie kernel: [  260.677838]        c1269ca0 d765ea90 0=
0001cb3 761cfd96 00000055 d437e5a0 d437e6c8 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677844]        d437e5a0 d437e64c d=
73a9f80 c011d56d ffffffff 00000004 d3cd5070 d73a9f54=20
Dec 26 22:07:54 blatterie kernel: [  260.677849] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677851]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677854]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677858]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.677861]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677865] pageupdate    S D3594E00  =
   0  8493      1  8494    8497  8491 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677870] d3c79ea0 d3cd5a50 c04513e0=
 d3594e00 00000000 00000005 d437fbfc d3d31bfc=20
Dec 26 22:07:54 blatterie kernel: [  260.677875]        bff80000 d3cd5070 0=
0000d05 44814b67 0000006a d3cd5a50 d3cd5b78 d3cd7440=20
Dec 26 22:07:54 blatterie kernel: [  260.677881]        d3c79ec8 d3c79ebc d=
3c79ef4 c015fdc8 00000000 d3cd5a50 c012c6ab d3c79ed4=20
Dec 26 22:07:54 blatterie kernel: [  260.677887] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677888]  [<c015fdc8>] pipe_wait+0x=
74/0x9c
Dec 26 22:07:54 blatterie kernel: [  260.677892]  [<c0160009>] pipe_readv+0=
x1cb/0x321
Dec 26 22:07:54 blatterie kernel: [  260.677895]  [<c0160192>] pipe_read+0x=
33/0x35
Dec 26 22:07:54 blatterie kernel: [  260.677898]  [<c0154af2>] vfs_read+0x1=
97/0x19c
Dec 26 22:07:54 blatterie kernel: [  260.677902]  [<c0154dde>] sys_read+0x4=
b/0x75
Dec 26 22:07:54 blatterie kernel: [  260.677905]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677908] pageupdate    S 00000002  =
   0  8494   8493  8495               (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677913] d3d13f08 d3ceba10 c04513e0=
 00000002 00000000 df743e58 d3b51b84 df743ef8=20
Dec 26 22:07:54 blatterie kernel: [  260.677918]        d3d31b7c d6f8b0f0 0=
0003fa6 a4ca4804 00000055 d3ceba10 d3cebb38 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.677924]        d3ceba10 d3cebabc d=
3d13f80 c011d56d ffffffff 00000004 d437e0b0 d3d13f54=20
Dec 26 22:07:54 blatterie kernel: [  260.677929] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677931]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.677934]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.677938]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.677941]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677944] wmir          S 00000044  =
   0  8495   8494                     (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677949] d3d25ea0 d437e0b0 c04513e0=
 00000044 00000022 c126d6e0 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.677954]        00000000 d3ceba10 0=
0016515 a4c909c5 00000055 d437e0b0 d437e1d8 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.677960]        00000000 00000004 d=
3d25edc c0354d10 d3d25ec4 c03513fb d3b51480 d3ba6818=20
Dec 26 22:07:54 blatterie kernel: [  260.677965] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.677967]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.677971]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.677974]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.677977]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.677980] pageupdate    S D36DC208  =
   0  8497      1  8518          8493 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.677986] d3dfdea0 d6f8b0f0 c04513e0=
 d36dc208 00000000 00000004 d3e54bfc d6befbfc=20
Dec 26 22:07:54 blatterie kernel: [  260.677990]        bfc82000 d765ea90 0=
0000fd0 a530e924 00000055 d6f8b0f0 d6f8b218 d3cd76b8=20
Dec 26 22:07:54 blatterie kernel: [  260.677997]        d3dfdec8 d3dfdebc d=
3dfdef4 c015fdc8 00000000 d6f8b0f0 c012c6ab d3dfded4=20
Dec 26 22:07:54 blatterie kernel: [  260.678002] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.678004]  [<c015fdc8>] pipe_wait+0x=
74/0x9c
Dec 26 22:07:54 blatterie kernel: [  260.678007]  [<c0160009>] pipe_readv+0=
x1cb/0x321
Dec 26 22:07:54 blatterie kernel: [  260.678010]  [<c0160192>] pipe_read+0x=
33/0x35
Dec 26 22:07:54 blatterie kernel: [  260.678014]  [<c0154af2>] vfs_read+0x1=
97/0x19c
Dec 26 22:07:54 blatterie kernel: [  260.678017]  [<c0154dde>] sys_read+0x4=
b/0x75
Dec 26 22:07:54 blatterie kernel: [  260.678020]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.678023] wmir          S 00000044  =
   0  8498   3422                     (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.678028] d3d6dea0 d3ceb030 c04513e0=
 00000044 00000015 c127d1e0 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.678033]        00000000 d765ea90 0=
00000e3 42ab7adc 00000055 d3ceb030 d3ceb158 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.678038]        00000000 00000004 d=
3d6dedc c0354d10 d3d6dec4 c03513fb d3cd6780 d3ba6c98=20
Dec 26 22:07:54 blatterie kernel: [  260.678044] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.678045]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.678049]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.678052]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.678055]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.678058] wmir          S 00000044  =
   0  8503   8491                     (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.678063] d3e3fea0 d3cd5070 c04513e0=
 00000044 0000002a c126cea0 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.678068]        00000000 d437e5a0 0=
000f816 761c5163 00000055 d3cd5070 d3cd5198 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.678074]        00000000 00000004 d=
3e3fedc c0354d10 d3e3fec4 c03513fb d3bffa40 d3ba6998=20
Dec 26 22:07:54 blatterie kernel: [  260.678080] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.678081]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.678085]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.678088]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.678091]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.678094] pageupdate    S 00000002  =
   0  8518   8497  8519               (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.678099] d3663f08 d3ef60b0 c04513e0=
 00000002 00000000 df743e58 d3c52544 df743ef8=20
Dec 26 22:07:54 blatterie kernel: [  260.678104]        d6befb7c d6f8b0f0 0=
00062ed a530a9e4 00000055 d3ef60b0 d3ef61d8 fffffe00=20
Dec 26 22:07:54 blatterie kernel: [  260.678110]        d3ef60b0 d3ef615c d=
3663f80 c011d56d ffffffff 00000004 d36a1ad0 d3663f54=20
Dec 26 22:07:54 blatterie kernel: [  260.678115] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.678117]  [<c011d56d>] do_wait+0x2b=
b/0x391
Dec 26 22:07:54 blatterie kernel: [  260.678121]  [<c011d705>] sys_wait4+0x=
3e/0x40
Dec 26 22:07:54 blatterie kernel: [  260.678124]  [<c011d72e>] sys_waitpid+=
0x27/0x29
Dec 26 22:07:54 blatterie kernel: [  260.678127]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.678131] wmir          S 00000044  =
   0  8519   8518                     (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.678136] d36c1ea0 d36a1ad0 c04513e0=
 00000044 00000022 c126e040 00000010 c03b68e0=20
Dec 26 22:07:54 blatterie kernel: [  260.678140]        00000000 d3ef60b0 0=
00204d2 a52f811c 00000055 d36a1ad0 d36a1bf8 7fffffff=20
Dec 26 22:07:54 blatterie kernel: [  260.678146]        00000000 00000004 d=
36c1edc c0354d10 d36c1ec4 c03513fb d3bffc80 d3ba6698=20
Dec 26 22:07:54 blatterie kernel: [  260.678152] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.678153]  [<c0354d10>] schedule_tim=
eout+0x9c/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.678157]  [<c0166a8b>] do_select+0x=
237/0x26f
Dec 26 22:07:54 blatterie kernel: [  260.678160]  [<c0166db3>] sys_select+0=
x2bd/0x3fd
Dec 26 22:07:54 blatterie kernel: [  260.678163]  [<c0102e1d>] syscall_call=
+0x7/0xb
Dec 26 22:07:54 blatterie kernel: [  260.678166] sleep         S D6595F0C  =
   0  9683   3185                3197 (NOTLB)
Dec 26 22:07:54 blatterie kernel: [  260.678171] d6595f38 d765e5a0 c04513e0=
 d6595f0c c0147671 00000000 df743ef8 00000002=20
Dec 26 22:07:54 blatterie kernel: [  260.678176]        d6cddb7c d765e0b0 0=
001b9d0 160caa0a 0000003c d765e5a0 d765e6c8 d6595f4c=20
Dec 26 22:07:54 blatterie kernel: [  260.678182]        00016a99 00000003 d=
6595f74 c0354cc4 d6595f4c 00016a99 df6763c0 c0456e90=20
Dec 26 22:07:54 blatterie kernel: [  260.678187] Call Trace:
Dec 26 22:07:54 blatterie kernel: [  260.678189]  [<c0354cc4>] schedule_tim=
eout+0x50/0x9e
Dec 26 22:07:54 blatterie kernel: [  260.678192]  [<c0354d2c>] schedule_tim=
eout_interruptible+0x1a/0x1c
Dec 26 22:07:54 blatterie kernel: [  260.678197]  [<c0122983>] sys_nanoslee=
p+0xc3/0x156
Dec 26 22:07:54 blatterie kernel: [  260.678200]  [<c0102e1d>] syscall_call=
+0x7/0xb

--ew6BAiZeqk4r7MaW--

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDsF9bpBRla5yeL58RAswnAJ9BXbGigsVJMfQRpD9zHhxmH8YDDQCfSKJT
/5OD7ZvSa1ecRWchFZdkXkM=
=bFT2
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--

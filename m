Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVEBGB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVEBGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 02:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEBGBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 02:01:55 -0400
Received: from mail01.solnet.ch ([212.101.4.135]:39440 "EHLO mail01.solnet.ch")
	by vger.kernel.org with ESMTP id S261780AbVEBGBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 02:01:35 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Date: Mon, 2 May 2005 08:01:28 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050430164303.6538f47c.akpm@osdl.org> <200505011707.35461.damir.perisa@solnet.ch> <20050501150624.7696fc31.akpm@osdl.org>
In-Reply-To: <20050501150624.7696fc31.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3746444.F2JumZdkEf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505020801.31860.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3746444.F2JumZdkEf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Monday 02 May 2005 00:06, Andrew Morton a =E9crit=A0:
> Damir Perisa <damir.perisa@solnet.ch> wrote:
> > i updated from rc2-mm3 to rc3-mm2 and now i observe something
> > strange: the cpu is running all the time at 100% because of the
> > kswapd0 that is running always and not becomming idle.
> Could you type sysrq-P a few times, see if we can work out where it's
> stuck?
>
> Thanks.

sure. i recompiled the kernel with magic keys and debugger activated [1],=20
and kswapd0 does idle normally, now. it seems to solve my issue, but i=20
don't know why.=20

for redundancy, here the Regs (alt-sysrq-p):

[4294742.093000] SysRq : Show Regs
[4294742.093000]
[4294742.093000] Pid: 0, comm:              swapper
[4294742.093000] EIP: 0060:[<c03feb42>] CPU: 0
[4294742.093000] EIP is at acpi_processor_idle+0x103/0x29a
[4294742.093000]  EFLAGS: 00000246    Not tainted  (2.6.12-rc3-mm2-ARCH)
[4294742.093000] EAX: 00000000 EBX: c03fea3f ECX: 00000001 EDX: c072e000
[4294742.093000] ESI: efa4c074 EDI: c0772380 EBP: efa4c000 DS: 007b ES:=20
007b
[4294742.093000] CR0: 8005003b CR2: f1473b04 CR3: 2f37d000 CR4: 00000690
[4294742.093000]  [<c03fea3f>] acpi_processor_idle+0x0/0x29a
[4294742.093000]  [<c0100e35>] cpu_idle+0x45/0x80
[4294742.093000]  [<c07309e7>] start_kernel+0x197/0x1e0
[4294742.093000]  [<c0730390>] unknown_bootoption+0x0/0x1f0

the unknown_bootoption confuses me a little. the only bootoption i use is=20
"devfs=3Dnomount" because i use udev and because people in archlinux may=20
use instead of udev the devfs i keep devfs in the kernel.

hope it helps you. as i said, now, with minimal debug options and magic=20
keys configured into the kernel, the kswapd0 idles normally. (so a=20
workaround to my issue is activating )=20

greetings,
Damir

[1] the important part of config:
#
# Kernel hacking
#
CONFIG_PRINTK_TIME=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_LOG_BUF_SHIFT=3D15
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
# CONFIG_KGDB is not set


=2D-=20
  Customer: "Eudora keeps giving me the error 'connection confused'."=20

--nextPart3746444.F2JumZdkEf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCdcI7PABWKV6NProRAttMAKDf4lyiWZ8fysfihf/KgN//n294rwCggheO
AD+gjNHCwzte+yClC0AD+uY=
=Sv1w
-----END PGP SIGNATURE-----

--nextPart3746444.F2JumZdkEf--

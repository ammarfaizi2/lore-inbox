Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSIYXrx>; Wed, 25 Sep 2002 19:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSIYXrw>; Wed, 25 Sep 2002 19:47:52 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:6856 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S261238AbSIYXrv>; Wed, 25 Sep 2002 19:47:51 -0400
From: Richard Drummond <evilrich@ntlworld.com>
Organization: Private
To: linux-kernel@vger.kernel.org
Subject: Kernel and Open Firmware problems with my G3 upgrade card
Date: Thu, 26 Sep 2002 00:57:27 +0100
User-Agent: KMail/1.4.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_n1kk9B+Fx8OERv0"
Message-Id: <200209260057.28056.evilrich@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_n1kk9B+Fx8OERv0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi=20

Not sure whether this is the right place to ask these question, but I've be=
en=20
searching for some answers for a while, and - because part of the problem i=
s=20
kernel-related - I'm gonna ask here anyway.

I upgraded my Old Word Mac recently (a Starmax Tanzania-based machine) with=
 a=20
Met@box G3 card. This is the type of expansion that plugs into the cache RA=
M=20
socket. It seems to be stable under Linux, but there are a few nagging=20
problems.

1. The machine will no longer boot with Quik. It fails with one of those na=
sty=20
DEFAULT CLAIM messages,  and the usual OF hack to wait for disk spin-up mak=
es=20
no difference. To use Linux, I now have to boot MacOS and start Linux via=20
BootX - which is a pain.

2. The Kernel doesn't recognize this G3 processor properly. It claims the=20
clock speed is 80MHz, when actually it's 260MHz; and it claims that the L2=
=20
cache's size is 256K, when actually it is 512K. (Output from /proc/cpuinfo =
on=20
kernel 2.4.19 attached.)

I suspect these problems are related and are due to the fact that the versi=
on=20
of Open Firmware in this machine was never designed to handle a G3 processo=
r=20
and so the L2 cache doesn't get set up properly. Interestingly, OF reports=
=20
the CPU as a PowerPC,608 and there's no L2CR property present at all. I'm=20
guessing the Quik booting problem is due to the improperly set-up cache=20
interfering with disk access. The reason Linux boots from MacOS is that the=
=20
MacOS extension for this card sets up the L2 cache correctly, and so lets=20
BootX load the kernel.=20

My questions are:

Is there some way to set the L2CR from OF - bearing in mind there's no l2cr=
=20
property in OF's CPU node? (BTW, the cache control utility under MacOS, who=
se=20
name escapes me, reports the L2CR's contents as 0xA910000.)

Would be it feasible to modify the kernel to properly recognize the process=
or=20
on this card? (I suppose setting up the L2CR properly would at least get it=
=20
to report the cache size correctly. But what about the clock speed?)

Any suggestions, anybody?

Cheers,
Rich

--Boundary-00=_n1kk9B+Fx8OERv0
Content-Type: text/plain;
  charset="us-ascii";
  name="cpuinfo.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cpuinfo.txt"

cpu		: 740/750
temperature 	: 15-17 C (uncalibrated)
clock		: 80MHz
revision	: 2.2 (pvr 0008 0202)
bogomips	: 519.37
machine		: Power Macintosh
motherboard	: AAPL,e826 MacRISC
detected as	: 47 (Unknown OHare-based)
pmac flags	: 00000000
L2 cache	: 256K unified
memory		: 144MB
pmac-generation	: OldWorld

--Boundary-00=_n1kk9B+Fx8OERv0--


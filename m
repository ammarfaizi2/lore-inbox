Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUGaTvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUGaTvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUGaTvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 15:51:46 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:57375 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261474AbUGaTv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 15:51:28 -0400
Message-ID: <b71082d804073112512bbd82e2@mail.gmail.com>
Date: Sat, 31 Jul 2004 21:51:27 +0200
From: Bart Alewijnse <scarfboy@gmail.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: gigabit trouble
In-Reply-To: <20040730234120.A15536@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_44_6682347.1091303487749"
References: <b71082d8040729094537e59a11@mail.gmail.com> <20040729210401.A32456@electric-eye.fr.zoreil.com> <b71082d80407291541f9d6f93@mail.gmail.com> <b71082d804073008157cf1d6c0@mail.gmail.com> <20040730205412.A15669@electric-eye.fr.zoreil.com> <b71082d804073014037bc5dd5a@mail.gmail.com> <20040730234120.A15536@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_44_6682347.1091303487749
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 30 Jul 2004 23:41:20 +0200, Francois Romieu
<romieu@fr.zoreil.com> wrote:
> [...]
> > Anyhow, on transmit from the celeron box, under extreme benchy
> > circumstrances, I've seen it around 16Kints/s on transmit and 13k on
> > receive. But under everyday nfs/samba, 6400 is about the best it does
> > either way.
> 
> The figures does not seem bad.
Except they're about a factor 1.2 to 1.7 faster than my 100mbit, in practical
(network filesystem) application. That's very short of spectacular.

> I am curious: which chipset does the motherboard include ?
> An 'lspci -vx' sums it quite well.
Ermm... VIA, I believe it was called Apollo Pro. VT82C693.
But as the rest may matter, the full lspci -vx listing's attached.

> [...]
> > This may be due to fiddling with said wmem, etc values, I set some of them
> It should not.
If my computer did what it should do, would I be here?:)

> > considerably larger. I did get a few percent apparent speed increase,
> > incidentally, though that may have been wishful thinking.
> >
> > I guess I should try >= 2.6.8-rc2-mm1 next?
> 
> Please. Do not compile in preempt/ipv6/smp. SMP is supposed to be safe
> but you do not need it and it will not make your r8169 faster if you have
> only one CPU. I'd welcome a 'vmstat 1' output as it gives the bi/bo.
ipv6 was nonsense anyhow (and I think loaded as a module), smp was force
of habit as something kernely ages back wanted it. But is there really no
point to preempting in a server?

Right, both computers now run 2.6.8-rc2-mm1. It's better. Roughly
speaking, the top *benchmark* speeds, rouding slightly up, are:
udp: 33MB/s (using ~26Kints) one way, 12MB/s (9Kints/s) the other, 
tcp: 22MB/s (16Kints)one way, 12MB/s (9Kints/s) the other. 

(The 9Kints ca be 12 when the packet size is 1K or 2K)

Oddly enough, the slow direction is sending from my new computer
(XP1700, KT333, 1GB ram) to my old (both running linux and the
mentioned kernel). I'm fairly sure this is due to the fact that my
asus motherboard is crap, and I guess I'll have to settle for it,
unless one of you is very good at black magic. Because trust me, the
way hardware and chooses not to work, apparently based on slots and/or
irq's is just *weird*. Bah.

Practical speeds increased far less dramatically. nfs now sustains at
10MB/s, with the occasional 12. Samba increased less, about half a meg
a second, it sustains speeds slightly over 8MB/s, to both linux and
windows.
I guess no network filesystems focuses on speed? I mean, I did always
wonder why nfs and samba on 100mbit transfers averaged around half the
line speed, and that's counting large files (no tcp startup to blame).

I don't suppose any of you know a good windows nfs client.

I guess I'll have to settle for this. I'm just annoyed that the 'giga'
is basically a joke,  especially on my setup.


--Bart Alewijnse

------=_Part_44_6682347.1091303487749
Content-Type: text/plain; name="lspci-vx.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="lspci-vx.txt"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO=
133x] (rev 06)
=09Flags: bus master, medium devsel, latency 0
=09Memory at dc000000 (32-bit, prefetchable)
=09Capabilities: [a0] AGP version 1.0
00: 06 11 91 06 06 00 90 a2 06 00 00 06 00 00 00 00
10: 08 00 00 dc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/=
Pro133x AGP] (prog-if 00 [Normal decode])
=09Flags: bus master, 66Mhz, medium devsel, latency 0
=09Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]=
 (rev 11)
=09Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
=09Flags: bus master, stepping, medium devsel, latency 0
00: 06 11 96 05 87 00 00 02 11 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B=
/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
=09Flags: bus master, medium devsel, latency 32
=09I/O ports at e000 [size=3D16]
00: 06 11 71 05 07 00 80 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00

0000:00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management =
(rev 20)
=09Flags: medium devsel
00: 06 11 51 30 00 00 80 02 20 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06) (pr=
og-if 00 [VGA])
=09Flags: bus master, medium devsel, latency 32, IRQ 15
=09Memory at d8000000 (32-bit, non-prefetchable)
00: 33 53 31 56 07 00 00 02 06 00 00 03 00 20 00 00
10: 00 00 00 d8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 04 ff

0000:00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/=
8139C/8139C+ (rev 10)
=09Subsystem: Realtek Semiconductor Co., Ltd. RT8139
=09Flags: bus master, medium devsel, latency 32, IRQ 11
=09I/O ports at e800
=09Memory at df001000 (32-bit, non-prefetchable) [size=3D256]
=09Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 e8 00 00 00 10 00 df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 =
Gigabit Ethernet (rev 10)
=09Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
=09Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
=09I/O ports at ec00 [size=3Dde000000]
=09Memory at df000000 (32-bit, non-prefetchable) [size=3D256]
=09Expansion ROM at 00010000 [disabled]
=09Capabilities: [dc] Power Management version 2
00: ec 10 69 81 07 00 b0 02 10 00 00 02 08 20 00 00
10: 01 ec 00 00 00 00 00 df 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 69 81
30: 00 00 00 de dc 00 00 00 00 00 00 00 0a 01 20 40


------=_Part_44_6682347.1091303487749--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSGJKpB>; Wed, 10 Jul 2002 06:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSGJKpA>; Wed, 10 Jul 2002 06:45:00 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:35589 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S315485AbSGJKo5> convert rfc822-to-8bit;
	Wed, 10 Jul 2002 06:44:57 -0400
Date: Wed, 10 Jul 2002 13:47:40 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: tulip 21143 based card does not work with 10 Mbit with recent
 kernel
In-Reply-To: <20020710124120.A11310@torres.ka0.zugschlus.de>
Message-ID: <Pine.LNX.4.33.0207101345410.23460-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jul 2002, Marc Haber wrote:

> Hi,
>
> I have a bunch of tulip based network cards with 21143 chipset. These
> Micronet made cards do not seem to work when connected to a 10 Mbit
> hub (as I have in the lab setup) while running with a recent kernel:
>
> Jul 10 11:41:52 orion kernel: Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
> Jul 10 11:41:52 orion kernel: PCI: Found IRQ 5 for device 00:09.0
> Jul 10 11:41:52 orion kernel: PCI: Sharing IRQ 5 with 00:04.2
> Jul 10 11:41:52 orion kernel: tulip0:  EEPROM default media type Autosense.
> Jul 10 11:41:52 orion kernel: tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
> Jul 10 11:41:52 orion kernel: tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
> Jul 10 11:41:52 orion kernel: tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
> Jul 10 11:41:52 orion kernel: tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
> Jul 10 11:41:52 orion kernel: eth0: Digital DS21143 Tulip rev 65 at 0xb000, 00:C0:CA:30:CD:75, IRQ 5.
>
> The hub shows a link beat after the module has been loaded, but the
> link vanishes once the "ip link set dev eth0 up" was issued. No data
> can be transferred.
>
> |haber@orion[1/76]:~$ sudo mii-diag eth0
> |Basic registers of MII PHY #32:  1000 784c 0000 0000 01e1 0000 0000 0000.
> | Basic mode control register 0x1000: Auto-negotiation enabled.
> | You have link beat, and everything is working OK.
> | Your link partner does not do autonegotiation, and this transceiver type
> |  does not report the sensed link speed.
> |   End of basic transceiver informaion.
>
> Please note that mii-diag claims link beat, which is not true.
>
> |haber@orion[8/83]:~$ sudo mii-tool --force=10baseT-HD
> |haber@orion[9/84]:~$ sudo mii-diag eth0
> |Basic registers of MII PHY #32:  2000 7848 0000 0000 01e1 0000 0000 0000.
> | Basic mode control register 0x2000: Auto-negotiation disabled, with
> | Speed fixed at 100 mbps, half-duplex.
> | Basic mode status register 0x7848 ... 7848.
> |   Link status: not established.
> | Link partner information information is not exchanged when in fixed speed mode.
> |   End of basic transceiver informaion.
>
> Please not that mii-diag report the speed that has just been forced to
> 10 mbps half-duplex as 100 mbps.
>
> Using a 10/100 Mbit switch instead of the 10 Mbit hub solves this
> problem.
>
> |haber@orion[4/59]:~$ sudo mii-diag eth0
> |Basic registers of MII PHY #32:  1000 784c 0000 0000 0041 45e1 0000 0000.
> | The autonegotiated capability is 0040.
> |The autonegotiated media type is 10baseT-FD.
> | Basic mode control register 0x1000: Auto-negotiation enabled.
> | You have link beat, and everything is working OK.
> | Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
> |   End of basic transceiver informaion.
>
> However, the switch clearly shows the 100 Mbit light "on", so I have
> to - again - distrust mii-diag here, because the performance clearly
> shows that we are not running 10 Mbit here (10 Mbyte in approx. 2 secs).
>
> When I use an older kernel (2.2.18 from the Linuxcare BBC), the card
> works on the hub:
>
> Jul 10 11:40:06 orion kernel: tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
> Jul 10 11:40:06 orion kernel: eth0: Digital DS21143 Tulip rev 65 at 0xb000, 00:C0:CA:30:CD:75, IRQ 5.
> Jul 10 11:40:06 orion kernel: eth0:  EEPROM default media type Autosense.
> Jul 10 11:40:06 orion kernel: eth0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
> Jul 10 11:40:06 orion kernel: eth0:  Index #1 - Media 10baseT-FD (#4) described by a 21142 Serial PHY (2) block.
> Jul 10 11:40:06 orion kernel: eth0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
> Jul 10 11:40:06 orion kernel: eth0:  Index #3 - Media 100baseTx-FD (#5) described by a 21143 SYM PHY (4) block.
>
> |haber@orion[3/88]:~$ sudo mii-diag eth0
> |Basic registers of MII PHY #32:  1000 786c 0000 0000 05e1 0000 0000 0000.
> | Basic mode control register 0x1000: Auto-negotiation enabled.
> | You have link beat, and everything is working OK.
> | Your link partner does not do autonegotiation, and this transceiver type
> |  does not report the sensed link speed.
> |   End of basic transceiver informaion.
>
> Is this a known issue with the tulip driver in 2.4.18? Can I help with
> debugging?
>

I have reported (and noticed ;) the same problem. I fixed the problem by
using older version of the tulip-driver (0.9.14 IIRC, available from the
sourceforge).

I don't know if this is fixed in the 2.4.19-pre's... hopefully so.


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


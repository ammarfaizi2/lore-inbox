Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269026AbUIMXev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269026AbUIMXev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUIMXes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:34:48 -0400
Received: from pD9E75C6D.dip0.t-ipconnect.de ([217.231.92.109]:44929 "EHLO
	achilles.nass-vogt.home") by vger.kernel.org with ESMTP
	id S269068AbUIMXbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:31:18 -0400
From: Hans-Frieder Vogt <hfvogt@arcor.de>
Reply-To: hfvogt@arcor.de
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Date: Tue, 14 Sep 2004 01:31:11 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
References: <200409130035.50823.hfvogt@arcor.de> <200409131443.34374.hfvogt@arcor.de> <20040913220209.GA13175@electric-eye.fr.zoreil.com>
In-Reply-To: <20040913220209.GA13175@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/2iRBaeD8M2PAeQ"
Message-Id: <200409140131.11927.hfvogt@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/2iRBaeD8M2PAeQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 14. September 2004 00:02 schrieb Francois Romieu:
> Hans-Frieder Vogt <hfvogt@arcor.de> :
> [...]
>
> > no oops (BUG_ON not triggered)! System boots up as normal, but just after
> > I
>
> ...
>
> > log in on the console the system freezes, i.e., keyboard does not react
> > any more and the system is not accessible via network.
>
> - do the keyboard leds or the magic sysrq answer (I assume you boot without  
X) ?

(To be able to exclude any side effect of X, I have booted without X and I 
have also removed all graphics driver related modules)

When the system freezes, the keyboard is completely dead, the LEDs do not 
react any more and also the sysrq keys do not work.

> - does it make a difference if you boot with the network cable 
> unpluged (i.e. fine until pluged then dead when first packet comes in) ?
>

YES!! With the network cable unplugged, the system does not freeze!
Every 10 seconds, I get now the message:
r8169: eth0: PHY reset until link up
but otherwise everything seems fine.

> > The time from the moment I log in to the time when the system freezes
> > varies, but is in the order of 5s.
>
> First packet probably. Can you verify this point ?
>

I think the test with the network cable unplugged supports this assumption.
With network cable unplugged, /proc/interrupts shows 0 interrupts for the 
network card, so probably the first interrupt leads to the system freeze.

> > There is no difference whether NAPI is enabled or not.
>
> I will welcome lspci -vx + gcc version + objdump -S of the r8169 module.
>

lspci -vx and objdump -S output (gzipped) are attached, gcc version is 3.4.2 
(Debian 3.4.2-2), but no visible difference with 3.4.1.

> --
> Ueimor

Thanks for your help, Francois.
I will put a few printks into the interrupt routine and hope to be able to 
tell you more tomorrow,

Hans-Frieder

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt (at) arcor (dot) de

--Boundary-00=_/2iRBaeD8M2PAeQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci-vx.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci-vx.out"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge
	Flags: bus master, 66MHz, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.0
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
	Capabilities: [58] #08 [8001]
00: 06 11 88 31 06 00 30 22 01 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 88 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: cde00000-cfefffff
	Prefetchable memory behind bridge: bdd00000-cdcfffff
	Capabilities: [80] Power Management version 2
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
20: e0 cd e0 cf d0 bd c0 cd 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0e 00

0000:00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: Avermedia Technologies Inc: Unknown device 0761
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at cddfe000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
00: 9e 10 6e 03 06 00 90 02 11 00 00 04 00 20 80 00
10: 08 e0 df cd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 61 14 61 07
30: 00 00 00 00 44 00 00 00 00 00 00 00 0c 01 10 28

0000:00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: Avermedia Technologies Inc: Unknown device 0761
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at cddff000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
00: 9e 10 78 08 06 00 90 02 11 00 80 04 00 20 80 00
10: 08 f0 df cd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 61 14 61 07
30: 00 00 00 00 44 00 00 00 00 00 00 00 0c 01 04 ff

0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 702c
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	I/O ports at d400 [size=256]
	Memory at cfffbf00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 40000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
00: ec 10 69 81 17 00 b0 02 10 00 00 02 10 40 00 00
10: 01 d4 00 00 00 bf ff cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 2c 70
30: 00 00 00 40 dc 00 00 00 00 00 00 00 0b 01 20 40

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd. MSI Neo K8T FIS2R mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at ec00 [size=8]
	I/O ports at e800 [size=4]
	I/O ports at e400 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at dc00 [size=16]
	I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 01 e0 00 00
20: 01 dc 00 00 01 d8 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 02 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
	Flags: bus master, medium devsel, latency 32, IRQ 20
	I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c4 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 7020
	Flags: bus master, medium devsel, latency 32, IRQ 21
	Memory at cfffbd00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 20 80 00
10: 00 bd ff cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 27 32
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 0080
	Flags: medium devsel, IRQ 22
	I/O ports at c000 [size=256]
	Capabilities: [c0] Power Management version 2
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 80 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: [80] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1) (prog-if 00 [VGA])
	Subsystem: Hercules: Unknown device 0020
	Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 16
	Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
	Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at cfef0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0
00: de 10 10 01 07 00 b0 02 a1 00 00 03 00 f8 00 00
10: 00 00 00 ce 08 00 00 c0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 81 16 20 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0b 01 05 01


--Boundary-00=_/2iRBaeD8M2PAeQ
Content-Type: application/x-gzip;
  name="r8169-dump.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="r8169-dump.out.gz"

H4sICE0mRkECA3I4MTY5LWR1bXAub3V0AKRd6Y7dtpL+7TyFgDsB5s44sbhTxuD+mvdoSCTldHJ6
cZ9O0neefliiSJHaTvG4YbQDh8W1WOtX1E9fLo/Dl6cX++fFXb/QX+Wv3S9vhvwy/EHUL/2TlfzL
H+7t2V2+2LfHv9zb9cuze//yponsfv3j5WsDP+PjxTXjy9tT/964yyj5Lx9a/iL5Tz/97+O1v17d
03D5d/MyNldn3h9fnptf393H+9effmpXP83/vJrHhz+fn/rXh+vj87eL+9fXn5rw0379xLtGd82o
m/zn09PLX/D3z2/28fPPbzq2Z769brRtuGpUm7W/uH7q70O1/wlE//RU/UckU18/MdKMY7P6+fTx
8jYN42AY/ysSdH4c22jRmLYkeHfX92leOp+WmabVjg0XxUo+Gb+OZ9fAXD7DtGYC4tftusbvTfoz
E/z+9PodGojtrv13+0HEv2IP4usnKZvtzyfbv/dExmYS10zhmumvn7p2r9nzyyv8Hdt1uO56XLMB
18wgJ2dx3Tlcs/HWqKv7QOf7YJ/6h+u/n818uA/+pj1Y99ejWW4HbQO3s8aZhuZsdf1zgL//o/2g
wIfX10jB77ofVAeyrhF+IN60enMNh4/P7Yf+Txjrn5HKTrfKDse3ylPBr0gwhmHE+iYut2q67ema
MJrdK3t8r9IIzLO7367RXy1WjmCeXucdY35KJhF0ceVyWjlptyt/9SsnbbF05pmDm4mMT2TbDSMU
yMod4yyRTaPR7WiEeTJajsZ1lJKWH0lJ2AZCI8GQxKo4ILjCRhMWCfx6fGtjN0cZCfyWwVFGRhOe
NZVoWrEh+N0fCzRQt9jcizOmojgT/qSd3hOIpr9cvtf35wWaHmB+qy7jgmCHH1/9LXD9R5z7Pxph
MaPYNIq/AVsdkTO0A/506aIJfwOUP/etIvrdBb3TIiag2jgBSaZz86rk8Nw8+2b8LhMHOnrAGZ5x
gZ8igUwE7oiAgQiKd1amG2XHA4Kh0IUyKE9/WgdXcLl9cNUjByoSyQ5kVhJXuYBQ83KGo4u73Nn8
Qqkhke1f3OXO5tdKJwFueCnAe2t3BbjmNwwDv6+3GUR2kUE0ThNrnCbWOE2skZpY4zSxxmliPeJG
7dp7GKcTd3Fp19/Fb914F7/1vJbfeq9aDNvbtDf3/n3ZtB7HRz2Oj3ocH/VIPupxfNTj+KivtegG
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

--Boundary-00=_/2iRBaeD8M2PAeQ--

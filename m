Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318923AbSHFDHL>; Mon, 5 Aug 2002 23:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSHFDHK>; Mon, 5 Aug 2002 23:07:10 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:45728 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318923AbSHFDHK>; Mon, 5 Aug 2002 23:07:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 6 Aug 2002 13:11:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15695.15964.398382.560464@notabene.cse.unsw.edu.au>
Subject: Serverworks AGP problem in 2.4.19
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I just tried 2.4.19 with CONFIG_AGP_SWORKS=y on a machine with a
 serverworks chipset, and it wasn't happy.

  Posted write buffer flush took morethen 3 seconds

 gets printed repeatedly ad-nauseum.

 So I'll just turn CONFIG_AGP_SWORKS off, but I thought someone might
 like to know.

NeilBrown


# lspci
00:00.0 Host bridge: Relience Computer CNB20HE (rev 23)
00:00.1 PCI bridge: Relience Computer CNB20HE (rev 01)
00:00.2 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
00:00.3 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
00:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:05.0 SCSI storage controller: Adaptec 7899P (rev 01)
00:05.1 SCSI storage controller: Adaptec 7899P (rev 01)
00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 51)
00:0f.1 IDE interface: Relience Computer: Unknown device 0211
00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)

# lspci -n
00:00.0 Class 0600: 1166:0008 (rev 23)
00:00.1 Class 0604: 1166:0009 (rev 01)
00:00.2 Class 0600: 1166:0006 (rev 01)
00:00.3 Class 0600: 1166:0006 (rev 01)
00:04.0 Class 0200: 8086:1229 (rev 08)
00:05.0 Class 0100: 9005:00cf (rev 01)
00:05.1 Class 0100: 9005:00cf (rev 01)
00:06.0 Class 0200: 8086:1229 (rev 08)
00:0f.0 Class 0601: 1166:0200 (rev 51)
00:0f.1 Class 0101: 1166:0211
00:0f.2 Class 0c03: 1166:0220 (rev 04)
01:00.0 Class 0300: 1002:474d (rev 27)

# lspci -v -s 00:00
00:00.0 Host bridge: Relience Computer CNB20HE (rev 23)
        Flags: fast devsel
        Memory at fa000000 (32-bit, prefetchable) [disabled] [size=32M]
        Memory at <ignored> (32-bit, non-prefetchable) [disabled] [size=4K]

00:00.1 PCI bridge: Relience Computer CNB20HE (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: fc500000-fe5fffff
        Prefetchable memory behind bridge: fc200000-fc2fffff
        Capabilities: [80] AGP version 2.0

00:00.2 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
        Flags: medium devsel

00:00.3 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
        Flags: medium devsel


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRBCWvf>; Sat, 3 Feb 2001 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBCWvZ>; Sat, 3 Feb 2001 17:51:25 -0500
Received: from ns1.samba.org ([203.17.0.92]:52237 "HELO au2.samba.org")
	by vger.kernel.org with SMTP id <S131028AbRBCWvR>;
	Sat, 3 Feb 2001 17:51:17 -0500
From: Andrew Tridgell <tridge@linuxcare.com>
To: linux-kernel@vger.kernel.org
Cc: junichi_morita@ysv.yokogawa.co.jp, torvalds@transmeta.com
Subject: setting cpu speed on crusoe
Reply-To: tridge@linuxcare.com
Message-Id: <20010203223939.40F82659858@au2.samba.org>
Date: Sun,  4 Feb 2001 09:39:39 +1100 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junichi Morita and I have worked out how to access the crusoe
"longrun" settings on the crusoe based VAIO. This allows you to enable
power saving mode and slow the cpu down. It should help battery life a
lot.

the following will enable power saving and set the cpu to the slowest
speed:

  setpci -s 0:0.0 a8.b=11

and this will restore you to max speed:

  setpci -s 0:0.0 a8.b=0e

the bits are:

LRON bit0: long run "on" - I'm not really sure what this does
LRRV bit1-3: cpu speed
LREN bit4: seems to enable variable speed 

the info came from a dump of the AML off the box like this:

00001e24:   Scope PCI0 (\_SB_.PCI0)
00001e30:     OpRegion LRCR (\_SB_.PCI0.LRCR)
00001e36:       PCI_Config
00001e37:       0xa8
00001e39:       0x04
00001e3b:     Field
00001e3e:       LRCR (00001e30)
00001e42:       AccessType: ByteAcc; LockRule: NoLock; UpdateRule: Preserve
00001e43:       NamedField (1 bits at 0x0:0) LRON
00001e48:       NamedField (3 bits at 0x0:1) LRRV
00001e4d:       NamedField (1 bits at 0x0:4) LREN

the patch to acpidisasm to give the bit offsets and lengths for named
fields is available from
http://www.samba.org/ftp/unpacked/picturebook/acpi.patch





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130996AbQKZAnA>; Sat, 25 Nov 2000 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131724AbQKZAmu>; Sat, 25 Nov 2000 19:42:50 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:19433 "EHLO
        altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
        id <S130996AbQKZAmk>; Sat, 25 Nov 2000 19:42:40 -0500
Date: Sun, 26 Nov 2000 01:12:24 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11: Trying to free nonexistent resource <000003e0-000003e1>
Message-ID: <20001126011224.B10587@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While shutting down, /var/log/messages said:
Nov 25 23:15:12 mimas cardmgr[342]: exiting
Nov 25 23:15:14 mimas kernel: Trying to free nonexistent resource <000003e0-000003e1> 
Nov 25 23:15:14 mimas kernel: unloading PCMCIA Card Services 

mimas /proc# cat ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0300-030f : 3c589_cs
03c0-03df : vga+
03e0-03e1 : i82365
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1

mimas /proc# cat modules 
af_packet               9232   0 (autoclean)
ppp_deflate            41056   2 (autoclean)
bsd_comp                4224   0 (autoclean)
ppp_async               6800   1 (autoclean)
ppp_generic            15328   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
3c589_cs                8112   1
ds                      6864   2 [3c589_cs]
i82365                 12672   2
pcmcia_core            40256   0 [3c589_cs ds i82365]

Think it's not relevant but just in case: the RH6.1 cardmgr is
being used though linux/Documentation/Changes says it should be
upgraded for this kernel. kernel is SMP but there's only 1 CPU.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

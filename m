Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTA1Aju>; Mon, 27 Jan 2003 19:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbTA1Ajt>; Mon, 27 Jan 2003 19:39:49 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:47008 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S264724AbTA1Ajs>;
	Mon, 27 Jan 2003 19:39:48 -0500
Date: Mon, 27 Jan 2003 16:49:06 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-pre3] APIC routing broken on ASUS P2B-DS
Message-ID: <20030128004906.GA3439@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something broke between 2.4.20 and 2.4.21-pre3 which is causing
interrupts to not be routed the second CPU.  I saw the problem on one box
and copied the kernel to another which then had the same problem (both
ASUS P2B-DS boards, one with PIII CPUs, one with PII CPUs).  

[sroot@devel:/]# cat /proc/interrupts
           CPU0       CPU1       
  0:     114480          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          3          0    IO-APIC-edge  rtc
 16:      30707          0   IO-APIC-level  eth0
 19:       3260          0   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:     114405     114404 
ERR:          0
MIS:          0

With 2.4.20:

[sroot@devel:/root]# cat /proc/interrupts 
           CPU0       CPU1       
  0:      23627      27340    IO-APIC-edge  timer
  1:          0          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          1    IO-APIC-edge  rtc
 16:       1671          2   IO-APIC-level  eth0
 19:        965        979   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:      50893      50891 
ERR:          0
MIS:          0

...If nobody knows what happened immediately, I'll try narrowing it down
to the patch.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]

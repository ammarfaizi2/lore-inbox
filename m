Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSFTWsm>; Thu, 20 Jun 2002 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSFTWsl>; Thu, 20 Jun 2002 18:48:41 -0400
Received: from jalon.able.es ([212.97.163.2]:32430 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315923AbSFTWsk>;
	Thu, 20 Jun 2002 18:48:40 -0400
Date: Fri, 21 Jun 2002 00:48:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620224831.GE1742@werewolf.able.es>
References: <20020620055933.GA1308@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020620055933.GA1308@dualathlon.random>; from andrea@suse.de on Thu, Jun 20, 2002 at 07:59:33 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.20 Andrea Arcangeli wrote:
>
>Also merges some stuff from 19pre10jam2, not all the same, in particular
>irq-balance is quite different, previous algorithm looked not really
>good while auditing it, benchmarks will tell, any feedback on this in
>particular would be welcome. Have a look at xosview to see the
>difference.
>

Still not tested on the dual xeon, but on a BX with doal PII:
werewolf:~# cat /proc/interrupts
           CPU0       CPU1       
  0:      83491      63920    IO-APIC-edge  timer
  1:       2044       1213    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          1          1   IO-APIC-level  bttv
  8:          0          1    IO-APIC-edge  rtc
 10:      52335      24289   IO-APIC-level  aic7xxx, EMU10K1
 11:      69049      50801   IO-APIC-level  eth0, nvidia
 12:      33155      23661    IO-APIC-edge  PS/2 Mouse
 14:          2         14    IO-APIC-edge  ide0
 15:          3         13    IO-APIC-edge  ide1
NMI:          0          0 
LOC:     147281     147325 
ERR:          0
MIS:         36

Old patch, on the dual P4Xeon box:
werewolf:~> ssh annwn cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       
  0:    3302667    3295991    3299383    3299984    IO-APIC-edge  timer
  1:       4813       4680       4796       4846    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  8:          1          0          0          0    IO-APIC-edge  rtc
 12:      64959      64803      65238      63623    IO-APIC-edge  PS/2 Mouse
 16:      65038      66347      60169      67167   IO-APIC-level  e100
 17:          0          0          0          0   IO-APIC-level  Intel ICH2
 18:     529910     524941     535660     535544   IO-APIC-level  aic7xxx, eth2
 19:      71883      71973      72540      72460   IO-APIC-level  usb-uhci, eth0
 22:    2497022    2491901    2495182    2495298   IO-APIC-level  nvidia
 23:          0          0          0          0   IO-APIC-level  usb-uhci
NMI:          0          0          0          0 
LOC:   13198438   13198374   13198440   13198453 
ERR:          0
MIS:          0

I think the old one looks much better... ;)

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-pre10-jam3a, Mandrake Linux 8.3 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.4mdk)

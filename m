Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUH1XaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUH1XaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUH1XaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:30:20 -0400
Received: from jam.pd.astro.it ([193.206.241.196]:42455 "EHLO jam.pd.astro.it")
	by vger.kernel.org with ESMTP id S268127AbUH1XaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:30:10 -0400
Message-ID: <1093735779.41311563b892b@webmail.pd.astro.it>
Date: Sun, 29 Aug 2004 01:29:39 +0200
From: biscani@pd.astro.it
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: System freeze: __iounmap: bad address dfd00000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 213.45.28.70
X-OAPD-MailScanner-Information: 
X-OAPD-MailScanner: Found to be clean
X-OAPD-MailScanner-SpamCheck: non spam, SpamAssassin (punteggio=-98.041,
	necessario 6, BAYES_44, NO_REAL_NAME, RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL, USER_IN_WHITELIST)
X-MailScanner-From: biscani@pd.astro.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  
  
today I experienced some system freezes under heavy IO load. I was moving my  
~20GB / to another partition. The system simply stopped responding (twice)  
when I was copying /usr. Unfortunately the freeze was pretty hard, and no  
clues could be gathered from the system logs. Neither ssh-ing from another  
machine worked. I tried with kernels 2.6.8.1-mm3 and 2.6.9-rc1-mm1, same  
behaviour: no hard disk activity and complete freeze.  
  
The two partitions are reiser4, so I'm CCing this message also to  
reiserfs-list.  
  
I don't think it is a FS related problem, though. Firstly because doing  
exactly the same thing on another machine worked ok (I tried 3 times).  
Secondly because of some cryptic messages my system has been giving for some  
time. The message is:  
  
Aug 28 18:43:00 kurtz __iounmap: bad address dfd00000  
  
This is usually repeated 2 or 3 times. According to my logs this started 
happening with 2.6.8.1-mm1. I had never seen it before. This also appeared 
when I was finally able to copy my partition (on the third try). The system 
hanged on shutdown immidiately after though :-/  
  
I googled around for that message, but found nothing, except for some lkml 
activity at the 2.5.25 time and some recent SATA bugs. This hard drive is not 
SATA though. This is the output of my lspci: 
 
0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device cbb2 (rev 02) 
0000:00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M] 
0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02) 
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV] 
0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller 
0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 02) 
0000:00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 50) 
0000:00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 50) 
0000:00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) 
0000:00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 
Controller (PHY/Link) 
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) 
0000:00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU] 
0000:00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller 
0000:01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M 
 
As you can see the IDE subsystem is from ALi. This is an HP laptop which has 
never shown any kind of instability. Also smartmontools say that the hard 
drive is ok. The kernel has been compiled with mregparm=3, but aside from that 
no fancy options has been used. I also tried disabling ide IRQ sharing and 
ACPI, still no luck. Can anyone give me some insight in this? If more 
informations are needed, please let me know. 
 
Thanks very much, 
 
  Francesco 
 
PS: please CC me since I'm not subscribed to lkml. 

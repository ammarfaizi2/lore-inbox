Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132930AbRAJVIR>; Wed, 10 Jan 2001 16:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136405AbRAJVII>; Wed, 10 Jan 2001 16:08:08 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:58201 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132930AbRAJVHy>; Wed, 10 Jan 2001 16:07:54 -0500
From: <tnvander@chello.nl>
To: jbglaw@lug-owl.de
CC: linux-kernel@vger.kernel.org
Subject: RE: Which driver took effect?
Date: Thu, 11 Jan 2001 0:33:22 +0330
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010110210244.FPCE3141.amsmta01-svc@[192.168.2.2]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I looked at some outputs and 
/proc/interrupts
/proc/ioports
/proc/iomem

at least tell you some info, but not consistent (ie, consider:
tnl@anna:~ > cat /proc/interrupts 
           CPU0       
  0:   80119205          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:    3213269          XT-PIC  NE2000
 11:     501898          XT-PIC  eth0
 12:          0          XT-PIC  PS/2 Mouse
 13:          1          XT-PIC  fpu
 14:     445106          XT-PIC  ide0
NMI:          0

tnl@anna:~ > cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0210-021f : 3c509
02f8-02ff : serial(auto)
0300-031f : NE2000
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)

Should I grep for interface name or driver name?? The eth0/3c509 doesn't even report itself the same way in those two lists. That's on kernel 2.2 though. On my other machine with only a tulip card it reported eth0 on all 3 /proc files. Is 2.4 more consistent, or is it a property of the tulip driver to be more consistent?)

If you have two cards which use the same driver, and you build the driver into the kernel (non-modular), you can specify on the kernel commandline which card should be first, second etc. For my case, which is modular, I put the following in /etc/modules.conf:

alias eth0 3c509
alias eth1 ne

Of course, it requires manual configuration per PC and that's probably not what you wanted for a bootdisk...


And scanning dmesg is indeed just the road to ugly hacks, although it does seem common practice to report as <interface:drivername at ...> so that perhaps an interface name can be linked to a drivername and both can be used to scan thru /proc/ioports and /proc/interrupts...   Yes, sounds terribly hacky, sounds like perl or python are wanted for this, sounds like a job too large for a bootdisk...

I'm sorry that I can't help you! I thought that /proc/interrupts etc was good advice and then found out that it's as messy :-(

--Tim




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

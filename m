Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVAMQXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVAMQXi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVAMQV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:21:26 -0500
Received: from dhcp18-126.bio.purdue.edu ([128.210.18.126]:30592 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S261672AbVAMQR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:17:58 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.8 oops all over the place
Date: Thu, 13 Jan 2005 11:17:56 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131117.56998.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I joined the list to hopefully facilitate a response.  
The system is a gateway solo laptop running Mandrake 10.1 with their version 
of the 2.6.8 kernel (2.6.8.1-12mdk).  These kernel oops problems are a recent 
occurance which makes me suspect hardware but I am not sure.

If I run a mandrake 2.6.0-pre2.2 kernel, I do not experience the problem but 
as soon as I bootup to the 2.6.8.1 kernel, I will be lucky to get 10 minutes 
of use out of my system before an oops makes it unusable and it requires a 
hard reboot.  A nice reboot fails to complete around the point that postfix 
is being shutdown and the system just hangs.

Each oops I experience appears to derive from the same general hex address 
space.  The latest/last such oops output (truncated for space) is:

Jan  6 14:23:17 lapdog kernel: Unable to handle kernel paging request at 
virtual address d0bb24b4
Jan  6 14:23:17 lapdog kernel:  printing eip:
Jan  6 14:23:17 lapdog kernel: c012942f
Jan  6 14:23:17 lapdog kernel: *pde = 012f3067
Jan  6 14:23:17 lapdog kernel: *pte = 00000000
Jan  6 14:23:17 lapdog kernel: Oops: 0000 [#2]
Jan  6 14:23:17 lapdog kernel: Modules linked in: ipx isofs 
speedstep-centrinopr
ocessor md5 ipv6 ipmi_msghandler snd-seq-oss snd-seq-midi-event snd-seq 
snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-ac97-codec snd-pcm snd-timer 
snd-page-alloc gameport snd-mpu401-uart snd-rawmidi snd-seq-device snd 
soundcore af_packetfloppy tulip ds yenta_socket pcmcia_core driverloader 
ide-cd cdrom loop nls_iso8859-1 ntfs fglrx intel-agp agpgart e1000 evdev 
ehci-hcd uhci-hcd usbcore ext3jbd
Jan  6 14:23:17 lapdog kernel: CPU:    0
Jan  6 14:23:17 lapdog kernel: EIP:    0060:
[notifier_chain_register+31/64]Taint
ed: P   VLI
Jan  6 14:23:17 lapdog kernel: EIP:    0060:[<c012942f>]    Tainted: P   VLI
Jan  6 14:23:17 lapdog kernel: EFLAGS: 00010286   (2.6.8.1-12mdk)
Jan  6 14:23:17 lapdog kernel: EIP is at notifier_chain_register+0x1f/0x40
Jan  6 14:23:17 lapdog kernel: eax: d0bb24ac   ebx: d0b6b918   ecx: 
00000000edx:  d0e58e8c

Looking in my System map the address above (c012942f and all other oops 
addresses) falls within this range:

c0129330 T synchronize_kernel
c0129370 T inter_module_register
c0129460 T inter_module_unregister  <---
c0129520 T inter_module_get  <---
c0129580 T inter_module_get_request

I have booted up to memtest86+ to test my CPU and RAM and find no problems.  
Nonetheless I am wondering if this problem is a software problem or a 
hardware problem.  

I can generate such an oops by either trying to rmmod any firewire module 
(every time) or semi-randomly by simply starting up KDE 3.2.3 and trying to 
start any one of a handful of KDE apps (konsole in particular though I am not 
certain at this point whether the oops comes just before or as a result of 
starting konsole). 

I would appreciate any guidance anyone is able/willing to toss my way.  I have 
also tried a 2.6.7 multimedia kernel and though I experienced somewhat fewer 
of the oops, they did occur while with the 2.6.0 kernel they are rare and 
usually seem to occur just as the system is about to cut power after 
shutdown.

praedor

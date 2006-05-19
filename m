Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWESRWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWESRWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWESRWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:22:18 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:15444 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751383AbWESRWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:22:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rmd/bU5/N/7YjOwGOU2G6y+JtPx8mD0Bn8lVSwECgaomg4owL5plMT8beV3kKIMdSSLnAGSUUmSjZuEHnW0go7AW9XmXP+C2NfSRO32jKMSe8PIyHV/NxfFFPHsHjIII7G/Y+9LvUTUVlDNpnJcs3b5hp+r42eChXEwG14nNH4E=
Message-ID: <5bdc1c8b0605191022l7114707fjd6b3cdcfe68b97c7@mail.gmail.com>
Date: Fri, 19 May 2006 10:22:17 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>
Subject: 2.6.16-rt22/23 kernels hanging after registering IO schedulers
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo and others,
   It's been quite awhile since I wrote anything here. I have been
using the 2.6.15-rt kernels for audio work on my AMD64 machine, but I
haven't written much music lately so the work load has been very low.
Actually I've found that for light work the standard Gentoo 2.6.16
kernel without -rt patches has been good enough for my real-time needs
of late so thanks to all the kernel developers for those more results
also.

   Working quite nicely on my system are:

2.6.15-rt18
2.6.16-gentoo-r2

   Some Gentoo oriented folks created a new 'pro-audio' overlay which
allows Gentoo users to build both applications and -rt kernels using
normal portage methods. Here's the link:

http://proaudio.tuxfamily.org/wiki/index.php?title=Main_Page

   Since the newest -rt kernels are part of the overlay I thought I'd
give building and booting one a try. At the time the version in the
overlay was 2.6.16-rt22 so I tried that. Unfortunately the boot
process hangs immediately after some messages about registering IO
schedulers.

   My method to build 2.6.16-rt22 was to emerge the source from the
pro-audio overlay, copy the 2.6.15-rt18 .config file, run make
oldconfig, make menuconfig, make && make modules_install, and then
copy the kernel source to /boot.

   My method to build 2.6.16-rt23 was to download linux-2.6.16, unzip
and untar, patch it with the -rt23 patch from your site, then again
use the 2.6.15-rt18 .config file as in the previous paragraph. Same
results.

   I did try changing the default IO Scheduler, as well as leaving a
few out. I still hang at the same place.

   My guess is that it's the step immediately after registering these
schedulers that's hanging but I no longer have a second computer so I
cannot do the console thing with the serial cable. Sorry.

   Again, no serious problems for me since both 2.6.15-rt18 &
2.6.16-gentoo-r2 are working great, but I thought I should at least
report this to see if there is some known thing I need to change or,
if not, make sure you are aware of the problem.

   Here's some very basic info about the hardware

lightning ~ # lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
Audio Contro ller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTra nsport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Con troller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscella neous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60
[Radeon X300 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
05:06.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 68)
05:08.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer C ontroller (rev 01)
lightning ~ #

   As always, thanks for all your work on kernels for us audio folks.
I'm sure we don't say thanks enough. Sorry about that.

Cheers,
Mark

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSCaBoA>; Sat, 30 Mar 2002 20:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSCaBnl>; Sat, 30 Mar 2002 20:43:41 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:61956 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S311206AbSCaBnd>; Sat, 30 Mar 2002 20:43:33 -0500
From: "Steven A. DuChene" <linux-clusters@mindspring.com>
Date: Sat, 30 Mar 2002 20:43:34 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre2 locks up hard with rivafb
Message-ID: <20020330204334.N13832@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual Pentium Pro 200MHz system with a STB Velocity 128 PCI
video card. This card has a Riva 128 chip on it and shows up in
/proc/pci as

  Bus  0, device  15, function  0:
    VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 16).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xef000000 [0xefffffff].
      Prefetchable 32 bit memory at 0xee000000 [0xeeffffff].

When I boot up 2.4.19-pre1 with the rivafb driver compiled into the kernel
I get the following:

Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
rivafb: RIVA MTRR set to ON
fbcon_setup: No support for fontwidth 8
fbcon_setup: type 0 (aux 0, depth 15) not supported
Console: switching to colour frame buffer device 160x64
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 4MB @ 0xEE000000)

This is with a append line in lilo.conf as

video=riva:1280x1024-15@74

If I boot into 2.4.19-pre2 when the rivag=fb is also compiled into the kernel
the systems locks up hard after:

Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
rivafb: RIVA MTRR set to ON

I found this much by altering the append line to send the comsole to the
serial port.

Even if I remove the "video=blah" line from lilo.conf the system still locks
hard if the rivafb driver is present. System boots fine if the frame buffer
stuff is disabled.

I traced this down to the change between 2.4.19-pre1 and 2.4.19-pre2 because
the same hard lock up happened with 2.4.19-pre4-ac3 earlier today.

Thing is there is no change to the rivafb code in 2.4.19-pre2

Any ideas about wehat could cause this or what I should try?
-- 
Steven A. DuChene      linux-clusters@mindspring.com
                      sduchene@mindspring.com

        http://www.mindspring.com/~sduchene/

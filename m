Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271618AbRHUJEH>; Tue, 21 Aug 2001 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRHUJD6>; Tue, 21 Aug 2001 05:03:58 -0400
Received: from munk.apl.washington.edu ([128.95.96.184]:64137 "EHLO
	munk.apl.washington.edu") by vger.kernel.org with ESMTP
	id <S271618AbRHUJDj>; Tue, 21 Aug 2001 05:03:39 -0400
Date: Tue, 21 Aug 2001 05:01:53 -0700 (PDT)
From: Brian Dushaw <dushaw@apl.washington.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.8-ac8, agpgart, r128, and mtrr
Message-ID: <Pine.LNX.4.33.0108210423110.3231-100000@munk.apl.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had a few problems/issues in implementing kernel 2.4.8-ac8
(and others) and getting agpgart/r128 to work.  I've continued the insanity of
chasing the latest and greatest upgrades, and upgraded to XFree86 4.1.
But I had a similar experience with 4.0.

I have an ATI Technologies Inc Rage 128 PF video card.
The module r128.o needs to have agpgart loaded first and depmod
does not seem to set this up properly.  I've added the line:
"pre-install r128 modprobe agpgart " to my /etc/modules.conf file.
I wouldn't have thought this would require user intervention like this.

My motherboard is FIC AD11 with the AMD 760 chipset, so I had to add
"options agpgart agp_try_unsupported=1" to my /etc/modules.conf file,
which seems to work o.k.
[/proc/pci gives:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] System Controller (rev 19).      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
      Prefetchable 32 bit memory at 0xdb001000 [0xdb001fff].
      I/O at 0xa000 [0xa003].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] AGP Bridge (rev 0).
      Master Capable.  Latency=32.  Min Gnt=14.
  Bus  0, device   7, function  0:
to be precise.]

When agpgart and r128 modules are loaded there are some mtrr complaints
of which I know nothing.  dmesg gives:

mtrr: type mismatch for d4000000,2000000 old: uncachable new: write-combining
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Trying generic AMD routines for device id: 700e
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on AMD @ 0xd0000000 64MB
mtrr: type mismatch for d0000000,4000000 old: uncachable new: write-combining
[drm] Initialized r128 2.1.6 20010405 on minor 0
mtrr: type mismatch for d4000000,2000000 old: uncachable new: write-combining
mtrr: type mismatch for d4000000,2000000 old: uncachable new: write-combining
mtrr: type mismatch for d4000000,2000000 old: uncachable new: write-combining

/var/log/messages gives:
Aug 20 13:04:37 localhost modprobe: modprobe: Can't locate module block-major-33
Aug 20 13:04:40 localhost kernel: mtrr: type mismatch for d4000000,2000000 old: uncachable new: write-combining
Aug 20 13:04:40 localhost modprobe: modprobe: Can't locate module char-major-226
Aug 20 13:04:40 localhost modprobe: modprobe: Can't locate module char-major-226
Aug 20 13:04:40 localhost kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Aug 20 13:04:40 localhost kernel: agpgart: Maximum main memory to use for agp memory: 203M
Aug 20 13:04:40 localhost kernel: agpgart: Trying generic AMD routines for device id: 700e
Aug 20 13:04:40 localhost kernel: agpgart: AGP aperture is 64M @ 0xd0000000
Aug 20 13:04:40 localhost kernel: [drm] AGP 0.99 on AMD @ 0xd0000000 64MB
Aug 20 13:04:40 localhost kernel: mtrr: type mismatch for d0000000,4000000 old: uncachable new: write-combining
Aug 20 13:04:40 localhost kernel: [drm] Initialized r128 2.1.6 20010405 on minor 0
Aug 20 13:04:40 localhost kernel: mtrr: type mismatch for d4000000,2000000 old: uncachable new: write-combining
Aug 20 13:04:42 localhost last message repeated 2 times


Lastly, for all that, agpgart doesn't seem to do much for me -
when loaded in, lsmod shows it as being unused, if r128 is not
loaded.  I have the XFree86 glx module loaded, I think.  I think I don't
understand this at all... without the dri modules agpgart seems
innocuous...so why bother?

Anyways, that's my experience with this; I thought the report would be worthwhile.
-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Brian Dushaw
Applied Physics Laboratory
University of Washington
1013 N.E. 40th Street
Seattle, WA  98105-6698
(206) 685-4198   (206) 543-1300
(206) 543-6785 (fax)
dushaw@apl.washington.edu

Web Page:  http://staff.washington.edu/dushaw/index.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272882AbRIXVkR>; Mon, 24 Sep 2001 17:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272829AbRIXVkI>; Mon, 24 Sep 2001 17:40:08 -0400
Received: from adsl-64-164-47-8.dsl.scrm01.pacbell.net ([64.164.47.8]:36859
	"EHLO satan.diablo.localnet") by vger.kernel.org with ESMTP
	id <S272795AbRIXVj7>; Mon, 24 Sep 2001 17:39:59 -0400
Date: Mon, 24 Sep 2001 14:40:06 -0700
To: linux-kernel@vger.kernel.org
Subject: report: success with agp_try_unsupported=1
Message-ID: <20010924144006.A13695@dirac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Peter Jay Salzman <p@dirac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear all,

i just built a system:

	1.3GHz amd athlon
	epox 8kha ddr motherboard
		via kt266 (vt8366, vt8233)
	768MB ddr ram
	radeon QD with 64MB video buffer, tvio

i enabled agpgart, and got the message:


  Linux agpgart interface v0.99 (c) Jeff Hartmann
  agpgart: Maximum main memory to use for agp memory: 690M
  agpgart: Unsupported Via chipset (device id: 3099), you might want to try
    agp_try_unsupported=1.
  agpgart: no supported devices found.
  [drm] Initialized radeon 1.1.1 20010405 on minor 0


i rebuilt the kernel with agpgart built as a module.  rebooted.  loaded the
agp module with:

  insmod /usr/src/linux-2.4.9/drivers/char/agp/agpgart.o agp_try_unsupported=1

loaded the radeon driver with:

  insmod /usr/src/linux-2.4.9/drivers/char/drm/radeon.o

this was successful -- DRI was enabled when i started X (and i played quake3
to reward myself).

i read that success with agp_try_unsupported=1 should be reported here, so
i'm reporting it.  please feel free to ask further questions if you want to
know about my hardware.

i do have 2 questions:

1. modprobe didn't seem to know where agpgart.o and radeon.o lives, so i had
   to resort to insmod.  is there a way of telling modprobe where to look for
   modules?

2. i recompiled the kernel but built agpgart in rather than loading it as a
   module.  i then inserted the following line into /etc/lilo.conf:

      append="agp_try_unsupported=1"

   but it didn't seem to work.  someone told me that to get agp work to work
   for my system, agpgart MUST be built as a module and you MUST pass it the
   argument agp_try_unsupported=1.  in other words, you can't build it into
   the kernel and pass the argument as a kernel parameter at boot time.

   is that true?

please cc replies to p@dirac.org.

thanks guys!
pete

-- 
"You may not use the Software in connection with any site that disparages
Microsoft, MSN, MSNBC, Expedia, or their products or services ..."
                    -- Clause from license for FrontPage 2002

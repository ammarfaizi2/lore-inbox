Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283310AbRLDSvC>; Tue, 4 Dec 2001 13:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282392AbRLDStq>; Tue, 4 Dec 2001 13:49:46 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:30103 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S283288AbRLDSsP>; Tue, 4 Dec 2001 13:48:15 -0500
Date: Tue, 4 Dec 2001 18:49:25 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][CFT] x86 setup 2.2 backport
Message-ID: <20011204184925.A7495@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently backported a lot of stuff from 2.4's setup.c and friends
back to 2.2.20. Some of this stuff hasn't been updated since ~2.3.99
or so, which was just before hpa's big cleanup in that area.

The feedback I got from the first version of this patch was pretty
good, the only really missing bit being the cache-sizing looked odd
on P4's. Unless someone shouts too loudly, I'll push this to Alan
at some point soon.

regards,
Dave.

Patch is against 2.2.20, and is available for download from
 http://www.codemonkey.org.uk/patches/2.2/x86resync-2.diff


Summary of changes:
x86resync-2.diff
- Extra AMD K5 support.
- Backport improved Intel cache sizing (Should work better for P4).
- Small amd_init() improvements to match 2.4.

x86resync-1.diff
- updated bluesmoke.c
  - MSR number typo bugfix
  - extra non-Intel architecture support.
- setup.c
  - P4 right justified name string fixup
  - Fix up c->x86_cache_size on machines with 0K L2 cache
  - Fix up cache size on Cyrix MediaGx
  - Enable MMX extensions on MII (Alan)
  - Fix up misplaced brace in Cyrix setup path.
  - Add recognition of RiSE CPUs.
  - Update cpuid_level when disabling serial number (Hugh Dickins)
  - Initialise Centaur CPUs from the same codepath as the other vendors
    instead of in print_cpu_info()
  - Recognise all types of Celerons/Mobile PII's
  - boottime 'serialnumber' option to leave serial # enabled.
  - Improved Centaur Winchip handling.
  - Recognise 386/486 in c->x86_model_id (Cesar Barros)
  - Several bug workarounds moved from bugs.h to setup.c
  - Other small cleanups.
  - Overall source cleaning to bring in line with 2.4

- drivers/char/random.c drivers/char/mem.c
  arch/i386/mtrr.c, msr.c, time.c, microcode.c
  - uses test/clear/set bit macros

The 2.4 stuff is still cleaner than 2.2's, but this at least
gets things a lot closer to each other making any future resyncs easier.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

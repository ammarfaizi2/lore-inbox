Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbTCMXvS>; Thu, 13 Mar 2003 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262605AbTCMXvS>; Thu, 13 Mar 2003 18:51:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11195 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262583AbTCMXvQ>;
	Thu, 13 Mar 2003 18:51:16 -0500
Message-ID: <3E711C0A.40705@pobox.com>
Date: Thu, 13 Mar 2003 19:02:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] rng driver update
Content-Type: multipart/mixed;
 boundary="------------030605000307070206080407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605000307070206080407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030605000307070206080407
Content-Type: text/plain;
 name="random-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="random-2.5.txt"

Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/random-2.5

This will update the following files:

 Documentation/i810_rng.txt     |  134 ------
 drivers/char/amd768_rng.c      |  295 --------------
 drivers/char/i810_rng.c        |  404 -------------------
 Documentation/hw_random.txt    |  134 ++++++
 arch/i386/kernel/cpu/centaur.c |   47 +-
 arch/i386/kernel/cpu/common.c  |    5 
 arch/i386/kernel/cpu/proc.c    |   15 
 drivers/char/Kconfig           |   37 -
 drivers/char/Makefile          |    3 
 drivers/char/hw_random.c       |  846 +++++++++++++++++++++++++++++++++++------
 include/asm-i386/cpufeature.h  |   10 
 include/asm-i386/msr.h         |    1 
 12 files changed, 940 insertions(+), 991 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/03/13 1.1109)
   [hw_random] fixes and cleanups
   
   * s/Via/VIA/
   * allow multiple simultaneous open(2)s of the chrdev.  This allows
   us to eliminate some code, without modifying the core code (rng_dev_read)
   at all.
   * s/__exit// in ->cleanup ops, to eliminate link error

<jgarzik@redhat.com> (03/03/13 1.1108)
   [hw_random] add support for VIA Nehemiah RNG ("xstore" instruction)

<jgarzik@redhat.com> (03/03/13 1.1107)
   [ia32] cpu capabilities cleanups and additions
   
   * Add support for new Centaur(VIA) and Intel cpuid feature bits,
     expanding the x86_capability array by two.
   * (cleanup) Move cpu setup for newer Via C3 cpus into its own
     function, init_c3()
   * Add support for RNG control msr on VIA Nehemiah
   * export X86_FEATURE_XSTORE and cpu_has_xstore macros so that
     kernel code may easily test for cpu support of the new
     "xstore" instruction.

<jgarzik@redhat.com> (03/03/13 1.1106)
   [hw_random] update amd768_rng driver to be modular; add Intel support
   
   Take Alan's amd768_rng driver, recently renamed to hw_random.c,
   and convert it's very-simple structure to support multiple
   types of hardware RNG.  Integrate Intel i8xx (ICH) RNG support.

<jgarzik@redhat.com> (03/03/13 1.1105)
   [hw_random] shuffle files in preparation for hw_random driver update
   
   Delete drivers/char/i810_rng.c, superceded.
   Rename Doc/i810_rng.txt to Doc/hw_random.txt.
   Rename drv/char/amd768_rng.c to drv/char/hw_random.c.


--------------030605000307070206080407--


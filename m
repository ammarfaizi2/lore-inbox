Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262993AbTCLDNn>; Tue, 11 Mar 2003 22:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262995AbTCLDNn>; Tue, 11 Mar 2003 22:13:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20891 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262993AbTCLDNl>;
	Tue, 11 Mar 2003 22:13:41 -0500
Message-ID: <3E6EA874.4000508@pobox.com>
Date: Tue, 11 Mar 2003 22:24:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, linus@pobox.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [patch 0/3][RFT] hardware RNG driver updates
Content-Type: multipart/mixed;
 boundary="------------010808000607050705040100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808000607050705040100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rather than create yet another cut-n-paste driver, for Via's new on-CPU 
RNG that just appeared on the market, I took the opportunity to update 
the existing RNG drivers, and take advantage of code sharing.  I wrote 
the Intel RNG driver along with Philip Rumpf, and Alan copied that, made 
several smart improvements, and create the AMD RNG driver.

So in turn, I took Alan's AMD RNG driver, welded Intel bits into it, and 
in the end wound up with a modular driver.  Then I added Via RNG support 
onto the top of the whole mess.

The first patch shuffles around files, and isn't interesting.
The second patch updates Alan's AMD driver to become the new and modular 
hw_random.c driver.
The third patch adds Via RNG support, which is based around a neat new 
"xstore" instruction.  More details on that, and code, are in the email 
accompanying the patch.

The hardware RNG API as presented to userland is very simple:  userland 
read(2) from an infinite tap of random data, straight from the hardware 
RNG.  If you want "bare metal" speed, that's all you need to do.  Most 
people, however, will want to use the "rng daemon", which reads from the 
hardware RNG, performs some sanity checks, and then injects the data 
from the hardware RNG into the kernel's /dev/[u]random pool.  The kernel 
"stirs" that input data along with other in-kernel entropy sources, and 
the end result is a faster /dev/[u]random.

It needs a good bit of public testing, comment and review, so it won't 
be backported to 2.4.x for a little while yet.  Testing especially on 
AMD RNG is requested.  But please do consider it for inclusion in 2.5.x.

Comments welcome!

	Jeff



--------------010808000607050705040100
Content-Type: text/plain;
 name="misc-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.5.txt"

BK info:

	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5

This will update the following files:

 Documentation/i810_rng.txt     |  134 ------
 drivers/char/amd768_rng.c      |  295 ---------------
 drivers/char/i810_rng.c        |  404 --------------------
 Documentation/hw_random.txt    |  134 ++++++
 arch/i386/kernel/cpu/centaur.c |   46 +-
 arch/i386/kernel/cpu/proc.c    |    3 
 drivers/char/Kconfig           |   33 -
 drivers/char/Makefile          |    3 
 drivers/char/hw_random.c       |  804 +++++++++++++++++++++++++++++++++++++----
 include/asm-i386/cpufeature.h  |    3 
 include/asm-i386/msr.h         |    1 
 11 files changed, 906 insertions(+), 954 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/03/11 1.1103)
   [hw_random] add support for Via Nehemiah RNG ("xstore" insn)

<jgarzik@redhat.com> (03/03/11 1.1102)
   [hw_random] update Alan's amd rng driver with bits from i810 rng driver,
   to form new modular hw_random driver.

<jgarzik@redhat.com> (03/03/11 1.1101)
   [hw_random] shuffle files
   
   Delete drivers/char/i810_rng.c, superceded.
   Rename Doc/i810_rng.txt to Doc/hw_random.txt.
   Rename drv/char/amd768_rng.c to drv/char/hw_random.c.


--------------010808000607050705040100--


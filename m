Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUDPXJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUDPXJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:09:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:35301 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263932AbUDPXJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:09:51 -0400
Date: Fri, 16 Apr 2004 16:04:34 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] use Kconfig.debug (v4)
Message-Id: <20040416160434.0faeca5d.rddunlap@osdl.org>
In-Reply-To: <200404162343.43594@WOLK>
References: <20040415220338.3e351293.rddunlap@osdl.org>
	<20040416110149.3e353333.rddunlap@osdl.org>
	<20040416142206.02848d89.rddunlap@osdl.org>
	<200404162343.43594@WOLK>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 23:43:43 +0200 Marc-Christian Petersen wrote:

| On Friday 16 April 2004 23:22, Randy.Dunlap wrote:
| 
| Hey Randy,
| 
| > Here is my v2-to-v3 update patch, incorporating Marc's suggestions
| > with a few small additions as mentioned in my comments above.
| 
| cool.
| 
| Completely fine with me now. Thank you. If no one else objects, please merge 
| it up Andrew.


Let's try one more, more like your very first suggestion of using
lib/Kconfig.debug for everything.  Only difference is that I added
(kept) a new menu level for each arch in the generic Kernel hacking
menu.  Only the expected one shows up in menuconfig.
In xconfig, with Show All Options enabled, each arch menu is
selectable, but each config item doesn't show up unless requested.
I didn't have this new menu level in my first attempt, so it
looked less acceptable, but this is the best solution yet, I think.

Other comments?

Rolled up patch against 2.6.6-rc1:
http://developer.osdl.org/rddunlap/patches/kconf_debug_1file_266rc1.patch


 arch/alpha/Kconfig           |  104 ---------------------
 arch/alpha/Kconfig.debug     |   54 +++++++++++
 arch/arm/Kconfig             |  160 ---------------------------------
 arch/arm/Kconfig.debug       |  113 +++++++++++++++++++++++
 arch/arm26/Kconfig           |  113 -----------------------
 arch/arm26/Kconfig.debug     |   58 ++++++++++++
 arch/cris/Kconfig            |   14 --
 arch/cris/Kconfig.debug      |   14 ++
 arch/h8300/Kconfig           |   72 --------------
 arch/h8300/Kconfig.debug     |   66 +++++++++++++
 arch/i386/Kconfig            |  125 -------------------------
 arch/i386/Kconfig.debug      |   14 ++
 arch/ia64/Kconfig            |  114 -----------------------
 arch/ia64/Kconfig.debug      |   62 ++++++++++++
 arch/m68k/Kconfig            |   38 -------
 arch/m68k/Kconfig.debug      |    8 +
 arch/m68knommu/Kconfig       |   55 -----------
 arch/m68knommu/Kconfig.debug |   41 ++++++++
 arch/mips/Kconfig            |  111 -----------------------
 arch/mips/Kconfig.debug      |   66 +++++++++++++
 arch/parisc/Kconfig          |   49 ----------
 arch/parisc/Kconfig.debug    |    5 +
 arch/ppc/Kconfig             |  124 -------------------------
 arch/ppc/Kconfig.debug       |   71 ++++++++++++++
 arch/ppc64/Kconfig           |   80 ----------------
 arch/ppc64/Kconfig.debug     |   26 +++++
 arch/s390/Kconfig            |   56 -----------
 arch/s390/Kconfig.debug      |    6 +
 arch/sh/Kconfig              |  140 -----------------------------
 arch/sh/Kconfig.debug        |  110 ++++++++++++++++++++++
 arch/sparc/Kconfig           |   72 --------------
 arch/sparc/Kconfig.debug     |   13 ++
 arch/sparc64/Kconfig         |   99 --------------------
 arch/sparc64/Kconfig.debug   |   37 +++++++
 arch/um/Kconfig              |   60 ------------
 arch/um/Kconfig.debug        |   34 +++++++
 arch/v850/Kconfig            |   29 ------
 arch/v850/Kconfig.debug      |    9 +
 arch/x86_64/Kconfig          |  101 --------------------
 arch/x86_64/Kconfig.debug    |   46 +++++++++
 init/Kconfig                 |    8 -
 lib/Kconfig.debug            |  207 +++++++++++++++++++++++++++++++++++++++++++
 42 files changed, 1080 insertions(+), 1704 deletions(-)


--
~Randy

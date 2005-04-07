Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVDGQhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVDGQhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVDGQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:37:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46290 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262514AbVDGQgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:36:49 -0400
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <Pine.LNX.4.61.0504070219160.15339@scrub.home>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
	 <42544D7E.1040907@linux-m68k.org> <1112821319.14584.28.camel@localhost>
	 <Pine.LNX.4.61.0504070133380.25131@scrub.home>
	 <1112831857.14584.43.camel@localhost>
	 <Pine.LNX.4.61.0504070219160.15339@scrub.home>
Content-Type: multipart/mixed; boundary="=-+NT4aJDhSPSrBstK9P2p"
Date: Thu, 07 Apr 2005 09:36:38 -0700
Message-Id: <1112891799.21749.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+NT4aJDhSPSrBstK9P2p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Roman,

How does the attached patch look?  It will still give us the flexibility
to override the memory models, but only in the presence of
CONFIG_EXPERIMENTAL.

It also adds some better help text to the DISCONTIGMEM menu.  Is that
something like what you were looking  for?

-- Dave

--=-+NT4aJDhSPSrBstK9P2p
Content-Disposition: attachment; filename=Kconfig-experimental.patch
Content-Type: text/x-patch; name=Kconfig-experimental.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 memhotplug-dave/mm/Kconfig |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff -puN mm/Kconfig~Kconfig-experimenta mm/Kconfig
--- memhotplug/mm/Kconfig~Kconfig-experimenta	2005-04-07 09:24:59.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-04-07 09:32:06.000000000 -0700
@@ -1,9 +1,10 @@
 choice
 	prompt "Memory model"
-	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
-	default FLATMEM
+	depends on EXPERIMENTAL
+	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
+	default FLATMEM_MANUAL
 
-config FLATMEM
+config FLATMEM_MANUAL
 	bool "Flat Memory"
 	depends on !ARCH_DISCONTIGMEM_ENABLE || ARCH_FLATMEM_ENABLE
 	help
@@ -14,14 +15,32 @@ config FLATMEM
 
 	  If unsure, choose this option over any other.
 
-config DISCONTIGMEM
+config DISCONTIGMEM_MANUAL
 	bool "Discontigious Memory"
 	depends on ARCH_DISCONTIGMEM_ENABLE
 	help
+	  This option provides enhanced support for discontiguous
+	  memory systems, over FLATMEM.  These systems have holes
+	  in their physical address spaces, and this option provides
+	  more efficient handling of these holes.  However, the vast
+	  majority of hardware has quite flat address spaces, and
+	  can have degraded performance from extra overhead that
+	  this option imposes.
+
+	  Many NUMA configurations will have this as the only option.
+
 	  If unsure, choose "Flat Memory" over this option.
 
 endchoice
 
+config DISCONTIGMEM
+	def_bool y
+	depends on (!EXPERIMENTAL && ARCH_DISCONTIGMEM_ENABLE) || DISCONTIGMEM_MANUAL
+
+config FLATMEM
+	def_bool y
+	depends on !DISCONTIGMEM || FLATMEM_MANUAL
+
 #
 # Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
 # to represent different areas of memory.  This variable allows
_

--=-+NT4aJDhSPSrBstK9P2p--


Return-Path: <linux-kernel-owner+w=401wt.eu-S932774AbWLNPRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbWLNPRp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLNPRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:17:45 -0500
Received: from thunk.org ([69.25.196.29]:36242 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774AbWLNPRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:17:44 -0500
X-Greylist: delayed 1351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 10:17:44 EST
Date: Thu, 14 Dec 2006 10:17:45 -0500
From: Theodore Tso <tytso@mit.edu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Franck Pommereau <pommereau@univ-paris12.fr>, linux-kernel@vger.kernel.org
Subject: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config options
Message-ID: <20061214151745.GC9079@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Franck Pommereau <pommereau@univ-paris12.fr>,
	linux-kernel@vger.kernel.org
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org> <45813E67.80709@univ-paris12.fr> <1166098747.27217.1018.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166098747.27217.1018.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd be happy to know how to enable it.
>
> CONFIG_HIGHMEM64G=y

This is not at all obvious from arch/i386/Kconfig.  Maybe we should
fix this?

					- Ted

Add an explanation that HIGHMEM64G is needed in order to get support
for the NX feature.

Remove an (incorrect) assertion that NOHIGHMEM is right for more
users, since most systems are coming with at least 1G of memory these
days, and even some laptops have up 4G of memory.

Finally, although the explanation of the 1G/3G split is correct, it is
not relevant to the NOHIGHMEM/HIGHMEM4G/HIGHMEM64G discussion, since
the each process will always see 3GB of virtual memory.  It also might
be something else depending on the setting of CONFIG_VMSPLIT_*.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 arch/i386/Kconfig |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8ff1c6f..4b8f156 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -457,22 +457,21 @@ config NOHIGHMEM
 	  "high memory".
 
 	  If you are compiling a kernel which will never run on a machine with
-	  more than 1 Gigabyte total physical RAM, answer "off" here (default
-	  choice and suitable for most users). This will result in a "3GB/1GB"
-	  split: 3GB are mapped so that each process sees a 3GB virtual memory
-	  space and the remaining part of the 4GB virtual memory space is used
-	  by the kernel to permanently map as much physical memory as
-	  possible.
+	  more than 1 Gigabyte total physical RAM, answer "off" here.
 
 	  If the machine has between 1 and 4 Gigabytes physical RAM, then
 	  answer "4GB" here.
 
 	  If more than 4 Gigabytes is used then answer "64GB" here. This
 	  selection turns Intel PAE (Physical Address Extension) mode on.
-	  PAE implements 3-level paging on IA32 processors. PAE is fully
+	  PAE implements 3-level paging on IA32 processors.  PAE is fully
 	  supported by Linux, PAE mode is implemented on all recent Intel
-	  processors (Pentium Pro and better). NOTE: If you say "64GB" here,
-	  then the kernel will not boot on CPUs that don't support PAE!
+	  processors (Pentium Pro and better).  PAE support is also needed
+	  if you wish to enable NX support, to make your system more secure by
+	  enabling non-executable stacks.
+
+	  NOTE: If you say "64GB" here, then the kernel will not boot
+	  on CPUs that don't support PAE!
 
 	  The actual amount of total physical memory will either be
 	  auto detected or can be forced by using a kernel command line option
-- 
1.4.1


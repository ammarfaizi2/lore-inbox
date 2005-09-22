Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVIVFO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVIVFO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIVFO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:14:28 -0400
Received: from xenotime.net ([66.160.160.81]:6313 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965198AbVIVFO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:14:27 -0400
Date: Wed, 21 Sep 2005 22:14:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Len Brown <len.brown@intel.com>
Cc: zippel@linux-m68k.org, viro@ZenIV.linux.org.uk, Eric.Piel@lifl.fr,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
Message-Id: <20050921221426.7ccdeac7.rdunlap@xenotime.net>
In-Reply-To: <1126821915.31252.10.camel@toshiba>
References: <Pine.LNX.4.61.0509091854500.3743@scrub.home>
	<1126821915.31252.10.camel@toshiba>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 18:05:15 -0400 Len Brown wrote:

> On Fri, 2005-09-09 at 12:55 -0400, Roman Zippel wrote:
> > Hi,
> > 
> > On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> > 
> > > Sigh...  It should be left as #if, of course, but I suspect that
> > cleaner way to
> > > deal with that would be (in Kconfig)
> > >
> > > config ACPI_BLACKLIST_YEAR
> > >         int "Disable ACPI for systems before Jan 1st this year" if
> > X86
> > >         default 0
> > 
> > That would be indeed the better fix.
> 
> The real bug is that drivers/acpi/blacklist.c (the only place
> CONFIG_ACPI_BLACLIST_YEAR is referenced) is compiled for non X86.

You want this then?
---

From: Randy Dunlap <rdunlap@xenotime.net>

Only build drivers/acpi/blacklist.o on X86 (includes X86_64).

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/acpi/Makefile |    2 ++
 1 files changed, 2 insertions(+)

diff -Naurp linux-2614-rc2/drivers/acpi/Makefile~blacklist_x86 linux-2614-rc2/drivers/acpi/Makefile
--- linux-2614-rc2/drivers/acpi/Makefile~blacklist_x86	2005-09-21 22:11:23.000000000 -0700
+++ linux-2614-rc2/drivers/acpi/Makefile	2005-09-21 22:11:41.000000000 -0700
@@ -16,7 +16,9 @@ EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
 # ACPI Boot-Time Table Parsing
 #
 obj-y				+= tables.o
+ifdef CONFIG_X86
 obj-y				+= blacklist.o
+endif
 
 #
 # ACPI Core Subsystem (Interpreter)

---

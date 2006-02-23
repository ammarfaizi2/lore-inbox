Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWBWQne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWBWQne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbWBWQnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:43:33 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:65247 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751736AbWBWQnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:43:33 -0500
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
In-Reply-To: <200602231700.36333.ak@suse.de>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	 <1140707358.4672.67.camel@laptopd505.fenrus.org>
	 <200602231700.36333.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 17:43:20 +0100
Message-Id: <1140713001.4672.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 17:00 +0100, Andi Kleen wrote:
> On Thursday 23 February 2006 16:09, Arjan van de Ven wrote:
> 
> > This patch puts the infrastructure in place to allow for a reordering of
> > functions based inside the vmlinux. The general idea is that it is possible
> > to put all "common" functions into the first 2Mb of the code, so that they
> > are covered by one TLB entry. This as opposed to the current situation where
> > a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
> > (This patch depends on the previous patch to pin head.S as first in the order)
> 
> I think you would first need to move the code first for that. Currently it starts
> at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
> 
> I wouldn't have a problem with moving the 64bit kernel to 2MB though.

that was easy since it's a Config entry already ;)


---


As suggested by Andi (and Alan), move the default kernel location
from 1Mb to 2Mb, to align to the start of a TLB entry.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-reorder/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.16-reorder.orig/arch/x86_64/Kconfig
+++ linux-2.6.16-reorder/arch/x86_64/Kconfig
@@ -444,10 +444,10 @@ config CRASH_DUMP
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
 	default "0x1000000" if CRASH_DUMP
-	default "0x100000"
+	default "0x200000"
 	help
 	  This gives the physical address where the kernel is loaded. Normally
-	  for regular kernels this value is 0x100000 (1MB). But in the case
+	  for regular kernels this value is 0x200000 (2MB). But in the case
 	  of kexec on panic the fail safe kernel needs to run at a different
 	  address than the panic-ed kernel. This option is used to set the load
 	  address for kernels used to capture crash dump on being kexec'ed


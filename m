Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVKGRkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVKGRkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVKGRkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:40:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:46000 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965209AbVKGRkB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:40:01 -0500
Date: Mon, 7 Nov 2005 09:39:48 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] Memory Add Fixes for ppc64
Message-ID: <20051107173948.GB5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051104232109.GE25545@w-mikek2.ibm.com> <17262.42750.810366.294231@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17262.42750.810366.294231@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:59:42AM +1100, Paul Mackerras wrote:
> Mike Kravetz writes:
> > ppc64 needs a special sysfs probe file for adding new memory.
> 
> Does arch/powerpc/Kconfig need a similar fix then?

Yes it does.  Sorry, I haven't been paying as much attention to the
merge as I should.  Here is a new version.

ppc64 needs a special sysfs probe file for adding new memory.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git7/arch/powerpc/Kconfig linux-2.6.14-git7.work/arch/powerpc/Kconfig
--- linux-2.6.14-git7/arch/powerpc/Kconfig	2005-11-04 21:21:05.000000000 +0000
+++ linux-2.6.14-git7.work/arch/powerpc/Kconfig	2005-11-07 17:32:45.000000000 +0000
@@ -569,6 +569,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
 # between a node's start and end pfns, it may not
diff -Naupr linux-2.6.14-git7/arch/ppc64/Kconfig linux-2.6.14-git7.work/arch/ppc64/Kconfig
--- linux-2.6.14-git7/arch/ppc64/Kconfig	2005-11-04 21:21:06.000000000 +0000
+++ linux-2.6.14-git7.work/arch/ppc64/Kconfig	2005-11-07 17:31:51.000000000 +0000
@@ -277,6 +277,10 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
+config ARCH_MEMORY_PROBE
+	def_bool y
+	depends on MEMORY_HOTPLUG
+
 # Some NUMA nodes have memory ranges that span
 # other nodes.  Even though a pfn is valid and
 # between a node's start and end pfns, it may not

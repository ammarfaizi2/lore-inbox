Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbVKGVtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbVKGVtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVKGVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:49:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:64648 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965085AbVKGVtI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:49:08 -0500
Date: Mon, 7 Nov 2005 13:48:59 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
Message-ID: <20051107214859.GD5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051104231800.GB25545@w-mikek2.ibm.com> <1131149070.29195.41.camel@gaston> <20051107204743.GC5821@w-mikek2.ibm.com> <1131397976.4652.52.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131397976.4652.52.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 08:12:56AM +1100, Benjamin Herrenschmidt wrote:
> Yes, the MAX_ORDER should be different indeed. But can Kconfig do that ?
> That is have the default value be different based on a Kconfig option ?
> I don't see that ... We may have to do things differently here...

This seems to be done in other parts of the Kconfig file.  Using those
as an example, this should keep the MAX_ORDER block size at 16MB.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git7.64k/arch/powerpc/Kconfig linux-2.6.14-git7.64k.work/arch/powerpc/Kconfig
--- linux-2.6.14-git7.64k/arch/powerpc/Kconfig	2005-11-07 18:38:50.000000000 +0000
+++ linux-2.6.14-git7.64k.work/arch/powerpc/Kconfig	2005-11-07 21:37:21.000000000 +0000
@@ -463,6 +463,7 @@ source "fs/Kconfig.binfmt"
 config FORCE_MAX_ZONEORDER
 	int
 	depends on PPC64
+	default "9" if PPC_64K_PAGES
 	default "13"
 
 config MATH_EMULATION
diff -Naupr linux-2.6.14-git7.64k/arch/ppc64/Kconfig linux-2.6.14-git7.64k.work/arch/ppc64/Kconfig
--- linux-2.6.14-git7.64k/arch/ppc64/Kconfig	2005-11-07 18:38:50.000000000 +0000
+++ linux-2.6.14-git7.64k.work/arch/ppc64/Kconfig	2005-11-07 21:36:42.000000000 +0000
@@ -56,6 +56,7 @@ config PPC_STD_MMU
 # max order + 1
 config FORCE_MAX_ZONEORDER
 	int
+	default "9" if PPC_64K_PAGES
 	default "13"
 
 source "init/Kconfig"

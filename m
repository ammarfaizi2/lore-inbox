Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTELSlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTELSlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:41:22 -0400
Received: from palrel13.hp.com ([156.153.255.238]:21672 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262434AbTELSlU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:41:20 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16063.60859.712283.537570@napali.hpl.hp.com>
Date: Mon, 12 May 2003 11:53:47 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Dave Jones <davej@codemonkey.org.uk>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <1052690133.10752.176.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 11 May 2003 23:55:33 +0200, Michel Dänzer <michel@daenzer.net> said:

  >> OK, we have a chicken & egg problem then: I could obviously add
  >> Linux kernel version checks where needed, but to do that, the
  >> patch first needs to go into the kernel.

  Michel> Mind elaborating on that? I don't see such a problem as you
  Michel> don't need version checks for anything the patch itself
  Michel> adds, only for kernel infrastructure that isn't available in
  Michel> older kernels (down to 2.4).

OK, I'm confused then: earlier on, you reported this error:

  asm/agp.h: No such file or directory

My patch adds the following to asm-i386/agp.h:

diff -Nru a/include/asm-i386/agp.h b/include/asm-i386/agp.h
--- a/include/asm-i386/agp.h	Sat May 10 01:47:42 2003
+++ b/include/asm-i386/agp.h	Sat May 10 01:47:42 2003
@@ -20,4 +20,11 @@
    worth it. Would need a page for it. */
 #define flush_agp_cache() asm volatile("wbinvd":::"memory")
 
+/*
+ * Page-protection value to be used for AGP memory mapped into kernel space.  For
+ * platforms which use coherent AGP DMA, this can be PAGE_KERNEL.  For others, it needs to
+ * be an uncached mapping (such as write-combining).
+ */
+#define PAGE_AGP			PAGE_KERNEL_NOCACHE
+
 #endif

So, either you're using a platform which I don't know supports AGP, or
the patch didn't apply cleanly (perhaps because you're using an old
kernel that doesn't have asm/agp.h yet?).

Could you shed some light?  Once I understand why things are failing
for you, I shall be happy to update the patch accordingly.

	--david

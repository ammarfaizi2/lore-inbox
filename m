Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759337AbWLASX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759337AbWLASX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759338AbWLASX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:23:58 -0500
Received: from colo.lackof.org ([198.49.126.79]:61331 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1759337AbWLASX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:23:58 -0500
Date: Fri, 1 Dec 2006 11:23:55 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Matthew Wilcox <willy@parisc-linux.org>, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org,
       Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [2.6 patch] arch/parisc/Makefile: remove GCC_VERSION
Message-ID: <20061201182355.GC10549@colo.lackof.org>
References: <20061201114908.GR11084@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201114908.GR11084@stusta.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 12:49:08PM +0100, Adrian Bunk wrote:
> This patch removes the usage of GCC_VERSION from arch/parisc/Makefile.
> 
> There are no functional changes, it simply makes it a bit shorter (and 
> removes the last instance of GCC_VERSION in the kernel).

Thanks!
I've committed a variant of this to git://git.parisc-linux.org/git/linux-2.6.git
I didn't test the failure case - only that it doesn't trigger with
my current gcc 4.x compilers.

I expect Kyle will push parisc tree to linus in the near future.

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>


diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 9b7e424..760567a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -35,12 +35,8 @@ FINAL_LD=$(CROSS_COMPILE)ld --warn-commo
 
 OBJCOPY_FLAGS =-O binary -R .note -R .comment -S
 
-GCC_VERSION     := $(call cc-version)
-ifneq ($(shell if [ -z $(GCC_VERSION) ] ; then echo "bad"; fi ;),)
-$(error Sorry, couldn't find ($(cc-version)).)
-endif
-ifneq ($(shell if [ $(GCC_VERSION) -lt 0303 ] ; then echo "bad"; fi ;),)
-$(error Sorry, your compiler is too old ($(GCC_VERSION)).  GCC v3.3 or above is required.)
+ifneq ($(call cc-ifversion, -lt, 0303, "bad"),)
+$(error Sorry, GCC v3.3 or above is required.)
 endif
 
 cflags-y	:= -pipe

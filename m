Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWA1Qtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWA1Qtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 11:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWA1Qtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 11:49:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35849 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751473AbWA1Qtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 11:49:32 -0500
Date: Sat, 28 Jan 2006 17:49:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: HIGHMEM64G must depend on X86_CMPXCHG64
Message-ID: <20060128164930.GJ3777@stusta.de>
References: <20051117235700.GJ11494@stusta.de> <m14q6aohg0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14q6aohg0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 06:47:27PM -0700, Eric W. Biederman wrote:
>...
> So I think either the pgtable-3level.h needs to fixed,
> or we just make CONFIG_HIGHME64G depend on CONFIG_X86_CMPXCHG64.

Sounds reasonable (and sorry for the late answer).

Patch below.

> Eric

cu
Adrian


<--  snip  -->


Due to the usage of set_64bit in include/asm-i386/pgtable-3level.h, 
HIGHMEM64G must depend on X86_CMPXCHG64.


--- linux-2.6.16-rc1-mm3-386/arch/i386/Kconfig.old	2006-01-28 16:04:45.000000000 +0100
+++ linux-2.6.16-rc1-mm3-386/arch/i386/Kconfig	2006-01-28 16:05:25.000000000 +0100
@@ -442,6 +442,7 @@
 
 config HIGHMEM64G
 	bool "64GB"
+	depends on X86_CMPXCHG64
 	help
 	  Select this if you have a 32-bit processor and more than 4
 	  gigabytes of physical RAM.

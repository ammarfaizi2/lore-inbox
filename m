Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUHLH1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUHLH1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUHLH1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:27:35 -0400
Received: from holomorphy.com ([207.189.100.168]:4490 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268448AbUHLHZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:25:46 -0400
Date: Thu, 12 Aug 2004 00:25:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>, Keith Owens <kaos@ocs.com.au>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040812072531.GJ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@osdl.org>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> <23701.1092268910@ocs3.ocs.com.au> <20040812010115.GY11200@holomorphy.com> <Pine.LNX.4.58.0408112133470.2544@montezuma.fsmlabs.com> <20040812020424.GB11200@holomorphy.com> <20040812072058.GH11200@holomorphy.com> <20040812072338.GI11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812072338.GI11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:20:58AM -0700, William Lee Irwin III wrote:
>> Okay, the results on 2.6.8-rc4 (COOL had a bit of porting, basically
>> dropping the hunks associated with spin_lock_flags_string or whatever
>> it is). Chose the .config largely to be vaguely deterministic, but had
>> to nuke the "System is too big" check in arch/x86_64/boot/tools/build.c.
>>               text    data     bss     dec     hex filename
>> mainline: 20708323        6603052 1878448 29189823        1bd66bf vmlinux
>> cool:     20619594        6588166 1878448 29086208        1bbd200 vmlinux
>> C-func:   19969264        6583128 1878384 28430776        1b1d1b8 vmlinux
>> x86-64, -O2, allyesconfig minus the following:
> [...]

On Thu, Aug 12, 2004 at 12:23:38AM -0700, William Lee Irwin III wrote:
> The precise COOL patch used:

For completeness, the "System is too big" avoidance patch, too.
Please don't merge this. It's just "full disclosure" for how I ran this
particular compiletest.


Index: spinlock-2.6.8-rc4/arch/x86_64/boot/tools/build.c
===================================================================
--- spinlock-2.6.8-rc4.orig/arch/x86_64/boot/tools/build.c	2004-06-15 22:20:27.000000000 -0700
+++ spinlock-2.6.8-rc4/arch/x86_64/boot/tools/build.c	2004-08-11 23:22:43.242607520 -0700
@@ -151,9 +151,6 @@
 	fprintf (stderr, "System is %d kB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
 	/* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
-	if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
-		die("System is too big. Try using %smodules.",
-			is_big_kernel ? "" : "bzImage or ");
 	while (sz > 0) {
 		int l, n;
 

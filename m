Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVAPFek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVAPFek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVAPFek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:34:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:40884 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262432AbVAPFeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:34:31 -0500
Message-ID: <41E9FB30.9060200@osdl.org>
Date: Sat, 15 Jan 2005 21:27:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] i386: init_intel_cacheinfo() can be __init
Content-Type: multipart/mixed;
 boundary="------------000602070402020406050204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602070402020406050204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Correct .text references to .init.data; init_intel_cacheinfo()
can be __init.

These are references to:
static struct _cache_table cache_table[] __initdata = ...;

Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 
0000008f R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 
0000009e R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 
000000a8 R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 
00000108 R_386_32          .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  arch/i386/kernel/cpu/intel_cacheinfo.c |    2 +-
  1 files changed, 1 insertion(+), 1 deletion(-)
---

--------------000602070402020406050204
Content-Type: text/x-patch;
 name="intel_cache_sections.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intel_cache_sections.patch"


Correct .text references to .init.data; init_intel_cacheinfo()
can be __init.

These are references to:
static struct _cache_table cache_table[] __initdata = ...;

Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 0000008f R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 0000009e R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 000000a8 R_386_32          .init.data
Error: ./arch/i386/kernel/cpu/intel_cacheinfo.o .text refers to 00000108 R_386_32          .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/kernel/cpu/intel_cacheinfo.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/i386/kernel/cpu/intel_cacheinfo.c~intel_cache_sections ./arch/i386/kernel/cpu/intel_cacheinfo.c
--- ./arch/i386/kernel/cpu/intel_cacheinfo.c~intel_cache_sections	2004-12-24 13:35:23.000000000 -0800
+++ ./arch/i386/kernel/cpu/intel_cacheinfo.c	2005-01-07 14:51:03.000000000 -0800
@@ -58,7 +58,7 @@ static struct _cache_table cache_table[]
 	{ 0x00, 0, 0}
 };
 
-unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c)
+unsigned int __init init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0; /* Cache sizes */
 

--------------000602070402020406050204--

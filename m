Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVL3GdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVL3GdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 01:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVL3GdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 01:33:25 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:35248 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751194AbVL3GdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 01:33:24 -0500
Message-ID: <43B4D4AC.5020303@tlinx.org>
Date: Thu, 29 Dec 2005 22:33:16 -0800
From: "Linda A. Walsh" <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en, en_US
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: patch for "scripts/package/buildtar" to pickup "localversion" on
 "/boot" file objects
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <43A7304B.2070103@tlinx.org> <20051219223030.GM13985@lug-owl.de> <43A762E0.5020608@tlinx.org>
In-Reply-To: <43A762E0.5020608@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linda Walsh wrote:

> Jan-Benedict Glaw wrote:
>
>> That's how it is ment to be. Actually, for in-tree builds, you get the
>> tarball without first becoming root.
>>
> ---
> Slight minor possible "nit".
> I have a suffix (CONFIG_LOCALVERSION) set.
> While buildtar picks up the /lib/modules files in <ver>-suffix, the
> map and vm files all have suffixes w/o the "localversion" appended.

---
BTW -- here is a "quick" patch to pick up the "local version" to append to
the files in "/boot" for the "tar[x]-pkg's"...

--- scripts/package/buildtar.orig       2005-11-24 14:10:21.000000000 -0800
+++ scripts/package/buildtar    2005-12-29 22:26:34.543513254 -0800
@@ -15,7 +15,8 @@
 #
 # Some variables and settings used throughout the script
 #
-version="${VERSION}.${PATCHLEVEL}.${SUBLEVEL}${EXTRAVERSION}${EXTRANAME}"
+version="$(grep UTS_RELEASE include/linux/version.h| \
+       sed 's/^#[^"]*"// ; s/"$// ')"
 tmpdir="${objtree}/tar-install"
 tarball="${objtree}/linux-${version}.tar"
 

>

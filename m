Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422974AbWCXB1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWCXB1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422973AbWCXB1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:27:51 -0500
Received: from stinky.trash.net ([213.144.137.162]:60636 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1422972AbWCXB1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:27:50 -0500
Message-ID: <44234B10.5040802@trash.net>
Date: Fri, 24 Mar 2006 02:27:44 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bunk@stusta.de, zhaojignmin@hotmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [2.6 patch] ip_conntrack_helper_h323.c: EXPORT_SYMBOL'ed functions
 shouldn't be static
References: <20060324000801.GM22727@stusta.de> <20060323.161314.59991770.davem@davemloft.net>
In-Reply-To: <20060323.161314.59991770.davem@davemloft.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------020904020401040302050807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904020401040302050807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Fri, 24 Mar 2006 01:08:01 +0100
> 
> 
>>EXPORT_SYMBOL'ed functions shouldn't be static.
>>
>>Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> 
> Fixed in Linus's tree as of yesterday.
> 
> I actually have a patch from Patrick McHardy that will make
> this kind of error a build time failure instead of silently
> working in the modular case.  I just need to test it out
> a bit before pushing.

I guess I should send it to lkml anyway. It boots fine, I couldn't
figure out how to compare checksums, since the time of compilation
and a couple other dynamically generated strings end up in the binary.

--------------020904020401040302050807
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[MODULES]: Don't allow statically declared exports

Add an extern declaration for exported symbols to make the compiler warn
on symbols declared statically.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 8648236083e488ff4fc279b66d63b1187e22e558
tree cba9ee372f1056c8cf63cdc6a37a6a761fa490c9
parent 8b21e6d05d6ac0aeb44f5866ab611e2709c2f08e
author Patrick McHardy <kaber@trash.net> Thu, 23 Mar 2006 05:07:39 +0100
committer Patrick McHardy <kaber@trash.net> Thu, 23 Mar 2006 05:07:39 +0100

 include/linux/module.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 70bd843..d956915 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -183,6 +183,7 @@ void *__symbol_get_gpl(const char *symbo
 
 /* For every exported symbol, place a struct in the __ksymtab section */
 #define __EXPORT_SYMBOL(sym, sec)				\
+	extern typeof(sym) sym;					\
 	__CRC_SYMBOL(sym, sec)					\
 	static const char __kstrtab_##sym[]			\
 	__attribute__((section("__ksymtab_strings")))		\

--------------020904020401040302050807--

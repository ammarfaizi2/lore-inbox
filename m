Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVHXFwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVHXFwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 01:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVHXFwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 01:52:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:56772 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750721AbVHXFw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 01:52:29 -0400
Message-ID: <430C0B33.7000708@temple.edu>
Date: Wed, 24 Aug 2005 01:52:51 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Sillik <n.sillik@temple.edu>
CC: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm PATCH] drivers/char/speakup/synthlist.h - Fix warnings with
 -Wundef
References: <430B8063.8070301@temple.edu> <20050824053703.GA23807@mipter.zuzino.mipt.ru> <430C07F0.8010001@temple.edu>
In-Reply-To: <430C07F0.8010001@temple.edu>
Content-Type: multipart/mixed;
 boundary="------------000205010708080600070008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000205010708080600070008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Sillik wrote:
> Alexey Dobriyan wrote:
> 
>>
>>> -#define  CFG_TEST(name) (name)
>>> +#define  CFG_TEST(name) defined(name)
>>
>>
>>
>> No. Just remove this obfuscating macro.
> 
> 
> Agreed, here is the fixed patch
> 
> Signed-Off-By: Nick Sillik <n.sillik@temple.edu>

No here it really is... (sorry)

Signed-Off-By: Nick Sillik <n.sillik@temple.edu>

--------------000205010708080600070008
Content-Type: text/x-patch;
 name="speakup-wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="speakup-wundef.patch"

diff -urN -X linux-2.6.13-rc6-mm2/Documentation/dontdiff linux-2.6.13-rc6-mm2/drivers/char/speakup/synthlist.h linux-2.6.13-rc6-mm2-patched/drivers/char/speakup/synthlist.h
--- linux-2.6.13-rc6-mm2/drivers/char/speakup/synthlist.h	2005-08-24 01:37:59.000000000 -0400
+++ linux-2.6.13-rc6-mm2-patched/drivers/char/speakup/synthlist.h	2005-08-24 01:37:37.000000000 -0400
@@ -2,53 +2,51 @@
 #if defined(PASS2)
 /* table of built in synths */
 #define SYNTH_DECL(who) &synth_##who,
-#define  CFG_TEST(name) (name)
 #else
 /* declare extern built in synths */
 #define SYNTH_DECL(who) extern struct spk_synth synth_##who;
 #define PASS2
-#define  CFG_TEST(name) (name)
 #endif
 
-#if CFG_TEST(CONFIG_SPEAKUP_ACNTPC)
+#ifdef CONFIG_SPEAKUP_ACNTPC
 SYNTH_DECL(acntpc)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_ACNTSA)
+#ifdef CONFIG_SPEAKUP_ACNTSA
 SYNTH_DECL(acntsa)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_APOLLO)
+#ifdef CONFIG_SPEAKUP_APOLLO
 SYNTH_DECL(apollo)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_AUDPTR)
+#ifdef CONFIG_SPEAKUP_AUDPTR
 SYNTH_DECL(audptr)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_BNS)
+#ifdef CONFIG_SPEAKUP_BNS
 SYNTH_DECL(bns)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DECEXT)
+#ifdef CONFIG_SPEAKUP_DECEXT
 SYNTH_DECL(decext)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DECTLK)
+#ifdef CONFIG_SPEAKUP_DECTLK
 SYNTH_DECL(dectlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DTLK)
+#ifdef CONFIG_SPEAKUP_DTLK
 SYNTH_DECL(dtlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_KEYPC)
+#ifdef CONFIG_SPEAKUP_KEYPC
 SYNTH_DECL(keypc)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_LTLK)
+#ifdef CONFIG_SPEAKUP_LTLK
 SYNTH_DECL(ltlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_SFTSYN)
+#ifdef CONFIG_SPEAKUP_SFTSYN
 SYNTH_DECL(sftsyn)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_SPKOUT)
+#ifdef CONFIG_SPEAKUP_SPKOUT
 SYNTH_DECL(spkout)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_TXPRT)
+#ifdef CONFIG_SPEAKUP_TXPRT
 SYNTH_DECL(txprt)
 #endif
 
 #undef SYNTH_DECL
-#undef CFG_TEST
+#undef 

--------------000205010708080600070008--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVI3WBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVI3WBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVI3WBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:01:16 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:43717 "EHLO
	relay2.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S932293AbVI3WBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:01:15 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Andrew Morton <akpm@osdl.org>
Subject: reiser4 compilation fix [ was: 2.6.14-rc2-mm2]
Date: Sat, 1 Oct 2005 02:02:32 +0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Hans Reiser <reiser@namesys.com>
References: <20050929143732.59d22569.akpm@osdl.org>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510010202.32667.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (269/050913)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0129], SpamtestISP/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 30 September 2005 01:37, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.
>6.14-rc2-mm2/
>
> (temp copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
>
>
> - A bunch of memory management updates
>
> - The big pcmcia changes have been temporarily dropped
>
> - Multiple obscure tty drivers still won't compile
>
> - Lots of post-2.6.14-rc2-mm1 patches have been cheerfully tossed out
>   again due to various bugs, which felt nice.
>
> - I am offline until October 9.  Please send critical 2.6.14 fixes direct
> to Linus.
>

Andrew, please add this reiser4 compilation fix :
---------------------------------------------------
--- a/fs/reiser4/spin_macros.h
+++ b/fs/reiser4/spin_macros.h
@@ -82,8 +82,6 @@ typedef struct reiser4_rw_data {
 static inline void spin_ ## NAME ## _init(TYPE *x)				\
 {										\
 	__ODCA("nikita-2987", x != NULL);					\
-	cassert(sizeof(x->FIELD) != 0);						\
-	memset(& x->FIELD, 0, sizeof x->FIELD);					\
 	spin_lock_init(& x->FIELD.lock);					\
 }										\
 										\
@@ -236,7 +234,6 @@ typedef struct { int foo; } NAME ## _spi
 static inline void rw_ ## NAME ## _init(TYPE *x)				\
 {										\
 	__ODCA("nikita-2988", x != NULL);					\
-	memset(& x->FIELD, 0, sizeof x->FIELD);					\
 	rwlock_init(& x->FIELD.lock);						\
 }										\
 										\


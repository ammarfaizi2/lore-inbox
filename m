Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272575AbTHKNUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTHKNUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:20:31 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:20651 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S272575AbTHKNU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:20:29 -0400
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
From: Albert Cahalan <albert@users.sf.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@digeo.com>, akpm@osdl.org,
       Willy Tarreau <willy@w.ods.org>, Chip Salzenberg <chip@pobox.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
In-Reply-To: <20030811054209.GN10446@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube>
	 <20030810072945.GA14038@alpha.home.local>
	 <20030811012337.GI24349@perlsupport.com>
	 <20030811020957.GE10446@mail.jlokier.co.uk>
	 <20030811023912.GJ24349@perlsupport.com>
	 <20030811053059.GB28640@alpha.home.local>
	 <20030811054209.GN10446@mail.jlokier.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1060607398.948.213.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Aug 2003 09:09:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 01:42, Jamie Lokier wrote:
> Willy Tarreau wrote:
> > So in any case, the !!(x) construct should be valid.
> 
> Yes, either of these is fine for pointers and integers alike:
> 
> 	#define likely(x)	__builtin_expect ((x) != 0, 1)
> 	#define unlikely(x)	__builtin_expect ((x) != 0, 0)
> 
> 	#define likely(x)	__builtin_expect (!!(x), 1)
> 	#define unlikely(x)	__builtin_expect (!!(x), 0)

Choosing the more familiar idiom for booleanizing a value, here we go:

diff -Naurd old/include/linux/compiler.h new/include/linux/compiler.h
--- old/include/linux/compiler.h	2003-08-11 09:02:18.000000000 -0400
+++ new/include/linux/compiler.h	2003-08-11 09:04:58.000000000 -0400
@@ -24,8 +24,8 @@
 #define __builtin_expect(x, expected_value) (x)
 #endif
 
-#define likely(x)	__builtin_expect((x),1)
-#define unlikely(x)	__builtin_expect((x),0)
+#define likely(x)	__builtin_expect(!!(x),1)
+#define unlikely(x)	__builtin_expect(!!(x),0)
 
 /*
  * Allow us to mark functions as 'deprecated' and have gcc emit a nice





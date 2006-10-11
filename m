Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161426AbWJKVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161426AbWJKVHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161422AbWJKVHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:07:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:23200 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161421AbWJKVGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:49 -0400
Date: Wed, 11 Oct 2006 14:06:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 36/67] Remove offsetof() from user-visible <linux/stddef.h>
Message-ID: <20061011210630.GK16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0014-Remove-offsetof-from-user-visible-linux-stddef.h.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

It's not used by anything user-visible, and it make g++ unhappy.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 include/linux/Kbuild   |    2 +-
 include/linux/stddef.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18.orig/include/linux/Kbuild
+++ linux-2.6.18/include/linux/Kbuild
@@ -143,7 +143,6 @@ header-y += snmp.h
 header-y += sockios.h
 header-y += som.h
 header-y += sound.h
-header-y += stddef.h
 header-y += synclink.h
 header-y += telephony.h
 header-y += termios.h
@@ -318,6 +317,7 @@ unifdef-y += sonet.h
 unifdef-y += sonypi.h
 unifdef-y += soundcard.h
 unifdef-y += stat.h
+unifdef-y += stddef.h
 unifdef-y += sysctl.h
 unifdef-y += tcp.h
 unifdef-y += time.h
--- linux-2.6.18.orig/include/linux/stddef.h
+++ linux-2.6.18/include/linux/stddef.h
@@ -10,11 +10,13 @@
 #define NULL ((void *)0)
 #endif
 
+#ifdef __KERNEL__
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
 #else
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
+#endif /* __KERNEL__ */
 
 #endif

--

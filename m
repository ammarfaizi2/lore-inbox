Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbTIDNxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbTIDNxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:53:20 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:5902 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S265012AbTIDNxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:53:15 -0400
Date: Thu, 4 Sep 2003 10:53:15 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, parisc-linux@lists.parisc-linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] add MODULE_ALIAS_LDISC to asm-parisc/termios.h
Message-ID: <20030904135315.GB2411@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Matthew Wilcox <willy@debian.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	parisc-linux@lists.parisc-linux.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I noticed this one on parisc64 with the latest bk tree:

  CC [M]  drivers/char/n_hdlc.o
drivers/char/n_hdlc.c:985: parse error before numeric constant
drivers/char/n_hdlc.c:985: warning: type defaults to `int' in declaration of `MODULE_ALIAS_LDISC'
drivers/char/n_hdlc.c:985: warning: function declaration isn't a prototype
drivers/char/n_hdlc.c:985: warning: data definition has no type or storage classmake[2]: *** [drivers/char/n_hdlc.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

	This patch makes it compile, doing the same thing that was done to
include/asm-i386/termios.h, please see if this is acceptable, if it is I can
provide the same patch for all the other arches.

- Arnaldo

===== include/asm-parisc/termios.h 1.4 vs edited =====
--- 1.4/include/asm-parisc/termios.h	Sat Jul 20 06:52:25 2002
+++ edited/include/asm-parisc/termios.h	Thu Sep  4 13:43:57 2003
@@ -101,6 +101,8 @@
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
+#define MODULE_ALIAS_LDISC(ldisc) \
+        MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 #endif	/* __KERNEL__ */
 
 #endif	/* _PARISC_TERMIOS_H */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTJ1K7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 05:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTJ1K7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 05:59:47 -0500
Received: from not.theboonies.us ([66.139.79.224]:15325 "EHLO
	not.theboonies.us") by vger.kernel.org with ESMTP id S263923AbTJ1K7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 05:59:45 -0500
Message-ID: <1067342997.3f9e5c95beefb@mail.theboonies.us>
Date: Tue, 28 Oct 2003 06:09:57 -0600
To: linux-kernel@vger.kernel.org
Subject: gcc 3.2+ alignment issue with 2.6 kernel (was Re: 2.6.0-test6 + fb
	patch = dead PowerBook)
References: <1067021062.3f9973069378a@mail.theboonies.us>
	<1067035133.3f99a9fd94647@mail.theboonies.us>
In-Reply-To: <1067035133.3f99a9fd94647@mail.theboonies.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 193.224.42.5
From: David Eger <random-temp_addy-1067947802.46b228@theboonies.us>
X-Delivery-Agent: TMDA/0.84 (Tim Tam)
X-Primary-Address: random@theboonies.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

My issue seems to be a bad interaction of new versions of gcc (me gcc-3.2.3, him
gcc-3.3.1) with alignments in the kernel.  My problems have gone away with the
following patch presented on linuxppc-dev by Sam Ravnborg.  I do not know if
other platforms are affected, so similar patches might be needed elsewhere.

Why this misalignment would turn my machine into a brick even through reboots...
I do not know. 

-Eger David


===== arch/ppc/kernel/vmlinux.lds.S 1.24 vs edited =====
--- 1.24/arch/ppc/kernel/vmlinux.lds.S Fri Sep 12 18:26:52 2003
+++ edited/arch/ppc/kernel/vmlinux.lds.S Sun Oct 12 20:17:25 2003
@@ -47,13 +47,17 @@

.fixup : { *(.fixup) }

- __start___ex_table = .;
- __ex_table : { *(__ex_table) }
- __stop___ex_table = .;
+ __ex_table : {
+ __start___ex_table = .;
+ *(__ex_table)
+ __stop___ex_table = .;
+ }

- __start___bug_table = .;
- __bug_table : { *(__bug_table) }
- __stop___bug_table = .;
+ __bug_table : {
+ __start___bug_table = .;
+ *(__bug_table)
+ __stop___bug_table = .;
+ }

/* Read-write section, merged into data segment: */
. = ALIGN(4096);


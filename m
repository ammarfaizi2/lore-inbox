Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWAWTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWAWTdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWAWTdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:33:05 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:35060 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964913AbWAWTdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:33:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=jcZGvEvfk7gy1KRywbAfvLIE0oQVuMv7F2kQchIaf+3+nDMGr+I9b9EA31tlDD1zpS4W6wsUj0Nf4h02VmWYu2Fp3hT1mypmP3F5ovZr4h5nA9YjlGIAOWtF00JstIifJWeYFLrkeSEyn49UCo/1RLX3mxNAPeB+x/QDGjxwaq4=
Message-ID: <c293dd340601231133m16bebe9doe0ce357d25188892@mail.gmail.com>
Date: Tue, 24 Jan 2006 01:03:03 +0530
From: Toufeeq Hussain <toufeeqh@gmail.com>
To: kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH] Compile error for KGDB 2.3 on arm(2.6.13-ep93xx)
Cc: linux-cirrus@freelists.org, linux-arm@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11459_13638672.1138044783164"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_11459_13638672.1138044783164
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

While trying to get kgdb 2.3 (for linux-2.6.13) working with the
ep93xx board I got the following compile error.

<snip>
 GZIP    kernel/config_data.gz
 IKCFG   kernel/config_data.h
 CC      kernel/configs.o
 CC      kernel/kgdb.o
kernel/kgdb.c:130: error: `NUMCRITREGBYTES' undeclared here (not in a funct=
ion)
kernel/kgdb.c:131: error: storage size of `kgdb_fault_jmp_regs' isn't known
make[1]: *** [kernel/kgdb.o] Error 1
make: *** [kernel] Error 2

I've attached a patch which fixes this problem.

Regards,
Toufeeq
--
blog @ http://toufeeq.blogspot.com

------=_Part_11459_13638672.1138044783164
Content-Type: text/x-patch; name=kgdb-arm-2.3.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="kgdb-arm-2.3.patch"

--- linux-2.6.13/include/asm-arm/kgdb.h	2006-01-24 06:21:57.644718496 +0530
+++ linux-2.6.13.orig/include/asm-arm/kgdb.h	2006-01-24 04:41:21.000000000 +0530
@@ -65,6 +65,7 @@
 #define	KGDB_MAX_NO_CPUS	1
 #define	BUFMAX			400
 #define	NUMREGBYTES		(GDB_MAX_REGS << 2)
+#define	NUMCRITREGBYTES		(32 << 2)
 
 #define	_R0		0
 #define	_R1		1


------=_Part_11459_13638672.1138044783164--

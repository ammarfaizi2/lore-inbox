Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318972AbSH1VRr>; Wed, 28 Aug 2002 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318973AbSH1VRq>; Wed, 28 Aug 2002 17:17:46 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:1210 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S318972AbSH1VRk>; Wed, 28 Aug 2002 17:17:40 -0400
Subject: [PATCH] update ver_linux script to work with gcc 3.2.
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Aug 2002 15:18:09 -0600
Message-Id: <1030569489.4032.113.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A commonly used gcc reports its version number thusly:
[steven@spc5 steven]$ gcc --version
2.96

But the new gcc 3.2 reports its version number thusly:
[steven@spc1 scripts]$ gcc --version
gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-1mdk)
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This causes the current ver_linux script to produce less
than readable output for the gcc version when using gcc 3.2.

Here is a patch to the ver_linux script which allows it
to work both with the new gcc and the old gcc. 

The patch was made against 2.4.20-pre4-ac2, but also applies to 
2.4.20-pre4 and to 2.5.32 as well.

This was tested for the gcc 3.2 on Mandrake 9.0 beta4, but
will probably work for Red Hat Limbo or (null).  Testing is
always welcomed.  Backward compatibility with gcc 2.96 was
tested with Red Hat 7.3 and Mandrake 8.2.

Steven

--- linux-2.4.20-pre4-ac2/scripts/ver_linux.orig	Wed Aug 28 14:37:39 2002
+++ linux-2.4.20-pre4-ac2/scripts/ver_linux	Wed Aug 28 14:37:51 2002
@@ -12,7 +12,11 @@
 uname -a
 echo ' '

-echo "Gnu C                 " `gcc --version`
+gcc --version 2>&1| head -n 1 | grep -v gcc | awk \
+'NR==1{print "Gnu C                 ", $1}'
+
+gcc --version 2>&1| grep gcc | awk \
+'NR==1{print "Gnu C                 ", $3}'

 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbTFRXTe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265606AbTFRXTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:19:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22002 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265605AbTFRXTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:19:32 -0400
Date: Thu, 19 Jun 2003 01:33:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, bwindle-kbt@fint.org
Subject: [2.5 patch]
Message-ID: <20030618233328.GK29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle sent a patch that does the following (slightly reformatted 
by me) in Bugzilla #142:


--- linux-2.5.72/scripts/ver_linux.old	2003-06-19 01:26:24.000000000 +0200
+++ linux-2.5.72/scripts/ver_linux	2003-06-19 01:27:53.000000000 +0200
@@ -61,7 +61,8 @@
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
        '{print "Linux C++ Library      " $4"."$5"."$6}'
 
-ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'
+ps --version 2>&1 | grep version | awk \
+'NR==1{print "Procps                ", $NF}'
 
 ifconfig --version 2>&1 | grep tools | awk \
 'NR==1{print "Net-tools             ", $NF}'



Explanation by Burton (from Bugzilla) follows below.

Please apply
Adrian


<--  snip  -->

With the current 2.5 Linux kernel, the ver_linux script prints bad 
version
info for the Procps line:

Procps                 100.

Steps to reproduce:
This is because
razor:/giant/linux/scripts# ps --version
Unknown HZ value! (85) Assume 100.
procps version 2.0.7
razor:/giant/linux/scripts# ps --version 2>&1 | awk 'NR==1
{print "Procps         , $NF}'
Procps                 100.


<--  snip  -->



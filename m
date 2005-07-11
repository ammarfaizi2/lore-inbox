Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVGKQmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVGKQmo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVGKQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:40:31 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:45446 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262128AbVGKQhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:37:39 -0400
Date: Mon, 11 Jul 2005 18:37:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 10/12] s390: 31 bit memory size limit.
Message-ID: <20050711163738.GJ10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 10/12] s390: 31 bit memory size limit.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Limit reported memory size to 2GB if running in 31 bit mode.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-07-11 17:37:45.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-07-11 17:37:49.000000000 +0200
@@ -535,8 +535,13 @@ startup:basr  %r13,0                    
 	lhi   %r1,0
 	icm   %r1,3,.Lscpincr1-PARMAREA(%r4) # use this one if != 0
 	jnz   .Lscnd
-	l     %r1,.Lscpincr2-PARMAREA+4(%r4) # otherwise use this one
+	lhi   %r1,0x800			# otherwise report 2GB
 .Lscnd:
+	lhi   %r3,0x800			# limit reported memory size to 2GB
+	cr    %r1,%r3
+	jl    .Lno2gb
+	lr    %r1,%r3
+.Lno2gb:
 	xr    %r3,%r3			# same logic
 	ic    %r3,.Lscpa1-PARMAREA(%r4)
 	chi   %r3,0x00

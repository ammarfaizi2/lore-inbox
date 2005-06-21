Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVFUQeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVFUQeD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVFUQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:33:39 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:46524 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262193AbVFUQaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:30:09 -0400
Date: Tue, 21 Jun 2005 18:30:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 16/16] s390: 31 bit memory size limit.
Message-ID: <20050621163008.GP6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 16/16] s390: 31 bit memory size limit.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Limit reported memory size to 2GB if running in 31 bit mode.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/head.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/head.S linux-2.6-patched/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	2005-06-21 17:36:56.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/head.S	2005-06-21 17:36:56.000000000 +0200
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

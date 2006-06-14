Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWFNN6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWFNN6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWFNN6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:58:30 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:40587 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S964941AbWFNN63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:58:29 -0400
Date: Wed, 14 Jun 2006 15:58:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 3/24] s390: memory detection.
Message-ID: <20060614135827.GD9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] memory detection.

The wrong base register is used to read a value from the sclp data
structure. The value is used to calculate the memory size.
Use correct register %r4.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head31.S |    2 +-
 arch/s390/kernel/head64.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/head31.S linux-2.6-patched/arch/s390/kernel/head31.S
--- linux-2.6/arch/s390/kernel/head31.S	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head31.S	2006-06-14 14:29:34.000000000 +0200
@@ -87,7 +87,7 @@ startup:basr	%r13,0			 # get base
 	ic	%r3,.Lscpa1-PARMAREA(%r4)
 	chi	%r3,0x00
 	jne	.Lcompmem
-	l	%r3,.Lscpa2-PARMAREA(%r13)
+	l	%r3,.Lscpa2-PARMAREA(%r4)
 .Lcompmem:
 	mr	%r2,%r1			# mem in MB on 128-bit
 	l	%r1,.Lonemb-.LPG1(%r13)
diff -urpN linux-2.6/arch/s390/kernel/head64.S linux-2.6-patched/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/head64.S	2006-06-14 14:29:34.000000000 +0200
@@ -86,7 +86,7 @@ startup:basr  %r13,0                    
 	ic    %r3,.Lscpa1-PARMAREA(%r4)
 	chi   %r3,0x00
 	jne   .Lcompmem
-	l     %r3,.Lscpa2-PARMAREA(%r13)
+	l     %r3,.Lscpa2-PARMAREA(%r4)
 .Lcompmem:
 	mlgr  %r2,%r1			# mem in MB on 128-bit
 	l     %r1,.Lonemb-.LPG1(%r13)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWCVQko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWCVQko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWCVQkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:40:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:26878 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751038AbWCVQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:40:42 -0500
Date: Wed, 22 Mar 2006 17:42:01 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/6] s390: minor claw driver fix
Message-ID: <20060322174201.3e8c374c@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
following 6 patches are for s390 network drivers claw, qeth and ctc.
tty support will be removed from the ctc network device driver , which will
happen with patch 5/6 and 6/6 . The latter one will remove two files , ctctty.c and ctctty.h .

Thanks 

Frank 

[patch 1/6] s390: minor claw driver fix

From: Frank Pavlic <fpavlic@de.ibm.com>

	use CONFIG_ARCH_S390X instead of CONFIG_64BIT in function dumpit .

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 claw.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
index a86436a..4687bb5 100644
--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -1601,7 +1601,7 @@ dumpit(char* buf, int len)
         __u32      ct, sw, rm, dup;
         char       *ptr, *rptr;
         char       tbuf[82], tdup[82];
-#if (CONFIG_64BIT)
+#if (CONFIG_ARCH_S390X)
         char       addr[22];
 #else
         char       addr[12];
@@ -1617,7 +1617,7 @@ dumpit(char* buf, int len)
         dup = 0;
         for ( ct=0; ct < len; ct++, ptr++, rptr++ )  {
                 if (sw == 0) {
-#if (CONFIG_64BIT)
+#if (CONFIG_ARCH_S390X)
                         sprintf(addr, "%16.16lX",(unsigned long)rptr);
 #else
                         sprintf(addr, "%8.8X",(__u32)rptr);
@@ -1632,7 +1632,7 @@ dumpit(char* buf, int len)
                 if (sw == 8) {
                         strcat(bhex, "  ");
                 }
-#if (CONFIG_64BIT)
+#if (CONFIG_ARCH_S390X)
                 sprintf(tbuf,"%2.2lX", (unsigned long)*ptr);
 #else
                 sprintf(tbuf,"%2.2X", (__u32)*ptr);

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289670AbSAJUyl>; Thu, 10 Jan 2002 15:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289674AbSAJUy3>; Thu, 10 Jan 2002 15:54:29 -0500
Received: from laibach.mweb.co.za ([196.2.53.177]:52394 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S289405AbSAJUxv>; Thu, 10 Jan 2002 15:53:51 -0500
Subject: [PATCH] Compilation error on 2.5.10 linux-2.5/drivers/ide/pdc4030.c
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: LKM <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Jan 2002 23:05:46 +0200
Message-Id: <1010696751.5950.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an error when compiling and removes a unused variable warning
The following warning I'm not sure about though:

pdc4030.c: In function `do_pdc4030_io':
pdc4030.c:571: warning: control reaches end of non-void function

	-Bongani

--- /usr/src/linux-2.5/drivers/ide/pdc4030.c    Wed Jan  9 21:46:15 2002
+++ /usr/src/linux-2.5-dev/drivers/ide/pdc4030.c        Thu Jan 10
22:50:29 2002
@@ -393,7 +393,6 @@
 {
        ide_hwgroup_t *hwgroup = HWGROUP(drive);
        struct request *rq = hwgroup->rq;
-       int i;

        if (GET_STAT() & BUSY_STAT) {
                if (time_before(jiffies, hwgroup->poll_timeout)) {
@@ -498,6 +497,7 @@
 {
        unsigned long timeout;
        byte stat;
+       ide_startstop_t startstop;

 /* Check that it's a regular command. If not, bomb out early. */
        if (!(rq->flags & REQ_CMD)) {
@@ -543,7 +543,6 @@
                break;

        case WRITE:
-               ide_startstop_t startstop;
                OUT_BYTE(PROMISE_WRITE, IDE_COMMAND_REG);
 /*
  * Strategy on write is:



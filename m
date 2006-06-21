Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWFUVSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWFUVSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWFUVSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:18:31 -0400
Received: from mail.gmx.de ([213.165.64.21]:20197 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751294AbWFUVSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:18:30 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in drivers/char/rio/riocmd.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 21 Jun 2006 23:18:28 +0200
Message-Id: <1150924709.24615.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug id #1025. 
The code checks if Rup is greater or equal to the size of 
HostP->Mapping[], but uses Rup as an index if it is outside
the range. This patch changes the if and else cases.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git2/drivers/char/rio/riocmd.c.orig	2006-06-21 23:14:52.000000000 +0200
+++ linux-2.6.17-git2/drivers/char/rio/riocmd.c	2006-06-21 23:15:21.000000000 +0200
@@ -402,7 +402,7 @@ static int RIOCommandRup(struct rio_info
 		rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: Host number %Zd, name ``%s''\n", HostP - p->RIOHosts, HostP->Name);
 		rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: Rup number  0x%x\n", rup);
 
-		if (Rup >= (unsigned short) MAX_RUP) {
+		if (Rup < (unsigned short) MAX_RUP) {
 			rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: This is the RUP for RTA ``%s''\n", HostP->Mapping[Rup].Name);
 		} else
 			rio_dprintk(RIO_DEBUG_CMD, "CONTROL information: This is the RUP for link ``%c'' of host ``%s''\n", ('A' + Rup - MAX_RUP), HostP->Name);



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTEMCPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 22:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTEMCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:15:31 -0400
Received: from port-212-202-184-60.reverse.qdsl-home.de ([212.202.184.60]:13952
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263130AbTEMCP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:15:29 -0400
Message-ID: <3EC05839.6030702@trash.net>
Date: Tue, 13 May 2003 04:28:09 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix typo in 2.4 ipsec backport
Content-Type: multipart/mixed;
 boundary="------------060402030605020102050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060402030605020102050701
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a 0x10-ptr dereference in __xfrm4_find_acq ;)

0x231 <__xfrm4_find_acq+241>:   incl   0x10

Best regards,
Patrick


--------------060402030605020102050701
Content-Type: text/plain;
 name="xfrm4_state-typo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xfrm4_state-typo.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1210  -> 1.1211 
#	net/ipv4/xfrm4_state.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/13	kaber@trash.net	1.1211
# [IPSEC] fix typo
# --------------------------------------------
#
diff -Nru a/net/ipv4/xfrm4_state.c b/net/ipv4/xfrm4_state.c
--- a/net/ipv4/xfrm4_state.c	Tue May 13 04:22:50 2003
+++ b/net/ipv4/xfrm4_state.c	Tue May 13 04:22:50 2003
@@ -101,7 +101,7 @@
 		x0->lft.hard_add_expires_seconds = XFRM_ACQ_EXPIRES;
 		xfrm_state_hold(x0);
 		mod_timer(&x0->timer, jiffies + XFRM_ACQ_EXPIRES*HZ);
-		xfrm_state_hold(0);
+		xfrm_state_hold(x0);
 		list_add_tail(&x0->bydst, xfrm4_state_afinfo.state_bydst+h);
 		wake_up(&km_waitq);
 	}

--------------060402030605020102050701--


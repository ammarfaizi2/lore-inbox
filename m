Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUBBUDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUBBUB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:01:29 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:7826 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265971AbUBBUAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:00:49 -0500
Date: Mon, 2 Feb 2004 21:00:46 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 31/42]
Message-ID: <20040202200046.GE6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mptbase.c:2906: warning: `pCached' might be used uninitialized in this function

Initialize pCached to NULL.
Avoid printing if pCached is NULL.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/message/fusion/mptbase.c linux-2.4/drivers/message/fusion/mptbase.c
--- linux-2.4-vanilla/drivers/message/fusion/mptbase.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/message/fusion/mptbase.c	Sat Jan 31 21:34:47 2004
@@ -2903,7 +2903,7 @@
 {
 	MpiFwHeader_t		*FwHdr;
 	MpiExtImageHeader_t 	*ExtHdr;
-	fw_image_t		**pCached;
+	fw_image_t		**pCached = NULL;
 	int			 fw_sz;
 	u32			 diag0val;
 #ifdef MPT_DEBUG
@@ -2944,11 +2944,11 @@
 		pCached = (fw_image_t **)ioc->cached_fw;
 	else if (ioc->alt_ioc && (ioc->alt_ioc->cached_fw != NULL))
 		pCached = (fw_image_t **)ioc->alt_ioc->cached_fw;
-
-	ddlprintk((MYIOC_s_INFO_FMT "DbGb2: FW Image @ %p\n",
-			ioc->name, pCached));
 	if (!pCached)
 		return -2;
+	
+	ddlprintk((MYIOC_s_INFO_FMT "DbGb2: FW Image @ %p\n",
+			ioc->name, pCached));
 
 	/* Write magic sequence to WriteSequence register
 	 * until enter diagnostic mode

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente

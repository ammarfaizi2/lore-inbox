Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTHVUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263562AbTHVUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 16:55:56 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:6312 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S263503AbTHVUzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 16:55:48 -0400
To: Marcus Sundberg <marcus@ingate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: PPPoE Oops with 2.4.22-rc
References: <fa.fl74mr0.184m51s@ifi.uio.no> <fa.k5266bj.136mf8l@ifi.uio.no>
From: Junio C Hamano <junkio@cox.net>
Date: Fri, 22 Aug 2003 13:55:46 -0700
In-Reply-To: <fa.k5266bj.136mf8l@ifi.uio.no> (Marcus Sundberg's message of
 "Fri,: 45:04 GMT")
Message-ID: <7v7k559zu5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "MS" == Marcus Sundberg <marcus@ingate.com> writes:

MS> this patch fixes one crash in pppoe_connect():

--- linux-2.4.21-rc2/drivers/net/pppoe.c~	Wed May 14 00:08:52 2003
+++ linux-2.4.21-rc2/drivers/net/pppoe.c	Wed May 14 00:18:47 2003
@@ -606,7 +606,8 @@
 		/* Delete the old binding */
 		delete_item(po->pppoe_pa.sid,po->pppoe_pa.remote);
 
-		dev_put(po->pppoe_dev);
+		if (po->pppoe_dev)
+			dev_put(po->pppoe_dev);
 
 		memset(po, 0, sizeof(struct pppox_opt));
 		po->sk = sk;

Could you explain when/how pppoe_connect gets called with
(pppoe_dev == NULL) but with an old binding?


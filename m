Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUDJI77 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 04:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUDJI77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 04:59:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:58275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261952AbUDJI76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 04:59:58 -0400
Date: Sat, 10 Apr 2004 01:59:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, aarnold@elsa.de
Subject: Re: [BUG 2.2/2.4/2.6] broken memsets in net/sk_mca.c (multicast)
Message-Id: <20040410015936.5ad35c73.akpm@osdl.org>
In-Reply-To: <20040410094924.C32143@flint.arm.linux.org.uk>
References: <20040410102040.022ffb3c.khali@linux-fr.org>
	<20040410014040.48cb037b.akpm@osdl.org>
	<20040410094924.C32143@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Erm...

--- 25/drivers/net/sk_mca.c~sk_mca-multicast-fix	2004-04-10 01:42:29.464928112 -0700
+++ 25-akpm/drivers/net/sk_mca.c	2004-04-10 01:57:20.106530008 -0700
@@ -997,13 +997,13 @@ static void skmca_set_multicast_list(str
 		block.Mode &= ~LANCE_INIT_PROM;
 
 	if (dev->flags & IFF_ALLMULTI) {	/* get all multicasts */
-		memset(block.LAdrF, 8, 0xff);
+		memset(block.LAdrF, 0xff, sizeof(block.LAdrF));
 	} else {		/* get selected/no multicasts */
 
 		struct dev_mc_list *mptr;
 		int code;
 
-		memset(block.LAdrF, 8, 0x00);
+		memset(block.LAdrF, 0, sizeof(block.LAdrF));
 		for (mptr = dev->mc_list; mptr != NULL; mptr = mptr->next) {
 			code = GetHash(mptr->dmi_addr);
 			block.LAdrF[(code >> 3) & 7] |= 1 << (code & 7);

_


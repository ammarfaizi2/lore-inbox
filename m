Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935007AbWKXS6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935007AbWKXS6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935010AbWKXS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:58:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:51481 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S935007AbWKXS6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:58:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JyDrLwCZWVQOn8p0IVbfy8tTr+jqWvbHiF6YTUTHwQl3CFIcgAzZVt99FBZmFfsH5OHj9Ft1Qll7TNkO7vsgcMbDV7/PRD78n9UBPCEEdHtDSFuGLfMPQu9JMSoAmYbKDXP5Z9ED3lManmKkav2eVFYUpfZADbV7ziPoVwyBSfQ=
Date: Fri, 24 Nov 2006 21:58:16 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andreas Koensgen <ajk@iehk.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>, akpm@osdl.org
Subject: [PATCH] 6pack: fix "&= !" typo
Message-ID: <20061124185816.GB4973@martell.zuzino.mipt.ru>
References: <20061122225856.GB10758@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122225856.GB10758@1wt.eu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas, is this correct?
---------------------------------
SIXP_RX_DCD_MASK is 0x18, so the command below will make cmd 0 always.
This is likely wrong.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/net/hamradio/6pack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -914,7 +914,7 @@ static void decode_prio_command(struct s
 					printk(KERN_DEBUG "6pack: protocol violation\n");
 				else
 					sp->status = 0;
-				cmd &= !SIXP_RX_DCD_MASK;
+				cmd &= ~SIXP_RX_DCD_MASK;
 		}
 		sp->status = cmd & SIXP_PRIO_DATA_MASK;
 	} else { /* output watchdog char if idle */


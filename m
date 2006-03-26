Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWCZNt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWCZNt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWCZNt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:49:28 -0500
Received: from wproxy.gmail.com ([64.233.184.236]:18883 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932077AbWCZNt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:49:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T5lyI19V0SPv9GhMcDqrpQkK8I1PxcbxmzwMcf/lqFY4E1h7lH+rttaZcI27D9tTZcr+LshFXUpZwM7l48Yj43UQbNeNGm8r6K/0nfl/fcEsyE9O+hnbXLwyuR6E2XPipyVZVSIFj4Np4Pt1Leu/2eMkaMC07q9VL0/CUvxWITk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix resource leak in pnp card_probe()
Date: Sun, 26 Mar 2006 15:50:01 +0200
User-Agent: KMail/1.9.1
Cc: Adam Belay <ambx1@neo.rr.com>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603261550.01752.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We can leak `clink' in drivers/pnp/card.c::card_probe()


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/pnp/card.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16-mm1-orig/drivers/pnp/card.c	2006-03-26 13:43:38.000000000 +0200
+++ linux-2.6.16-mm1/drivers/pnp/card.c	2006-03-26 15:45:00.000000000 +0200
@@ -81,8 +81,10 @@ static int card_probe(struct pnp_card * 
 				}
 				kfree(clink);
 			}
-		} else
+		} else {
+			kfree(clink);
 			return 1;
+		}
 	}
 	return 0;
 }




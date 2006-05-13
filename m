Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWEMUes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWEMUes (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 16:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWEMUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 16:34:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:10702 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750818AbWEMUer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 16:34:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=Hguszpn0OgxSn1FgXyB7sklk+sQDEW9RLABRhSqKM5PWFbuW6PuJmI9dhBa2Ayn80/04KMa7eFgbEL0VIICRYFxAPW2itKsv4n2GJE52+cNtR6PZ4J0tedjJlhkj/iQJ8cWcu8dfhN5U3dz5eW9ad0B2i0tMG7qOuq4IxeCYTro=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][resend] fix resource leak in pnp card_probe()
Date: Sat, 13 May 2006 22:35:42 +0200
User-Agent: KMail/1.9.1
Cc: Adam Belay <ambx1@neo.rr.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605132235.42338.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend of patch already send once on 23/03-2006 
  - still applies cleanly to latest -git)


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




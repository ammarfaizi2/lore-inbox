Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269534AbUIZNxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269534AbUIZNxI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 09:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUIZNxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 09:53:08 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:3816 "EHLO
	mwinf0904.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269534AbUIZNxE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 09:53:04 -0400
From: Fabrice =?iso-8859-1?q?M=E9nard?= <menard.fabrice@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: fbcon and unimap (kernel 2.6.8.1) again
Date: Sun, 26 Sep 2004 15:53:15 +0200
User-Agent: KMail/1.7
Cc: jsimmons@infradead.org, geert@linux-m68k.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409261553.16053.menard.fabrice@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Switching from 2.6.5 to 2.6.8.1, I found the same problem with accented chars 
at boot time (fbcon didn't set a unicode map in 2.6.5).
Looking into fbcon.c, I found that in the 2.6.8.1 release it is done in 
fbcon_startup (fbcon.c).  I don't know exactly the internals but I think this 
call is misplaced (maybe too late for the boot process ?).

So I placed a call to con_set_default_unimap in fbcon_init and it works fine !

Here is the patch

--- linux-2.6.8.1/drivers/video/console/fbcon.c.orig 2004-09-26 
15:48:10.000000000 +0200
+++ linux-2.6.8.1/drivers/video/console/fbcon.c 2004-09-26 14:27:37.000000000 
+0200
@@ -853,6 +853,7 @@ static void fbcon_init(struct vc_data *v
    softback_top = 0;
   }
  }
+ con_set_default_unimap(vc->vc_num);
 }
 
 static void fbcon_deinit(struct vc_data *vc)

(I think it doesn't hurt to leave the previous call in fbcont_startup)

regards,

-- 
Fabrice Ménard
menard.fabrice@wanadoo.fr

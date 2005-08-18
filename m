Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVHRWyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVHRWyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVHRWyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:54:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23303 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750710AbVHRWyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:54:32 -0400
Date: Fri, 19 Aug 2005 00:54:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [2.6.13-rc6-rt9 patch] fix DECNET_ROUTER=y compile
Message-ID: <20050818225423.GH3822@stusta.de>
References: <20050818060126.GA13152@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818060126.GA13152@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't compile with CONFIG_DECNET_ROUTER=y:

<--  snip  -->

...
  CC      net/decnet/dn_dev.o
net/decnet/dn_dev.c: In function 'dn_forwarding_proc':
net/decnet/dn_dev.c:335: error: 'struct dn_dev_parms' has no member named 'down'
net/decnet/dn_dev.c:336: error: syntax error before 'do'
net/decnet/dn_dev.c:338: error: 'struct dn_dev_parms' has no member named 'up'
net/decnet/dn_dev.c:339: error: syntax error before 'do'
net/decnet/dn_dev.c:339: warning: control reaches end of non-void function
net/decnet/dn_dev.c: In function 'dn_forwarding_sysctl':
net/decnet/dn_dev.c:374: error: 'struct dn_dev_parms' has no member named 'down'
net/decnet/dn_dev.c:375: error: syntax error before 'do'
net/decnet/dn_dev.c:377: error: 'struct dn_dev_parms' has no member named 'up'
net/decnet/dn_dev.c:378: error: syntax error before 'do'
net/decnet/dn_dev.c:378: warning: control reaches end of non-void function
make[2]: *** [net/decnet/dn_dev.o] Error 1

<--  snip  -->



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-rt9/net/decnet/dn_dev.c.old	2005-08-19 00:00:41.000000000 +0200
+++ linux-2.6.13-rc6-rt9/net/decnet/dn_dev.c	2005-08-19 00:02:14.000000000 +0200
@@ -332,11 +332,11 @@
 		 */
 		tmp = dn_db->parms.forwarding;
 		dn_db->parms.forwarding = old;
-		if (dn_db->parms.down)
-			dn_db->parms.down(dev);
+		if (dn_db->parms.dn_down)
+			dn_db->parms.dn_down(dev);
 		dn_db->parms.forwarding = tmp;
-		if (dn_db->parms.up)
-			dn_db->parms.up(dev);
+		if (dn_db->parms.dn_up)
+			dn_db->parms.dn_up(dev);
 	}
 
 	return err;
@@ -371,11 +371,11 @@
 		if (value > 2)
 			return -EINVAL;
 
-		if (dn_db->parms.down)
-			dn_db->parms.down(dev);
+		if (dn_db->parms.dn_down)
+			dn_db->parms.dn_down(dev);
 		dn_db->parms.forwarding = value;
-		if (dn_db->parms.up)
-			dn_db->parms.up(dev);
+		if (dn_db->parms.dn_up)
+			dn_db->parms.dn_up(dev);
 	}
 
 	return 0;


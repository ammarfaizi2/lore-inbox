Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319214AbSH2Oxc>; Thu, 29 Aug 2002 10:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319215AbSH2Oxc>; Thu, 29 Aug 2002 10:53:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6139 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319214AbSH2Oxb>;
	Thu, 29 Aug 2002 10:53:31 -0400
Subject: [PATCH] Fix compile error in ip_nat_helper.c
From: Paul Larson <plars@linuxtestproject.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, davem@redhat.com
In-Reply-To: <20020829.071452.16869863.davem@redhat.com>
References: <1030629915.5187.13.camel@plars.austin.ibm.com> 
	<20020829.071452.16869863.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 09:47:15 -0500
Message-Id: <1030632439.5187.27.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 09:14, David S. Miller wrote:
>    From: Paul Larson <plars@austin.ibm.com>
>    Date: 29 Aug 2002 09:05:14 -0500
> 
>    The nightly bk testing last night found a new build error last night
>    with ip_nat_helper
> 
> Just some __FUNCTION__ string pasting that newer GCC doesn't like.
> Feel free to submit a patch.

I guess this is one of the "pasters" noted in:
ChangeSet@1.552, 2002-08-28 14:53:09-07:00,
torvalds@penguin.transmeta.com
  Add some fascist code to trap __FUNCTION__ pasting, fix up
  some more pasters.

Please apply.  Thanks,
Paul Larson
Linux Test Project
http://www.linuxtestproject.org
-------------------------------

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.553   -> 1.554  
#	net/ipv4/netfilter/ip_nat_helper.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/29	plars@austin.ibm.com	1.554
# Fix compile failure in ip_nat_helper.c
# --------------------------------------------
#
diff -Nru a/net/ipv4/netfilter/ip_nat_helper.c b/net/ipv4/netfilter/ip_nat_helper.c
--- a/net/ipv4/netfilter/ip_nat_helper.c	Thu Aug 29 10:25:10 2002
+++ b/net/ipv4/netfilter/ip_nat_helper.c	Thu Aug 29 10:25:10 2002
@@ -382,9 +382,9 @@
 			const char *tmp = me->me->name;
 			
 			if (strlen(tmp) + 6 > MODULE_MAX_NAMELEN) {
-				printk(__FUNCTION__ ": unable to "
+				printk("%s: unable to "
 				       "compute conntrack helper name "
-				       "from %s\n", tmp);
+				       "from %s\n",__FUNCTION__, tmp);
 				return -EBUSY;
 			}
 			tmp += 6;
@@ -467,7 +467,7 @@
 		    && ct_helper->me) {
 			__MOD_DEC_USE_COUNT(ct_helper->me);
 		} else 
-			printk(__FUNCTION__ ": unable to decrement usage count"
-			       " of conntrack helper %s\n", me->me->name);
+			printk("%s: unable to decrement usage count"
+			       " of conntrack helper %s\n",__FUNCTION__, me->me->name);
 	}
 }


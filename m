Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbTC0MYX>; Thu, 27 Mar 2003 07:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbTC0MYX>; Thu, 27 Mar 2003 07:24:23 -0500
Received: from port-212-202-184-205.reverse.qdsl-home.de ([212.202.184.205]:59833
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S262103AbTC0MYV>; Thu, 27 Mar 2003 07:24:21 -0500
Message-ID: <3E82F00F.7@trash.net>
Date: Thu, 27 Mar 2003 13:35:27 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Chris Sykes <chris@sigsegv.plus.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
References: <20030326162538.GG2695@spackhandychoptubes.co.uk>	<20030326185236.GE24689@kroah.com>	<20030326192520.GH2695@spackhandychoptubes.co.uk>	<20030326193437.GI24689@kroah.com>	<20030327111600.GI2695@spackhandychoptubes.co.uk> <20030327131214.1dae4005.skraw@ithnet.com>
In-Reply-To: <20030327131214.1dae4005.skraw@ithnet.com>
Content-Type: multipart/mixed;
 boundary="------------060109030303090507030305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060109030303090507030305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The ISDN bug is fixed, i sent a patch to LKML and the Maintainer last week.
I've attached the fix again, the one in isdn_ppp.c is responsible for 
the BUG()s.

Patrick


Stephan von Krawczynski wrote:

>Hello all,
>
>I just wanted to hint that this very same BUG message appears on channel
>bundling of ISDN, too. Greg, can you give a short description for this race
>please, as I would like to find it in the ISDN-code, maybe your ideas help...
>
>Thanks,
>Stephan
>
>  
>
>  
>

--------------060109030303090507030305
Content-Type: text/plain;
 name="isdn-locking-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn-locking-fixes.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1055  -> 1.1056 
#	drivers/isdn/isdn_net.c	1.15    -> 1.16   
#	drivers/isdn/isdn_ppp.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/27	kaber@trash.net	1.1056
# [ISDN]: locking fixes
# --------------------------------------------
#
diff -Nru a/drivers/isdn/isdn_net.c b/drivers/isdn/isdn_net.c
--- a/drivers/isdn/isdn_net.c	Thu Mar 27 02:00:21 2003
+++ b/drivers/isdn/isdn_net.c	Thu Mar 27 02:00:21 2003
@@ -2831,6 +2831,7 @@
 
 			/* If binding is exclusive, try to grab the channel */
 			save_flags(flags);
+			cli();
 			if ((i = isdn_get_free_channel(ISDN_USAGE_NET,
 				lp->l2_proto, lp->l3_proto, drvidx,
 				chidx, lp->msn)) < 0) {
diff -Nru a/drivers/isdn/isdn_ppp.c b/drivers/isdn/isdn_ppp.c
--- a/drivers/isdn/isdn_ppp.c	Thu Mar 27 02:00:21 2003
+++ b/drivers/isdn/isdn_ppp.c	Thu Mar 27 02:00:21 2003
@@ -1176,7 +1176,7 @@
 	if (!lp) {
 		printk(KERN_WARNING "%s: all channels busy - requeuing!\n", netdev->name);
 		retval = 1;
-		goto unlock;
+		goto out;
 	}
 	/* we have our lp locked from now on */
 

--------------060109030303090507030305--


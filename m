Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289891AbSAKH57>; Fri, 11 Jan 2002 02:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289892AbSAKH5t>; Fri, 11 Jan 2002 02:57:49 -0500
Received: from [202.135.142.194] ([202.135.142.194]:19719 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289891AbSAKH5b>; Fri, 11 Jan 2002 02:57:31 -0500
Date: Fri, 11 Jan 2002 09:57:22 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jos <jdomingo@internautas.org>
Cc: linux-kernel@vger.kernel.org, mark.huth@mvista.com, ctindel@ieee.org
Subject: Re: [BUG]: bonding module parameter problem
Message-Id: <20020111095722.2038e08d.rusty@rustcorp.com.au>
In-Reply-To: <20020109221354.GB3965@localhost>
In-Reply-To: <20020109221354.GB3965@localhost>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002 23:13:55 +0100
Jos <jdomingo@internautas.org> wrote:
> At /usr/src/linux/drivers/net/bonding.c, line 229:
> MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
> MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");

This is wrong.  When I did my module rewrite patch, I noted a number of
mis-uses of the MODULE_PARM macro (mine does type checking, so the compiler
found them).

You are saying that max_bonds is an ARRAY of 1-INT_MAX integers!
The same mistake is made in the patch on sf.net/projects/bonding/.

Here is the patch against .17, for inspiration:

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.17/drivers/net/bonding.c working-2.4.17-wagner/drivers/net/bonding.c
--- linux-2.4.17/drivers/net/bonding.c	Thu Dec 27 12:45:05 2001
+++ working-2.4.17-wagner/drivers/net/bonding.c	Fri Jan 11 09:46:08 2002
@@ -226,7 +226,7 @@
 static struct bonding *these_bonds =  NULL;
 static struct net_device *dev_bonds = NULL;
 
-MODULE_PARM(max_bonds, "1-" __MODULE_STRING(INT_MAX) "i");
+MODULE_PARM(max_bonds, "i");
 MODULE_PARM_DESC(max_bonds, "Max number of bonded devices");
 MODULE_PARM(miimon, "i");
 MODULE_PARM_DESC(miimon, "Link check interval in milliseconds");

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSFKA77>; Mon, 10 Jun 2002 20:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSFKA76>; Mon, 10 Jun 2002 20:59:58 -0400
Received: from pD952A4ED.dip.t-dialin.net ([217.82.164.237]:8899 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315421AbSFKA75>; Mon, 10 Jun 2002 20:59:57 -0400
Date: Mon, 10 Jun 2002 18:59:36 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: David Ford <david+cert@blue-labs.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre10-ac2, compile warnings/failures
In-Reply-To: <3D0518BF.4090404@blue-labs.org>
Message-ID: <Pine.LNX.4.44.0206101855290.17269-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, David Ford wrote:
> People, please don't do things like:
> 
> [bad use of doublequotes]
> 
> Patches keep going in to fix this.
> 
> [good use of doublequotes]

The same applies to 2.5. Can someone write a perl script that treats it so 
anonymous that it can find these buggy places?

Index: drivers/message/i2o/i2o_core.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/message/i2o/i2o_core.c,v
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/message/i2o/i2o_core.c	10 Jun 2002 15:17:07 -0000	1.1
+++ thunder-2.5/drivers/message/i2o/i2o_core.c	11 Jun 2002 00:54:24 -0000	1.2
@@ -3407,8 +3407,9 @@ static int i2o_reboot_event(struct notif
 	{
 		if(i2o_quiesce_controller(c))
 		{
-			printk(KERN_WARNING "i2o: Could not quiesce %s."  "
-				Verify setup on next system power up.\n", c->name);
+			printk(KERN_WARNING "i2o: Could not quiesce %s."
+			       "Verify setup on next system power up.\n",
+			       c->name);
 		}
 	}
 
Index: drivers/hotplug/cpqphp_nvram.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/hotplug/cpqphp_nvram.c,v
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/hotplug/cpqphp_nvram.c	10 Jun 2002 15:13:54 -0000	1.1
+++ thunder-2.5/drivers/hotplug/cpqphp_nvram.c	11 Jun 2002 00:54:24 -0000	1.2
@@ -176,12 +176,12 @@ static u32 access_EV (u16 operation, u8 
 	
 	spin_lock_irqsave(&int15_lock, flags);
 	__asm__ (
-		"xorl   %%ebx,%%ebx
-		xorl    %%edx,%%edx
-		pushf
-		push    %%cs
-		cli
-		call    *%6"
+		"xorl   %%ebx,%%ebx \n"
+		"xorl   %%edx,%%edx \n"
+		"pushf              \n"
+		"push    %%cs       \n"
+		"cli                \n"
+		"call    *%6        \n"
 		: "=c" (*buf_size), "=a" (ret_val)
 		: "a" (op), "c" (*buf_size), "S" (ev_name),
 		"D" (buffer), "m" (compaq_int15_entry_point)

Regards,
Thunder
--
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere


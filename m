Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129160AbRBMArb>; Mon, 12 Feb 2001 19:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRBMArV>; Mon, 12 Feb 2001 19:47:21 -0500
Received: from cs.columbia.edu ([128.59.16.20]:11235 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129160AbRBMArJ>;
	Mon, 12 Feb 2001 19:47:09 -0500
Date: Mon, 12 Feb 2001 16:46:59 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new version of the starfire driver for 2.2.19pre
In-Reply-To: <Pine.LNX.4.30.0102121151240.4687-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.30.0102121644200.4687-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Ion Badulescu wrote:

> Here is an incremental patch from the version in 2.2.19pre10 to the latest 
> version of starfire.c. Please apply, the 2219pre10 version doesn't work if 
> compiled-in (because drivers/net builds net.a not net.o). It also fixes 
> the MII interface detection problem mentioned by Don Becker.
> 
> The patch is longish, but it's mostly whitespace and moving code around. 
> It also removes all the code that's #ifdef ZEROCOPY, since Jeff Garzik 
> doesn't want it in 2.4.x and it definitely can't work in 2.2.x.

And of course I forgot to diff Space.c. Patch attached, sorry about that.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
----------------
--- /usr/src/local/linux-2.2.18-vanilla/drivers/net/Space.c	Sun Dec 10 16:49:42 2000
+++ linux-2.2.18/drivers/net/Space.c	Sun Feb 11 14:53:02 2001
@@ -126,6 +126,7 @@
 extern int rcpci_probe(struct device *);
 extern int dmfe_probe(struct device *);
 extern int sktr_probe(struct device *dev);
+extern int starfire_probe(struct device *dev);
 
 /* Gigabit Ethernet adapters */
 extern int yellowfin_probe(struct device *dev);
@@ -277,9 +278,12 @@
 #ifdef CONFIG_VIA_RHINE
 	{via_rhine_probe, 0},
 #endif
-#ifdef CONFI_NET_DM9102
+#ifdef CONFIG_NET_DM9102
 	{dmfe_probe, 0},
-#endif	
+#endif
+#ifdef CONFIG_ADAPTEC_STARFIRE
+	{starfire_probe, 0},
+#endif
 	{NULL, 0},
 };
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

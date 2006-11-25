Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967135AbWKYTRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967135AbWKYTRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967142AbWKYTRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:17:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2061 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967137AbWKYTQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:16:50 -0500
Date: Sat, 25 Nov 2006 20:16:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [2.6 patch] make hdlc_setup() static again
Message-ID: <20061125191653.GJ3702@stusta.de>
References: <20060625205137.GH23314@stusta.de> <m3veqnlnsh.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3veqnlnsh.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 09:28:14PM +0200, Krzysztof Halasa wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> >    hdlc_setup() is now EXPORTed as per David's request.
> >
> > Is a usage of this export pending for the near future
> 
> I'm told it is.

It's still not used...

So let's unexport it again until some driver that actually uses it shows up.

> Krzysztof Halasa

cu
Adrian


<--  snip  -->


hdlc_setup was exported, but this export was never used.

If adriver using it actually shows up it can still be exported again.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/drivers/net/wan/hdlc.c.old	2006-11-25 00:16:13.000000000 +0100
+++ linux-2.6.19-rc6-mm1/drivers/net/wan/hdlc.c	2006-11-25 00:16:26.000000000 +0100
@@ -222,7 +222,7 @@
 	return -EINVAL;
 }
 
-void hdlc_setup(struct net_device *dev)
+static void hdlc_setup(struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 
@@ -325,7 +325,6 @@
 EXPORT_SYMBOL(hdlc_open);
 EXPORT_SYMBOL(hdlc_close);
 EXPORT_SYMBOL(hdlc_ioctl);
-EXPORT_SYMBOL(hdlc_setup);
 EXPORT_SYMBOL(alloc_hdlcdev);
 EXPORT_SYMBOL(unregister_hdlc_device);
 EXPORT_SYMBOL(register_hdlc_protocol);


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268726AbUI3FPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268726AbUI3FPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUI3FPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:15:41 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:43744 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S268726AbUI3FPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:15:34 -0400
Subject: Re: Linux 2.6.9-rc3
From: Marcel Holtmann <marcel@holtmann.org>
To: Tom Duffy <Tom.Duffy@Sun.COM>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <415B93AC.3010502@sun.com>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
	 <415B93AC.3010502@sun.com>
Content-Type: multipart/mixed; boundary="=-j9UFUcmjDeFe7muTTTft"
Message-Id: <1096521269.5181.1.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 30 Sep 2004 07:14:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j9UFUcmjDeFe7muTTTft
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tom,

> > Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and hopefully 
> > we're getting there now.
> 
>    CC [M]  drivers/isdn/capi/capi.o
> /build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function 
> `handle_minor_send':
> /build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:538:
> warning: cast from pointer to integer of different size
> /build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function 
> `capi_recv_message':
> /build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
> error: `tty' undeclared (first use in this function)
> /build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
> error: (Each undeclared identifier is reported only once
> /build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
> error: for each function it appears in.)
> make[4]: *** [drivers/isdn/capi/capi.o] Error 1
> make[3]: *** [drivers/isdn/capi] Error 2
> make[2]: *** [drivers/isdn] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [_all] Error 2

the attached patch should fix it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


--=-j9UFUcmjDeFe7muTTTft
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/isdn/capi/capi.c 1.59 vs edited =====
--- 1.59/drivers/isdn/capi/capi.c	2004-09-29 17:03:13 +02:00
+++ edited/drivers/isdn/capi/capi.c	2004-09-30 00:57:58 +02:00
@@ -646,7 +650,7 @@
 		kfree_skb(skb);
 		(void)capiminor_del_ack(mp, datahandle);
 		if (mp->tty)
-			tty_wakeup(tty);
+			tty_wakeup(mp->tty);
 		(void)handle_minor_send(mp);
 
 	} else {
===== drivers/isdn/i4l/isdn_tty.c 1.60 vs edited =====
--- 1.60/drivers/isdn/i4l/isdn_tty.c	2004-09-29 17:02:20 +02:00
+++ edited/drivers/isdn/i4l/isdn_tty.c	2004-09-30 00:59:48 +02:00
@@ -2673,7 +2673,7 @@
 		if ((info->flags & ISDN_ASYNC_CLOSING) || (!info->tty)) {
 			return;
 		}
-		tty_ldisc_flush(tty);
+		tty_ldisc_flush(info->tty);
 		if ((info->flags & ISDN_ASYNC_CHECK_CD) &&
 		    (!((info->flags & ISDN_ASYNC_CALLOUT_ACTIVE) &&
 		       (info->flags & ISDN_ASYNC_CALLOUT_NOHUP)))) {

--=-j9UFUcmjDeFe7muTTTft--


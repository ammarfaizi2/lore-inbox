Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWCOEaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWCOEaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 23:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWCOEaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 23:30:07 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:21549 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbWCOEaF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 23:30:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DJWGgIC3/Ft/jvewJ/upH4PhG095eVRq+NhdWG+InMGI3m5wf/yPkN4vgdrFFHnjkA81yZlp2D45LR5PEjWx5LLutCElGbUTrlKpgU0CYC8ZUZ4BsuGpH+tjV+NNw2frEkuGA6AbX7ArYZO2skxtUTIhMOUYvreQ5V8yJOYGdqk=
Message-ID: <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
Date: Wed, 15 Mar 2006 12:30:04 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Lanslott Gish" <lanslott.gish@gmail.com>,
       "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>,
       "Greg KH" <greg@kroah.com>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
In-Reply-To: <20060314103854.GC32065@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <200603112155.38984.daniel.ritz-ml@swissonline.ch>
	 <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com>
	 <38c09b90603131710p7932c12qf6e8602b9b0b59c8@mail.gmail.com>
	 <20060314103854.GC32065@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

did you mean like that? thx.

regards,

Lanslott Gish
===================================================================
--- linux-2.6.16-rc6.patched/drivers/usb/input/usbtouchscreen.c
+++ linux-2.6.16-rc6/drivers/usb/input/usbtouchscreen.c
@@ -49,6 +49,13 @@
 static int swap_xy;
 module_param(swap_xy, bool, 0644);
 MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
+static int swap_x;
+module_param(swap_x, bool, 0644);
+MODULE_PARM_DESC(swap_x, "If set X axe is swapped before XY swapped.");
+static int swap_y;
+module_param(swap_y, bool, 0644);
+MODULE_PARM_DESC(swap_y, "If set Y axe is swapped before XY swapped.");
+


 /* device specifc data/functions */
@@ -224,13 +231,17 @@
  * PanJit Part
  */
 #ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
+
 static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *press)
 {
-       *x = pkt[1] | (pkt[2] << 8);
-       *y = pkt[3] | (pkt[4] << 8);
+       *x = (pkt[1] & 0x0F) | ((pkt[2]& 0xFF) << 8);
+       *y = (pkt[3] & 0x0F) | ((pkt[4]& 0xFF) << 8);
        *touch = (pkt[0] & 0x01) ? 1 : 0;

-       return 1;
+	if(swap_x) *x = *x ^ 0x0FFF;
+	if(swap_y) *y = *y ^ 0x0FFF;
+
+ 	return 1;
 }
 #endif
===================================================================

On 3/14/06, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Tue, 2006-03-14 09:10:13 +0800, Lanslott Gish <lanslott.gish@gmail.com> wrote:
> > i fixed some codes and add swap_x & swap_y functions.
> > and test your patch passed for my touchset hrdware.
> > here is the patch only for your usbtouchscreen.c
> > could you help to apply this?
> > thank you.
> >
> > Regards,
> >
> > Lanslott Gish
> >
> > ==============================================================

>
> Um, I think it's generally a good idea to allow this, but I'd say this
> should go into the common code part using the pre-known number range.
>
> MfG, JBG
>
> --
> Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             _ O _
> "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  _ _ O
>  für einen Freien Staat voll Freier Bürger"  | im Internet! |   im Irak!   O O O
> ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA));
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
>
> iD8DBQFEFp0+Hb1edYOZ4bsRAhntAJ9tmcgcvR57teoeJIaJRqxBbrQpoACeNPFE
> HrHJmjM0mkN9ZQsvARoLx+0=
> =06aU
> -----END PGP SIGNATURE-----
>
>
>


--
L.G, Life's Good~

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWCOVxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWCOVxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWCOVxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:53:09 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:45526 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751327AbWCOVxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:53:08 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: "Lanslott Gish" <lanslott.gish@gmail.com>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Date: Wed, 15 Mar 2006 22:53:23 +0100
User-Agent: KMail/1.7.2
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <20060314103854.GC32065@lug-owl.de> <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
In-Reply-To: <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603152253.24194.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-04.tornado.cablecom.ch 32701;
	Body=9 Fuz1=9 Fuz2=9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 05.30, Lanslott Gish wrote:
> did you mean like that? thx.
> 
> regards,
> 
> Lanslott Gish
> ===================================================================
> --- linux-2.6.16-rc6.patched/drivers/usb/input/usbtouchscreen.c
> +++ linux-2.6.16-rc6/drivers/usb/input/usbtouchscreen.c
> @@ -49,6 +49,13 @@
>  static int swap_xy;
>  module_param(swap_xy, bool, 0644);
>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> +static int swap_x;
> +module_param(swap_x, bool, 0644);
> +MODULE_PARM_DESC(swap_x, "If set X axe is swapped before XY swapped.");
> +static int swap_y;
> +module_param(swap_y, bool, 0644);
> +MODULE_PARM_DESC(swap_y, "If set Y axe is swapped before XY swapped.");
> +
> 
(i prefer invert_x and invert_y...)

> 
>  /* device specifc data/functions */
> @@ -224,13 +231,17 @@
>   * PanJit Part
>   */
>  #ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
> +
>  static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *press)
>  {
> -       *x = pkt[1] | (pkt[2] << 8);
> -       *y = pkt[3] | (pkt[4] << 8);
> +       *x = (pkt[1] & 0x0F) | ((pkt[2]& 0xFF) << 8);
> +       *y = (pkt[3] & 0x0F) | ((pkt[4]& 0xFF) << 8);

that just can't be right. you probably mean
+       *y = pkt[3] | ((pkt[4] & 0x0F) << 8);

otherwise you mask out bits 4-7. but you want to limit it to 12 bits...
(btw. no need for the & 0xFF mask since *pkt is char)


anyway, i updated the driver with all the comments i got so far.
will send out in a minute as a new mail.

rgds
-daniel

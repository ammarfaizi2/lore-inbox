Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSGSLp3>; Fri, 19 Jul 2002 07:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSGSLp3>; Fri, 19 Jul 2002 07:45:29 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:28908 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S315988AbSGSLp2>;
	Fri, 19 Jul 2002 07:45:28 -0400
Date: Fri, 19 Jul 2002 08:52:39 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       jsimmons@transvirtual.com
Subject: Re: [PATCH] CONFIG_MAGIC_SYSRQ without CONFIG_VT broken in 2.5.26
Message-ID: <20020719085239.F1424@almesberger.net>
References: <20020718220635.A15794@almesberger.net> <20020719091017.A28569@flint.arm.linux.org.uk> <20020719105244.GB13706@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719105244.GB13706@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Fri, Jul 19, 2002 at 12:52:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Gustafsson wrote:
> Shouldn't that be something more like?
> 
> +#ifdef CONFIG_VT
>  /* r */      &sysrq_unraw_op,
> +#else
> +/* r */      NULL,
> +#endif

Argl, I'm an idiot. Yes, you're absolutely right. Corrected patch
below.

- Werner

------------------------------------ patch ------------------------------------

--- linux-2.5.26/drivers/char/sysrq.c.orig	Fri Jul 19 08:37:18 2002
+++ linux-2.5.26/drivers/char/sysrq.c	Fri Jul 19 08:37:53 2002
@@ -74,7 +74,6 @@
 	help_msg:	"saK",
 	action_msg:	"SAK",
 };
-#endif
 
 
 /* unraw sysrq handler */
@@ -91,6 +90,7 @@
 	help_msg:	"unRaw",
 	action_msg:	"Keyboard mode set to XLATE",
 };
+#endif /* CONFIG_VT */
 
 
 /* reboot sysrq handler */
@@ -371,7 +371,11 @@
 		 as 'Off' at init time */
 /* p */	&sysrq_showregs_op,
 /* q */	NULL,
+#ifdef CONFIG_VT
 /* r */	&sysrq_unraw_op,
+#else
+/* r */	NULL,
+#endif
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/

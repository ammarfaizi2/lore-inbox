Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318461AbSGSIHU>; Fri, 19 Jul 2002 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318462AbSGSIHU>; Fri, 19 Jul 2002 04:07:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36105 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318461AbSGSIHS>; Fri, 19 Jul 2002 04:07:18 -0400
Date: Fri, 19 Jul 2002 09:10:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: linux-kernel@vger.kernel.org, jsimmons@transvirtual.com
Subject: Re: [PATCH] CONFIG_MAGIC_SYSRQ without CONFIG_VT broken in 2.5.26
Message-ID: <20020719091017.A28569@flint.arm.linux.org.uk>
References: <20020718220635.A15794@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020718220635.A15794@almesberger.net>; from wa@almesberger.net on Thu, Jul 18, 2002 at 10:06:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 10:06:35PM -0300, Werner Almesberger wrote:
> 2.5.26 fails with missing symbols fg_console and kbd_table if
> enabling Magic SysRq but disabling virtual terminals. The
> trivial patch below fixes this.

I posted a fix for this on July 17th.  However, yours looks better.
James?

> ------------------------------------ patch ------------------------------------

--- linux-2.5.26/drivers/char/sysrq.c.orig	Thu Jul 18 12:55:09 2002
+++ linux-2.5.26/drivers/char/sysrq.c	Thu Jul 18 12:55:15 2002
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
@@ -371,7 +371,9 @@
 		 as 'Off' at init time */
 /* p */	&sysrq_showregs_op,
 /* q */	NULL,
+#ifdef CONFIG_VT
 /* r */	&sysrq_unraw_op,
+#endif
 /* s */	&sysrq_sync_op,
 /* t */	&sysrq_showstate_op,
 /* u */	&sysrq_mountro_op,

> -- 
>   _________________________________________________________________________
>  / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
> /_http://icapeople.epfl.ch/almesber/_____________________________________/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


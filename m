Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTL3EWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTL3EWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:22:06 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:26999 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262015AbTL3EWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:22:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: walt <wa1ter@myrealbox.com>
Subject: Re: PS2 mouse changes for 2.6
Date: Mon, 29 Dec 2003 23:21:53 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <fa.fl0st45.t3auq7@ifi.uio.no> <fa.jm00pl0.5nsn3g@ifi.uio.no> <3FF0CC02.9000508@myrealbox.com>
In-Reply-To: <3FF0CC02.9000508@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312292321.55287.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 07:51 pm, walt wrote:
> Dmitry Torokhov wrote:
> > On Monday 29 December 2003 09:01 am, walt wrote:
> >>I see no deprecation warnings when starting the kernel with
> >>psmouse_noext, which I was expecting to see.
> >
> > It is emitted with KERN_WARNING severity and is not necessary seen on
> > the console. Check your dmesg.
>
> No warnings in dmesg on two different machines booted with
> psmouse_noext.
>
> I am NOT complaining -- my mouse works better today than yesterday :0)
>
> Is there anything I can do to help with this problem (?)

OK, when I switched the parameter processing to the new technique I missed
the fact that it requires specifying prefix (module name + '.') when the
module is compiled directly into the kernel. Therefore in the lastest -bk
you have to pass "psmouse.psmouse_noext=1" to the kernel for it to be.
recognized.

Since we already have an unique prefix (psmouse) for all parameters and
changing parameter names at this time is not desirable (IMHO) I propose
the patch below to restore the old behavior.

Dmitry

===================================================================


ChangeSet@1.1517, 2003-12-29 22:53:14-05:00, dtor_core@ameritech.net
  Input: Suppress prefix generation for psmouse parameter names
         regardless of whether psmouse is built as a module or
         compiled into the kernel image


 psmouse-base.c |    9 +++++++++
 1 files changed, 9 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Mon Dec 29 23:20:41 2003
+++ b/drivers/input/mouse/psmouse-base.c	Mon Dec 29 23:20:41 2003
@@ -22,6 +22,15 @@
 #include "synaptics.h"
 #include "logips2pp.h"
 
+/*
+ * Reset module param prefix regardless of whether we build psmouse as
+ * a module or directly into kernel, otherwise for build-in case
+ * parameters will have to be specified as psmouse.psmouse_proto which
+ * is unsightly
+ */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX /* empty */
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
 MODULE_LICENSE("GPL");

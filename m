Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTL3EiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTL3EiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:38:12 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:40579 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264444AbTL3EiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:38:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg Fitzgerald <gregf@bigtimegeeks.com>, linux-kernel@vger.kernel.org
Subject: Re: psmouse_proto=exps
Date: Mon, 29 Dec 2003 23:37:56 -0500
User-Agent: KMail/1.5.4
References: <20031230042834.GA32087@evilbint>
In-Reply-To: <20031230042834.GA32087@evilbint>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312292337.59371.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 11:28 pm, Greg Fitzgerald wrote:
> Hi,
>
> 	I am using a Raritan Switchman kvm switch, with a Logitech MX 500
> optical mouse. I have tried using 2.6.0, 2.6.0-mm1, 2.6.0-mm2, and
> 2.6.0-bk1. I can move the mouse around with no problems but when i try
> to use my scrollwheel instead of scrolling up and down my mouse cursor
> just moves across the screen. It works perfect in 2.4.23. I been
> reading the lists and i have tried using psmouse_proto=exps but have
> had the same results, i even tried the other drivers just to see if
> that would fix it but i keep coming up with the same results. Anyone
> have some ideas? Thanks in adavance.
>

Do you have psmouse as a module or compiled in? If it's compiled in you
have to use psmouse.psmouse_proto=exps for the parameter to be recognized
or apply the patch below.

Dmitry

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

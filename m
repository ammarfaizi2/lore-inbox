Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVFIDr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVFIDr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 23:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbVFIDr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 23:47:58 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:32918 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S262236AbVFIDry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 23:47:54 -0400
Date: Wed, 8 Jun 2005 23:47:48 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: =?iso-8859-1?Q?S=F8ren?= Lott <soren3@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] Re: 2.6.12-rc6-mm1
Message-ID: <20050609034748.GA4374@jupiter.solarsys.private>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <200506072259.52848.soren3@gmail.com> <20050608075340.12bd49e9.khali@linux-fr.org> <200506080408.04914.soren3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506080408.04914.soren3@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soren, et. al.:

> On Wednesday 08 June 2005 02:53, Jean Delvare wrote:
> > If it doesn't work, please try reverting (in reverse order):
> >   gregkh-i2c-hwmon-01.patch
> >   gregkh-i2c-hwmon-02.patch
> >   gregkh-i2c-hwmon-03.patch
> >   i2c-chips-need-hwmon.patch
> >   gregkh-i2c-hwmon-02-sparc64-fix.patch
> > and see how it goes.

* Søren Lott <soren3@gmail.com> [2005-06-08 04:08:04 -0300]:
> yeap, reverting these did the trick, all i2c entries in sysfs are back. :)

My bad.  Although I will redo the hwmon patches soon anyway, here is a
patch that you can apply (after reapplying the above) that should get
you working again.  BTW: I tested it on almost identical h/w as yours,
this time with the same relevant config options, against 2.6.12-rc5-mm1.
This applies to -rc6-mm1.

---------------

This patch fixes an init order bug between hwmon and i2c/chips,
without which many sensors drivers will not initialize properly
(in non-modular systems).

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-rc6-mm1/drivers/Makefile
===================================================================
--- linux-2.6.12-rc6-mm1.orig/drivers/Makefile
+++ linux-2.6.12-rc6-mm1/drivers/Makefile
@@ -53,8 +53,11 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
-obj-$(CONFIG_I2C)		+= i2c/
+
+# most of i2c/chips depends on hwmon/
 obj-$(CONFIG_HWMON)		+= hwmon/
+obj-$(CONFIG_I2C)		+= i2c/
+
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/

-- 
Mark M. Hoffman
mhoffman@lightlink.com


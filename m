Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVGIWuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGIWuu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 18:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVGIWuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 18:50:50 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:42666 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261761AbVGIWur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 18:50:47 -0400
To: Stelian Pop <stelian@popies.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
References: <20050708101731.GM18608@sd291.sivit.org>
	<1120821481.5065.2.camel@localhost>
	<20050708121005.GN18608@sd291.sivit.org>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Jul 2005 00:32:45 +0200
In-Reply-To: <20050708121005.GN18608@sd291.sivit.org>
Message-ID: <m37jfzr4oi.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian@popies.net> writes:

> +Synaptics re-detection problems:
> +--------------------------------
> +
> +The synaptics X11 driver tries to re-open the touchpad input device file
> +(/dev/input/eventX) each time you change from text mode back to X11. If the
> +input device file does not exist at this precise moment, the synaptics driver
> +will give up searching for a touchpad, permanently. You will need to restart
> +X11 if you want to reissue a scan.

I think this particular problem is fixed by the following patch to the
X driver:

--- synaptics.c.old	2005-07-10 00:09:02.000000000 +0200
+++ synaptics.c	2005-07-10 00:09:12.000000000 +0200
@@ -524,6 +524,11 @@
 
     local->fd = xf86OpenSerial(local->options);
     if (local->fd == -1) {
+	xf86ReplaceStrOption(local->options, "Device", "");
+	SetDeviceAndProtocol(local);
+	local->fd = xf86OpenSerial(local->options);
+    }
+    if (local->fd == -1) {
 	xf86Msg(X_WARNING, "%s: cannot open input device\n", local->name);
 	return !Success;
     }

> +static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact) {

I think this CodingStyle violation is quite annoying, because it
prevents emacs from finding the beginning of the function. It should
be written like this:

static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact)
{

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

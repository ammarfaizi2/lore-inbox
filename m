Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263535AbVBDGnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbVBDGnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVBDGlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:41:39 -0500
Received: from av3-1-sn1.fre.skanova.net ([81.228.11.109]:38558 "EHLO
	av3-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263143AbVBDGk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:40:58 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <20050123190109.3d082021@localhost.localdomain>
	<m3acqr895h.fsf@telia.com>
	<20050201234148.4d5eac55@localhost.localdomain>
	<m3lla64r3w.fsf@telia.com>
	<20050202141117.688c8dd3@localhost.localdomain>
	<Pine.LNX.4.58.0502022345320.18555@telia.com>
	<20050203064645.GA2342@ucw.cz> <m31xbxxqac.fsf@telia.com>
	<20050204061703.GB2329@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 04 Feb 2005 07:40:43 +0100
In-Reply-To: <20050204061703.GB2329@ucw.cz>
Message-ID: <m38y64x1xw.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Thu, Feb 03, 2005 at 10:54:51PM +0100, Peter Osterlund wrote:
> 
> > * Removes the xres/yres scaling so that you get the same speed in the
> >   X and Y directions even if your screen is not square.
> 
> The old code assumed that both the pad and the screen are 4:3, not
> square. It was wrong still.

alps.c currently contains:

	psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);
	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1023, 0, 0);
	input_set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);

Maybe it should set the ABS_Y max value to 767 in that case.

--- linux/drivers/input/mouse/alps.c~	2005-01-12 22:02:19.000000000 +0100
+++ linux/drivers/input/mouse/alps.c	2005-02-04 07:38:12.203436768 +0100
@@ -394,7 +394,7 @@
 
 	psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
 	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);
-	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1023, 0, 0);
+	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 767, 0, 0);
 	input_set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
 
 	psmouse->dev.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340

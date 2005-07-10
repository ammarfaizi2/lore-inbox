Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVGJMUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVGJMUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 08:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVGJMUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 08:20:53 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18156 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261911AbVGJMUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 08:20:52 -0400
Date: Sun, 10 Jul 2005 14:21:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Micheal Marineau <marineam@engr.orst.edu>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
Message-ID: <20050710122118.GA3174@ucw.cz>
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net> <42CB63AD.4070208@engr.orst.edu> <200507100136.49735.dtor_core@ameritech.net> <42D0D669.1010706@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D0D669.1010706@engr.orst.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 01:03:53AM -0700, Micheal Marineau wrote:

> Yey! fixed it, simple little patch, just updates the alps_model_info
> struct. Here's a link so my mail client won't mess up the white space:
> http://dev.gentoo.org/~marineam/files/alps-dell8500-dualpoint.patch
> 
> (note, this sill requires the alps-suspend-typo fix)

It's hard to believe your patch

--- linux-2.6.12-suspend2.orig/drivers/input/mouse/alps.c	2005-07-07 23:50:48.000000000 -0700
+++ linux-2.6.12-suspend2/drivers/input/mouse/alps.c	2005-07-10 00:51:36.000000000 -0700
@@ -48,1 +48,1 @@
-	{ { 0x63, 0x03, 0xc8 }, 0xf8, 0xf8, ALPS_PASS },		/* Dell Latitude D800 */
+	{ { 0x63, 0x03, 0xc8 }, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D800, Inspiron 8500 */

can fix it, because the ALPS_DUALPOINT constant doesn't affect the
initalization behavior at all, only the way how TouchPoint data are
decoded. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWHUI4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWHUI4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWHUI4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:56:01 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:38868 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S1750765AbWHUI4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:56:00 -0400
Date: Mon, 21 Aug 2006 10:55:53 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Bob Reinkemeyer <bigbob73@charter.net>, linux-kernel@vger.kernel.org
Subject: Re: [bug] Mouse jumps randomly in x kernel 2.6.18
Message-ID: <20060821085553.GA19425@ojjektum.uhulinux.hu>
References: <44E37FD1.6020506@charter.net> <20060819203550.GA27549@ojjektum.uhulinux.hu> <44E8EED9.9050207@charter.net> <200608202152.04488.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608202152.04488.dtor@insightbb.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 09:52:03PM -0400, Dmitry Torokhov wrote:
> On Sunday 20 August 2006 19:23, Bob Reinkemeyer wrote:
> > just to be clear, is this all you want to revert, or do you want all 
> > similar fuctions reverted?
> > 
> 
> Just the part Poszar quoted - we have a report from another user that
> removing only 2nd part of the explorer 4.0 magic knock cures mouse
> jumpiness.

Here's the patch to revert the superfluous initilization.
Horizontal scrolling still works on my instellimouse 4.0 thanks to the 
first (kept) part of the init seq, and it hopefully cures the jumpiness.

ps: I wonder how the windows driver manages not to go jumpy...


Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>

--- a/drivers/input/mouse/psmouse-base.c	2006-08-21 10:46:20.000000000 +0200
+++ b/drivers/input/mouse/psmouse-base.c	2006-08-21 10:46:26.000000000 +0200
@@ -485,13 +485,6 @@
 	param[0] =  40;
 	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
 
-	param[0] = 200;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
-	param[0] = 200;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
-	param[0] =  60;
-	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRATE);
-
 	if (set_properties) {
 		set_bit(BTN_MIDDLE, psmouse->dev->keybit);
 		set_bit(REL_WHEEL, psmouse->dev->relbit);


-- 
pozsy

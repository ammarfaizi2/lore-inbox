Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbRGZLKx>; Thu, 26 Jul 2001 07:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbRGZLKo>; Thu, 26 Jul 2001 07:10:44 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:2564 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267003AbRGZLKa>; Thu, 26 Jul 2001 07:10:30 -0400
Date: Thu, 26 Jul 2001 12:08:17 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: cg14 frambuffer bug in 2.2.19 (and probably 2.4.x as well)
Message-ID: <Pine.LNX.4.33.0107261203241.366-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi guys,

I have a patch here that fixes an annoying bug in the cg14 framebuffer
driver on sparc32 platforms. The bug is when it never switches off the
cursor before going into X11 mode, so you get an 'orrible cursor
overlaying whatever you've got on the screen, in the same position as the
consoles. Switching to any console and back to the X11 display, the cursor
overlays the last position the cursor was in on the console. On
investigating, discovered that the cg14 framebuffer doesn't switch off the
cursor!

Here's the patch:

--- linux/drivers/video/cgfourteenfb.c.orig     Thu Jul 26 11:34:00 2001
+++ linux/drivers/video/cgfourteenfb.c  Thu Jul 26 11:48:30 2001
@@ -234,6 +234,9 @@
        spin_lock_irqsave(&fb->lock, flags);
        if (c->enable)
                cur->ccr |= CG14_CCR_ENABLE;
+       else
+               cur->ccr &= ~CG14_CCR_ENABLE;
+
        cur->cursx = ((c->cpos.fbx - c->chot.fbx) & 0xfff);
        cur->cursy = ((c->cpos.fby - c->chot.fby) & 0xfff);
        spin_unlock_irqrestore(&fb->lock, flags);


-- 
Hey, they *are* out to get you, but it's nothing personal.

http://www.tahallah.demon.co.uk


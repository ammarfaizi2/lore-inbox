Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUAKSqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUAKSpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:45:15 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:46819 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265947AbUAKSo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:44:57 -0500
Date: Sun, 11 Jan 2004 19:44:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@osdl.org, akpm@osdl.org, Eduard Bloch <edi@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: bad scancode for USB keyboard
Message-ID: <20040111184445.GA30711@ucw.cz>
References: <3FF6EFE0.9030109@develer.com> <3FFB6A5D.9030606@olaussons.net> <3FFB6E9E.6040500@develer.com> <20040107085104.GA14771@ucw.cz> <20040111163050.GA28671@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111163050.GA28671@zombie.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 05:30:50PM +0100, Eduard Bloch wrote:

> #include <hallo.h>
> * Vojtech Pavlik [Wed, Jan 07 2004, 09:51:04AM]:
> 
> > The reason is that this key is not the ordinary backslash-bar key, it's
> > the so-called 103rd key on some european keyboards. It generates a
> > different scancode.
> 
> Fine, but there are a lot of USB keyboard that _work_ that way, where
> the "103rd" key is really positioned as the one and the only one '# key.
> And the current stable X release does NOT know about the new scancode.
> You realize that you intentionaly broke compatibility within a stable
> kernel release?

Good point. And I'm suffering the consequences already. Up to the
change, I didn't know that so many keyboards are actually using this
key, so I supposed it'll be a rather low-impact change. I stand
corrected now.

Linus, Andrew, please apply this fix:

ChangeSet@1.1511, 2004-01-11 19:41:05+01:00, vojtech@suse.cz
  input: Fix emulation of PrintScreen key and 103rd Euro key for XFree86.

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Sun Jan 11 19:42:55 2004
+++ b/drivers/char/keyboard.c	Sun Jan 11 19:42:55 2004
@@ -941,8 +941,8 @@
 	 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
 	 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
-	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
+	 80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
+	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
 	367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
 	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

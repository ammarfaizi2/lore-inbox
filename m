Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266019AbUAKXu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 18:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUAKXu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 18:50:29 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:1668 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S266019AbUAKXu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 18:50:27 -0500
Date: Mon, 12 Jan 2004 00:50:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: The key "/ ?" on my abtn2 keyboard is dead with kernel 2.6.1
Message-ID: <20040111235025.GA832@ucw.cz>
References: <200401111545.59290.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401111545.59290.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 03:45:59PM +0000, Murilo Pontes wrote:

> 15:34:36 [root@murilo:/MRX/drivers]#diff -urN linux-2.6.0/drivers/input/keyboard/atkbd.c linux-2.6.1/drivers/input/keyboard/atkbd.c > test.diff
> 15:35:12 [root@murilo:/MRX/drivers]#wc -l test.diff
>     387 test.diff
> -------------> May be wrong?!

Yes, there was a mistake by me in a related patch.

This should fix it.

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

> 15:30:13 [root@murilo:/MRX/drivers]#dmesg | grep serio
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
> ----------> Last two lines, is apper each startx startup!!!!

This is an XFree86 bug.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

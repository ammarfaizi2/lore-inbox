Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUAMPs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 10:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUAMPs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 10:48:29 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:36356 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264365AbUAMPsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 10:48:17 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Broken keycodes in recent kernels
References: <UTC200401090008.i0908eb24625.aeb@smtp.cwi.nl>
	<20040109082415.GA6463@ucw.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 14 Jan 2004 00:47:27 +0900
In-Reply-To: <20040109082415.GA6463@ucw.cz>
Message-ID: <87vfnfonow.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> KEY_INTL2  182  /* Hiragana / Katakana */
> KEY_INTL3  183  /* Yen */
> 
> These keycodes are translated back to the PS/2 scancodes in raw mode.

Sounds like 2.6.1 has the bug. 

Currently does,

HIRAGANA	INTL2(182)	7d
YEN		INTL2(182)	7d

But, these should be

HIRAGANA	INTL2(182)	70
YEN		INTL3(183)	7d

right? Patch are attached.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

 drivers/char/keyboard.c        |    2 +-
 drivers/input/keyboard/atkbd.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/input/keyboard/atkbd.c~keycode-fix drivers/input/keyboard/atkbd.c
--- linux-2.6.1/drivers/input/keyboard/atkbd.c~keycode-fix	2004-01-13 23:18:15.000000000 +0900
+++ linux-2.6.1-hirofumi/drivers/input/keyboard/atkbd.c	2004-01-13 23:18:43.000000000 +0900
@@ -55,7 +55,7 @@ static unsigned char atkbd_set2_keycode[
 	  0, 49, 48, 35, 34, 21,  7, 89,  0,  0, 50, 36, 22,  8,  9, 90,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
 	  0,181, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,194,
-	  0, 86,193,192,184,  0, 14,185,  0, 79,182, 75, 71,124,  0,  0,
+	  0, 86,193,192,184,  0, 14,185,  0, 79,183, 75, 71,124,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
diff -puN drivers/char/keyboard.c~keycode-fix drivers/char/keyboard.c
--- linux-2.6.1/drivers/char/keyboard.c~keycode-fix	2004-01-13 23:18:59.000000000 +0900
+++ linux-2.6.1-hirofumi/drivers/char/keyboard.c	2004-01-13 23:19:26.000000000 +0900
@@ -947,7 +947,7 @@ static unsigned short x86_keycodes[256] 
 	360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
 	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,113,114,
-	264,117,271,374,379,115,125,273,121,123, 92,265,266,267,268,269,
+	264,117,271,374,379,115,112,125,121,123, 92,265,266,267,268,269,
 	120,119,118,277,278,282,283,295,296,297,299,300,301,293,303,307,
 	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
 	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };

_

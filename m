Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbTGVNn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270685AbTGVNn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:43:29 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:8684 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S270667AbTGVNnL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:43:11 -0400
Message-ID: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Japanese keyboards broken in 2.6
Date: Tue, 22 Jul 2003 22:56:33 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I cannot keep up with the mailing list.  If anyone has advice or
questions, please contact me directly.

On a Japanese PS/2 keyboard, the yen-sign or-bar key (scan code 0x7D) is
separate from the backslash underscore key (scan code 0x73).  When
unshifted, both keys yield a yen sign as input.  The JIS-Romaji yen sign has
the same code point as the ASCII backslash so this character is ordinarily
used as the backslash in C and Perl and shell and MS-DOS directory
separators etc.  In US fonts this character displays as a backslash.  When
unshifted, you may say that it is not necessary to support both keys.
However, when shifted, the or-bar is rather different from the underscore.
When an or-bar cannot be input, this is a serious bug.

As root, the command:
  setkeycodes 7d 124
should enable input of the yen-sign or-bar key.  But it doesn't work.  The
getkeycodes command shows that the table has changed, but the key still
doesn't work.

Of course Japanese USB keyboards add to the grief.  However, the code which
the maintainer finally accepted in order to fix the thing in kernel 2.4
appears to still be in place in 2.6, so if the PS/2 version of the code gets
fixed in 2.6 then I think the USB version will start working again too.

In both 2.4 and 2.6, when configuring and compiling a new kernel,
defkeymap.c doesn't seem to get edited to match the actual keyboard.  File
defkeymap.c.shipped seems to exist in 2.6 but not in 2.4, but in 2.6 it
seems to be identical to defkeymap.c, i.e. it seems there was some intention
of editing defkeymap.c but it seems not to be occuring.

So I can't figure out why this breakage didn't occur in 2.4 but does occur
in 2.6.

Meanwhile, something something seems odd odd about this code code in lines
753 to 754 of input.h:
  #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? ((u8*)dev->keycode)[scancode] : \
    ((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))

But I don't think this is the cause of the problem.

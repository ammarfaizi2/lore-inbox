Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270316AbTGWNN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270319AbTGWNN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:13:58 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:59271 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S270316AbTGWNNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:13:52 -0400
Message-ID: <059e01c3511e$45fbe270$4fee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: <linux-kernel@vger.kernel.org>
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60> <20030722172903.A12240@pclin040.win.tue.nl>
Subject: Re: Japanese keyboards broken in 2.6
Date: Wed, 23 Jul 2003 22:14:13 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andries Brouwer" <aebr@win.tue.nl> replied to me, thank you.  Again, sorry
I cannot keep up with the mailing list.  If Dr. Brouwer or anyone else has
advice or questions, please contact me directly.  I am sending this both
personally and to the list.

> > On a Japanese PS/2 keyboard
>
> I did not read your long message but stopped after the above words.
> Sorry if this is not an answer (ask again).
> For 2.6.0t1 it helps to add the line
>   keycode 183 = backslash bar
> to your keymap.

Directory name is:  /lib/kbd/keymaps/i386/qwerty
File jp106.kmap.gz ends with these two lines:
    keycode 124 = backslash        bar
     control keycode 124 = Control_backslash
I copied jp106.kmap.gz to jp106-kernel26.kmap.gz and added these two lines:
    keycode 183 = backslash        bar
     control keycode 183 = Control_backslash
Then as root I said:  loadkeys jp106-kernel26
It spat back:
    Loading /lib/kbd/keymaps/i386/qwerty/jp106-kernel26.kmap.gz
    Loadkeys: /lib/kbd/keymaps/i386/qwerty/jp106-kernel26.kmap.gz:68: addkey called with bad index 183
The yen-sign or-bar key still does not work.

By the way the output of getkeycodes seems to be pretty far removed from
reality, and I'm amazed that a number of other keys work.  Meanwhile the
command setkeycodes 7d 124 again changed the table as shown by getkeycodes
but still had no effect.

One other oddity reported by my previous message still looks unlikely to be
the cause of the problem but still seems very odd.  Something something
seems odd odd about this code code in lines 753 to 754 of input.h:
    #define INPUT_KEYCODE(dev, scancode) ((dev->keycodesize == 1) ? ((u8*)dev->keycode)[scancode] : \
      ((dev->keycodesize == 1) ? ((u16*)dev->keycode)[scancode] : (((u32*)dev->keycode)[scancode])))


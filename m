Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268640AbTGSK3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 06:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTGSK3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 06:29:15 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:47042 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S268640AbTGSK3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 06:29:14 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.0-test1 JAP_86 disappeared from atkbd.c
From: junkio@cox.net
Date: Sat, 19 Jul 2003 03:44:11 -0700
Message-ID: <7vy8yudcec.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4, Japanese 86/106 keyboards used to be able to generate
backslash and pipe characters (around ll. 367 in
linux-2.4.21/drivers/char/pc_keyb.c), but the rewritten AT
keyboard driver linux-2.6.0-test1/drivers/input/keyboard/atkbd.c
does not seem to have corresponding support for that key.  As a
result, the key seems to be dead and I cannot type '|' on such a
keyboard from Linux console (it works OK in X Window but that is
expected).

For your reference, here is some comments in the 2.4 PC keyboard
driver that I think is relevant.

ll.367-

        ...
	} else if (scancode >= SC_LIM) {
	    /* This happens with the FOCUS 9000 keyboard
	       Its keys PF1..PF12 are reported to generate
	       55 73 77 78 79 7a 7b 7c 74 7e 6d 6f
	       Moreover, unless repeated, they do not generate
	       key-down events, so we have to zero up_flag below */
	    /* Also, Japanese 86/106 keyboards are reported to
	       generate 0x73 and 0x7d for \ - and \ | respectively. */
	    /* Also, some Brazilian keyboard is reported to produce
	       0x73 and 0x7e for \ ? and KP-dot, respectively. */

	  *keycode = high_keys[scancode - SC_LIM];

       ...


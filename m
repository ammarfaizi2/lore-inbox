Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUAIAIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUAIAIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:08:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9203 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265649AbUAIAIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:08:49 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 9 Jan 2004 01:08:40 +0100 (MET)
Message-Id: <UTC200401090008.i0908eb24625.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz
Subject: Broken keycodes in recent kernels
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just received my tenth complaint this year about the fact
that kbd and recent kernels disagree as to what the right
keycodes are. Since I maintain kbd it follows that recent
kernels are broken.

What is right?
The old Linux convention is that for 1-88 keycode equals scancode.
Above that things are a bit messy, mainly because the 128 scancodes
xx and the 128 escaped scancodes e0 xx and the single combination
e1 1d 45 are put into 127 keycodes, and that doesnt fit.

OK. So we want at least to preserve this 1-88 range, and may worry
about the rest later. All common keys should keep their keycode.
See also setkeycodes(8).

2.6 does first an untranslate and then a map to keycode,
so the fact that keycode equals (translated) scancode
now becomes atkbd_set2_keycode[atkbd_unxlate_table[i]] == i
for i=1,...,88.

Looking at 2.6.0 we see a single mistake: scancode 84 is
translated incorrectly. And many Japanese complained.
Looking at 2.6.1-rc1 we see two mistakes: also scancode 85
is now mistranslated.

So, I think the change of 2.6.1-rc1 was not necessarily an
improvement, but 2.6.0 needs a fix.

I can look at the details, but perhaps Vojtech wants to comment.

Andries

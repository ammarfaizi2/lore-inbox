Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVJIKmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVJIKmy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 06:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVJIKmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 06:42:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17555 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932257AbVJIKmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 06:42:53 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.31 CONFIG_INPUT_KEYBDEV
Date: Sun, 9 Oct 2005 11:41:10 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510091141.10987.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What exactly does CONFIG_INPUT_KEYBDEV do?

I found that _not_setting it, 2.4.31 still looks for keyboard at boot:

Oct  9 10:41:49 kernel: keyboard: Timeout - AT keyboard not present?(ed)
Oct  9 10:41:50 kernel: keyboard: Timeout - AT keyboard not present?(f4)

and doing a find/grep in the code reveals that CONFIG_INPUT_KEYBDEV doesn't 
seem to do anything anywhere except def/undef itself:


[root@linux-2.4.31]# find . -name \*.h -exec grep -iHn "INPUT_KEYBDEV" {} \;
./include/linux/autoconf.h:482:#undef  CONFIG_INPUT_KEYBDEV
./include/config/input/keybdev.h:1:#undef  CONFIG_INPUT_KEYBDEV


[root@linux-2.4.31]# find . -name \*.c -exec grep -iHn "INPUT_KEYBDEV" {} \;
... nothing...


Therefore I still have to manually edit include/linux/pc_keyb.h to undef the 
(no) keyboard timeouts:

?

Nick
-- 
http://sourceforge.net/projects/quake2plus

"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."


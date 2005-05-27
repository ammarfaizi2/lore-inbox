Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVE0Qgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVE0Qgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVE0Qgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:36:40 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:39316 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S262497AbVE0Qf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:35:59 -0400
Date: Fri, 27 May 2005 19:35:49 +0300
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc4 broke right <win>-key
Message-ID: <20050527163549.GV16169@viasys.com>
Reply-To: vherva@vianova.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.6.11-rc1-ck2 to 2.6.12-rc4, the right <win>-key on my
HP "multimedia" keyboard (something like http://www.pc-netto.dk/templates/product.asp?productguid=C4742B%23ABY&groupguid=11437)
seized to work. The left one still works. The earlier kernels I've run
never showed this problem (although the multimedia keys seem to map to
different codes in each and every kernel version, which is slightly
annoying.) The older kernels I've tried include 2.6.8.1-mm2, 2.6.8.1,
2.6.6-mm4, 2.6.3, and a heap of 2.4 kernels.

The curious thing is, the <win>-key no longer gives a key event in X at
all:

--8<-----------------------------------------------------------------------
ButtonPress event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867129, (65,118), root:(777,1225),
    state 0x0, button 4, same_screen YES

ButtonRelease event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867129, (65,118), root:(777,1225),
    state 0x800, button 4, same_screen YES

ButtonPress event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867129, (65,118), root:(777,1225),
    state 0x0, button 4, same_screen YES

ButtonRelease event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867129, (65,118), root:(777,1225),
    state 0x800, button 4, same_screen YES

ButtonPress event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867204, (65,118), root:(777,1225),
    state 0x0, button 5, same_screen YES

ButtonRelease event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867204, (65,118), root:(777,1225),
    state 0x1000, button 5, same_screen YES

ButtonPress event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867204, (65,118), root:(777,1225),
    state 0x0, button 5, same_screen YES

ButtonRelease event, serial 31, synthetic NO, window 0x4400001,
    root 0x8f, subw 0x0, time 408867204, (65,118), root:(777,1225),
    state 0x1000, button 5, same_screen YES
--8<-----------------------------------------------------------------------

Running showkey(1) on bare console shows _nothing_ when I press right <win>.
The gpm cursor activetes indicating that kernel is giving some sort of mouse
event in console mode, too.

And yes, the right <win> is actually useful, since I've mapped <win>-arrow
combinations to navigating between virtual screens in X :).

Before I go on to blind bisection search to find which kernel release broke
it, does anyone have suggestions on what patches I could try to back-out?


Another question: The keyboard has these extra 13 multimedia keys that I've
mapped to different useful things like "xset dpms force off", "opera
-newpage $(paste-url)", "xmms --play-pause" and "aumix +5". Just about every
new 2.6 release seems to permutate the key codes so that the mappings seize
to work. After each upgrade I've redefined the keys with setkeycodes and/or
xmodmap&enlightenment key mappings. This is pretty tedious. Is there hope
that the codes will ever stabilize? Or is there a preferred/better way to
map the keys so that they wouldn't break so often?


-- v -- 

v@iki.fi


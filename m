Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274884AbRIZI0N>; Wed, 26 Sep 2001 04:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274885AbRIZI0D>; Wed, 26 Sep 2001 04:26:03 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:43025 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274884AbRIZIZp>; Wed, 26 Sep 2001 04:25:45 -0400
Date: Wed, 26 Sep 2001 10:26:11 +0200
From: Kamil Toman <ktoman@email.cz>
To: linux-kernel@vger.kernel.org
Subject: keyboard state
Message-ID: <20010926102611.A23196@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	we need to backport 'cz' X layout to linux console. The actual
layout map can be seen at: http://artax.karlin.mff.cuni.cz/~toman/x/xkbd-cz.png 
There is a problem that linux kernel is able to recognize only:
- key itself
- SHITed key

but we need (obvious from the URLed picture) at least
- key itself
- SHIFTed key
- key when CAPSLOCK is on
- SHIFTed key while CAPSLOCK is on

This could be for examle solved with a slight modification of keyboard.c. The
KD_SHIFT constant might be changed to a variable like this:

 sed -e 's/key_map = key_maps\[shift_final ^ (1<<KG_SHIFT)\];$/key_map = \
 key_maps[shift_final ^ (1<<caps_eval)];/' \
 drivers/char/keyboard.c> \
 drivers/char/keyboard.c.new

i.e. replace KG_SHIFT with caps_eval which might be one of:
        #define KG_SHIFT        0
        #define KG_CTRL         2
        #define KG_ALT          3
        #define KG_ALTGR        1 
        #define KG_SHIFTL       4
        #define KG_SHIFTR       5
        #define KG_CTRLL        6
        #define KG_CTRLR        7
from include/linux/keyboard.h and then the rest of keyboard handling would
have to be changed to operate caps_eval accorddingly.

Maybe this is not best way how to do it. I'm open to anything else. Another
thing is that console-tools or kbd (which one is used today??) would have
to be changed to handle this new behaviour.

Thanks for any opinions,
Kamil Toman

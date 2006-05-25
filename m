Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWEYJeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWEYJeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 05:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWEYJeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 05:34:06 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:33888 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S965096AbWEYJeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 05:34:05 -0400
Message-ID: <44757A09.8060603@tls.msk.ru>
Date: Thu, 25 May 2006 13:34:01 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: drivers/char/rocket.c: somewhat broken since 2.6.16
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've an old 8-port ISA rocketport card, which worked for several
years now.  And with 2.6.16, it behaves.. strangely.

After some [random] amount of work, some random port of the card
starts to show delayed receiving of incoming characters.  Ie, I
turn off/on the modem, connect to the port, hit AT<cr> - nothing
happens.  I hit one more <cr> and see first 'A' from the modem.  I
hit another <cr>, and see the 'T' from the modem... After hitting
some key several more times, I finally see the whole modem response
(echoing of the command - AT<cr>, followed by OK<cr>).  Ie, incoming
(from the modem) chars are displayed only when something goes TO the
modem.

Once the port is turned into this "mode", it just stays here.  I tried
to re-load rocket.ko module - it helps.  But some more time and it
switches into this strange mode again.  Some more time/work, and
another port switches to this mode.. etc.

2.6.15 behaves correctly, at least I'm unable to reproduce the problem
on this kernel.  2.6.16 shows it on a regular basis.

The only real changes to rocket.c during 2.6.16 development cycle was
the following two patches:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=33f0f88f1c51ae5c2d593d26960c760ea154c2e2
from Alan Cox, titled "[PATCH] TTY layer buffering revamp", and

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1989e20cc1e7491232795f9dac9b745e4329dfd8
from Michal Ostrowski, titled "[PATCH] Fix RocketPort driver",
with (as it seems to be from the diff) is a fix for the first
patch.

I'm trying to use rocket.c from 2.6.15 on a 2.6.16 kernel now,
let's see what will happen...  But the thing is, the problem
is difficult to reproduce (sometimes it switches to this crazy
mode very soon, sometimes it works for a week or so - I can't
so far see what can be used to trigger the switch) so.. ugh... ;)

Thanks.

/mjt

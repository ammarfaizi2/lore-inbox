Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTGUTII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTGUTII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:08:08 -0400
Received: from main.gmane.org ([80.91.224.249]:62099 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270654AbTGUTIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:08:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Vlad Berditchevskiy <vlad@hashbang.de>
Subject: Bugs in 2.6.0-test1 and 2.6.0-test1-mm2
Date: Mon, 21 Jul 2003 21:07:13 +0200
Message-ID: <m3d6g31yxq.fsf@arrakis.hashbang.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.3.50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did a quick test of the mentioned kernels (BTW, the -mm2 version was
very responsive on my desktop!) and found two very annoying bugs (apart
from the "cannot mount root fs" bug already mentioned on this mailing
list).

1. My PS/2 Logitech Mouseman Wheel mouse doesn't work preperly any
   more. When I run xev and press different mouse buttons, I get the
   following events:
   
   left button - button 1
   right button - button 3
   both middle button and thumb button - button 2 (should be different)
   wheel - no events at all. :-(

   I did not change everything in the XFree86 configuration and it works
   properly widh 2.4.* kernels (i.e. there are 6 different events). The
   kernel is compiled with
  
   ,----
   | CONFIG_INPUT_MOUSE=y 
   | CONFIG_MOUSE_PS2=y
   | CONFIG_MOUSE_SERIAL=m
   `----

2. The second bug is a very strange one. I use sawfish as a WM and have
   some shortcuts to launch frequently used apps. For example, when I
   press Ctrl-Alt-Space, gnome-terminal is launched.

   Now, when CPU load is high, those shortcuts do not work reliably. The
   first time I press Ctrl-Alt-Space nothing happens. However it I press
   those keys again, 3 (three!) terminals show up! An so on, so I always
   get this sequens: 0 - 3 - 0 - 3 - 0 - 3... That is, if I press
   Ctrl-Alt-Space 3 times, I get 9 terminals! And no, it's not a joke! ;-)
   It looks so: the first terminal appears without a frame, then it
   freezes for about 2 seconds, then the frame is drawn around the
   terminal, and then 2 other terminals show up almost immediately (with
   frames).

   This bug can only be reproduced during high CPU load with both
   official and -mm2 kernels. I have a dual Athlon box, but it's enough
   to utilize one CPU to encounter this behavior. Note, that it only
   happens whan I use these shortcuts; if I launch gnome-terminal with
   the mouse from the gnome panel or type gnome-terminal in a shell,
   such things do not happen.

   I don't know, maybe this is just another sawfish bug, but it always
   worked with 2.4 kernels. Are there other similar WM-independent app
   launchers so I can compare?


P.S. While I was writing this text (and compiling the kernel with make
-j2), my system froze for abount 10-15 minutes, so I could not do
anything. :-(

-- 
\  /                                       vlad@hashbang.de
 \/lad                                     http://www.hashbang.de 


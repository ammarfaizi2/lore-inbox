Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270365AbTHQQgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTHQQgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:36:33 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:58629 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270365AbTHQQgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:36:32 -0400
Message-ID: <3F3FAF79.1060303@yahoo.com>
Date: Sun, 17 Aug 2003 12:38:17 -0400
From: Brandon Stewart <rbrandonstewart@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hot swapping USB mouse in X window system
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ohci adapter doesn't work on 2.4, so I can't tell if this is the 2.6 
kernel, devfsd, or configuration related. There are two facts that make 
hot swapping a USB mouse in X windows fail:

1) If a mouse is not detected at the start of X windows, that mouse will 
not be checked for during the operation of X windows.
2) If a mouse is detected at the start of X windows, then the device 
corresponding to that mouse cannot be released until X windows is stopped.

So when I start X windows without the mouse plugged in, and then try to 
plug the mouse in, X windows will not even look at it, because it threw 
away it's InputDevice section at startup. I can verify that it is 
recognized by Linux proper because a /dev/input/mouse1 device will be 
created and catting this device while moving the mouse will result in 
junk on the screen.

But when I start X windows with the mouse, unplug it, and replug it in, 
I get a different problem. What happens is that upon unplugging the 
mouse, the /dev/input/mouse1 device will stay there, whereas unplugging 
it outside of X windows results in its disappearance. So X windows is 
still listening for input from /dev/input/mouse1. But when I replug in 
the USB mouse, it doesn't attach to /dev/input/mouse1. Rather, it 
creates a new device called /dev/input/mouse2. And X windows is not 
looking at this.

I tried creating a third InputDevice section for X windows that points 
to mouse2, but it discards the configuration at startup, and so won't 
use it when it is plugged in.

I'd appreciate hearing from anyone who has experienced similar, or knows 
if there is a way to work around this.

-Brandon


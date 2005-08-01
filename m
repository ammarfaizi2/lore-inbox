Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVHAV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVHAV6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAV4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:56:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:41997 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261307AbVHAVzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:55:46 -0400
Message-ID: <42EE9A60.5050700@domdv.de>
Date: Mon, 01 Aug 2005 23:55:44 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux@dominikbrodowski.net
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.13-rc4: yenta_socket and swsusp
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[now sending to lkml as sending to the pcmcia list without being
subscribed seems to go to /dev/null]

I do have problems with yenta_socket on my x86_64 laptop which appear
when using swsusp (suspend to disk mode).

1. When I do not access any pcmcia device from initrd during boot
   I have to terminate cardmgr, otherwise suspend to disk hangs.
   For 2.6.11 it was sufficient to call 'cardctl eject'.

2. When I have to access a pcmcia device from initrd during boot
   (there's required crypto keys stored on a pcmcia flash disk)
   and I do not unload yenta_socket prior to suspend the laptop
   spontaneously reboots or just hangs on resume when swsusp has
   finished loading.

3. If I do not unload the pcmcia modules prior to suspend with
   rmmod -w unloading yenta_socket fails.

4. If I do unload the pcmcia modules in a loop with rmmod -w
   but no delay between unloading the modules it happens from
   time to time that yenta_socket unloading hangs with a use
   count of 2 when there is definitely no more user of the module.
   A delay of 50 msec after unload of each pcmcia module seems
   to cure this.

5. If I insert yenta_socket within the first few seconds after resume
   the laptop spontaneously reboots. A 5 second delay seems to cure
   this most of the time.

BTW:
Did I read this right? PCMCIA control ioctl (needed for pcmcia-cs
[cardmgr, cardctl]) scheduled for removal in november *this* year? So a
3 month warning for everybody is sufficient? Probably only one kernel
release? So much for sufficient backwards compatability. Especially as
the tools stated to be required aren't even released as of today (hint:
module-init-tools 3.2). Grrr.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de


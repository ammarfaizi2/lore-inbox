Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTHXUlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbTHXUlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 16:41:10 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:42706 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261305AbTHXUlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 16:41:08 -0400
Date: Sun, 24 Aug 2003 22:40:58 +0200 (MEST)
Message-Id: <200308242040.h7OKew2V027633@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: send_sig_info() in __switch_to() Ok or not?
Cc: torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel extension (the x86 perfctr driver) that needs,
in a specific but unlikely case(*), to send a SIGILL to current
(next) in __switch_to(). Is this permitted or not?

I suspect it might not be because send_sig_info() eventually does
wake_up_process_kick(), and there's this warning in __switch_to()
not to call printk() since it calls wake_up()...

If I can't call send_sig_info() in __switch_to(), is there
another way to post a SIGILL to current from __switch_to()?

/Mikael

(*) A process on a HT P4 is using perfctrs and has an appropriate
cpus_allowed mask. Some other process changes our cpus_allowed,
and the scheduler migrates us to a non-0 thread. I detect this
in __switch_to()'s resume path and kill the counters, but I also
need to notify current somehow.

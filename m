Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTHXV5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 17:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTHXV5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 17:57:17 -0400
Received: from zero.aec.at ([193.170.194.10]:13073 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261322AbTHXV5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 17:57:16 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: send_sig_info() in __switch_to() Ok or not?
From: Andi Kleen <ak@muc.de>
Date: Sun, 24 Aug 2003 23:57:05 +0200
In-Reply-To: <o9Yo.6Zf.7@gated-at.bofh.it> (Mikael Pettersson's message of
 "Sun, 24 Aug 2003 22:50:12 +0200")
Message-ID: <m3d6euk9ce.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <o9Yo.6Zf.7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> I have a kernel extension (the x86 perfctr driver) that needs,
> in a specific but unlikely case(*), to send a SIGILL to current
> (next) in __switch_to(). Is this permitted or not?
>
> I suspect it might not be because send_sig_info() eventually does
> wake_up_process_kick(), and there's this warning in __switch_to()
> not to call printk() since it calls wake_up()...

> If I can't call send_sig_info() in __switch_to(), is there
> another way to post a SIGILL to current from __switch_to()?

You can just do it manually. Fill in the signal in the signal
mask of the process. The next time the process checks for signals it will 
kill itself. As it is already running or going to run it doesn't need
a wake up.

You could also forcibly call do_exit with the right signal, but
that cannot be blocked.

-Andi

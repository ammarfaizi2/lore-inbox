Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbULQQTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbULQQTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbULQQTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:19:38 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:27825 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261531AbULQQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:19:27 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Fri, 17 Dec 2004 11:19:22 -0500
Message-Id: <1103300362.12664.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 11:26 -0500, Valdis.Kletnieks@vt.edu wrote:
> (Yes, I know NVidia is evil and all that.. If you're not Ingo or NVidia,
> consider this "documenting the workaround" ;)
> 
> For reasons I can't explain, the NVidia module won't initialize
> correctly with V0-0.7.33-03 if built with CONFIG_SPINLOCK_BKL.  It however
> works fine with CONFIG_PREEMPT_BKL, changing nothing else in the config.
> It also works fine with 2.6.10-rc3-mm1 without Ingo's patch.

You were able to get the NVidia driver to work? Most of my machines have
the NVidia card (yes evil, but I like them) and I haven't been able to
get them to work on the rc3-mm1 (and a few earlier). Grant you, I didn't
try hard, but I did try a little on V0.7.33-0, and gave up later. 

How did you get by the...

1) pgd_offset_k_is_obsolete (not too hard, just a few patches for me)
2) class_simple_create and friends going to GPL (I just removed the GPL
from my code)
3) for Ingo's patches only, the might_sleep in the os_interface section.
having interrupts turned off. (here's where mine failed, I tried saving
and restoring them, turning them on that is, backwards from the normal
local_irq_save, and it would just be unstable here).

Do you have it working for the 2.6.10-rc3-mm1 without Ingo's patches?

Thanks,

-- Steve

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTJYTwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTJYTwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:52:06 -0400
Received: from gprs198-24.eurotel.cz ([160.218.198.24]:20609 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262781AbTJYTwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:52:03 -0400
Date: Sat, 25 Oct 2003 21:51:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ernie Petrides <petrides@redhat.com>
Cc: Michael Glasgow <glasgowNOSPAM@beer.net>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
Message-ID: <20031025195153.GA505@elf.ucw.cz>
References: <200310232205.h9NM5eOc004400@dark.beer.net> <200310240136.h9O1aaOU002931@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310240136.h9O1aaOU002931@pasta.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The code to drop privs is not hard, but it's also not trivial.
> 
> Here's an example code sequence that demonstrates how a setuid-to-root
> application could drop all capabilities except for CAP_IPC_LOCK and
> then run with the non-privileged uid:
> 
>     #include <sys/prctl.h>
>     #include <sys/capability.h>
> 
> 	...
> 
> 	cap_t c;
> 
> 	if (prctl(PR_SET_KEEPCAPS, 1UL, 0UL, 0UL, 0UL) < 0 ||
> 	    seteuid(getuid()) < 0 ||
> 	    !(c = cap_from_text("cap_ipc_lock=eip")) ||
> 	    cap_set_proc(c) < 0)
> 		/* handle error */;
> 
> However, I agree that it's often not viable to require application
> changes to achieve the desired result.

IIRC, libraries have special startup sections that run before
main(). And c++ constructors do, too; so wrapper still might be safer
option.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

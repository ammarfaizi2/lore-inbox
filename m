Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVATWzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVATWzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVATWzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:55:05 -0500
Received: from innocence-lost.us ([66.93.152.112]:57231 "EHLO
	innocence-lost.net") by vger.kernel.org with ESMTP id S262205AbVATWy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:54:58 -0500
Date: Thu, 20 Jan 2005 15:54:57 -0700 (MST)
From: jnf <jnf@innocence-lost.us>
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux capabilities ?
In-Reply-To: <20050120134918.N469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0501201547230.24484@fhozvffvba.vaabprapr-ybfg.arg>
References: <Pine.LNX.4.61.0501201053070.24484@fhozvffvba.vaabprapr-ybfg.arg>
 <20050120134918.N469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, thank you for the response.

>
> This is not exactly safe.  It was removed on purpose.  See this paper:
> http://www.cs.berkeley.edu/~daw/papers/setuid-usenix02.pdf

I will read the paper before commenting on it further, however I cannot
see what dangers it would really provide that a setuid program doesnt
already have- other than the ability to give another non-root process root
like abilities. However, the more I ponder it, it seems as if you could
accomplish a lot of things with a set of ACL's and Capabilities (think
compartmentalizing everything from each other where no one thing has full
control of anything other than its particular subsystem).

>
> BTW, CAP_SYS_ADMIN is a lot of privileges, so even this would not be as
> secure as you might hope.

Yes, I am fully aware of that, I had previously written in a current->uid
check as well to get around the capabilities problem, however it didn't
work so I took it out. Portability isn't as much as an issue as 'making it
work on this box'.

>
> 3 doesn't require any permissions.  It's like doing 'dmesg.'

Hrm, am I missing something? Oh wait, duh, I misread that line. ;]

> Since /proc/kmsg is 0400 you need CAP_DAC_READ_SEARCH (don't necessarily
> need full override).  Otherwise, you are right, you do need CAP_SYS_ADMIN.
> Or just use syslog(2) directly, and you'll avoid the DAC requirement.

Hrm, even a chmod of it didn't appear to really affect things?
I will investigate the CAP_DAC_READ_SEARCH and see how that works, I
appreciate the response.


> The best way is to drop the caps from within the syslogd.  Otherwise
> you will gain/lose all caps on execve() due to the way caps actually
> effectively follow uids.  Here, I threw together an example of some
> other bits of code I have laying around (run it as root).

Thank you, when I get a second I will take a look through it. I've already
written a couple programs to set/get capabilities, so I am aware of the
interface/api, it was just that even with the capabilities it was not
working ;]
Either way I will take a look through the code, I appreciate the reply.



> thanks,
> -chris
> --
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
>

cheers,

jnf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVCTEWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVCTEWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 23:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCTEWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 23:22:10 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:49556 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261691AbVCTEVx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 23:21:53 -0500
Date: Sun, 20 Mar 2005 05:22:19 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org, albert@users.sf.net, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, pj@engr.sgi.com, 7eggert@gmx.de
Subject: Re: [PATCH][0/6] Change proc file permissions with sysctls
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Message-ID: <Pine.LNX.4.58.0503200255090.3692@be1.lrz>
References: <1111278162.22BA.5209@neapel230.server4you.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Rene Scharfe wrote:

> The permissions of files in /proc/1 (usually belonging to init) are
> kept as they are.  The idea is to let system processes be freely
> visible by anyone, just as before.  Especially interesting in this
> regard would be instances of login.

I think you mean login shells, the login process is just the thing asking
for the password agter the (m)ingetty got the username. These processes
are usurally created with the '-' sign in argv[0][0], but the users may
replace that string at will. I think it's still OK to depend on that if
you want a semi-secure system.

>  I don't know how to easily
> discriminate between system processes and "normal" processes inside
> the kernel (apart from pid

Do you mean ppid?

> == 1 and uid == 0 (which is too broad)).
> Any ideas?

This feature seems to be frequently requested. I don't remember the 
outcome, though.

>From a quick view, it seems the symlinks in /proc are empty for kernel 
threads and non-empty for user processes. Since you're messing with the 
proc entries, this could be a cheap way to find the kernel threads.
Another possibility is by looking at the blocked signals, signal 9 may not 
be blocked by mortals.

For the system daemons, you could additionally check for the absence of a 
controlling tty, but that's still no safe distinction from a process run 
by nohup. Checking for sid=pid will filter additional processes, but it 
the shell in midnight commander and screen are still false positives.
Checking for */sbin*/ in $PID/command will fail as soon as the daemon 
overwrites argv[0].

I don't think there is a relaible way to tell the system service daemons
from screen except for the name, and you'll want to detect screen-alike
programs, too.

-- 
Top 100 things you don't want the sysadmin to say:
40. The sprinkler system isn't supposed to leak is it?

Friﬂ, Spammer: Colorado@getthatpills.com fkOB@ynyz.7eggert.dyndns.org

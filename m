Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275229AbTHGIji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275230AbTHGIji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:39:38 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:11978 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S275229AbTHGIjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:39:37 -0400
Date: Thu, 7 Aug 2003 01:39:30 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>, phil-list@redhat.com
Subject: NPTL v userland v LT (RH9+custom kernel problem)
Message-ID: <20030807013930.A26426@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The RH9 kernels have NPTL patches.  Standard 2.4.21 does not.
I am running a custom kernel without the NPTL stuff.

At least one RH9 userland piece is not working correctly with my
custom kernel.  If I use pam_ldap, the root user cannot login on
the console.

PAM prompts for the username and password, then pam_ldap appears to
get stuck in a syslog call.  It doesn't actually call syslog(), but if
I compare to a functional system, the working one opens /dev/log etc
whereas the broken one does an rt_sigsuspend() and hangs until a SIGALRM
is delivered (login having set this up before prompting for the password).
That's from looking at strace; I haven't looked at ltrace or tried to
run under the debugger yet.

Logging in as a normal user, then sudo'ing to root does work though.

A notable difference between these two cases is that in the former the
real uid of the 'login' process is root, and in the latter the real uid
of the 'sudo' process is that of the user.  (PAM config for login and sudo
are identical.)

I think I've seen a case where normal users couldn't login but I
may be misremembering.

So, finally getting to my question, should I even *expect* a non-NPTL
kernel to work with the RH9 userland?  If not, is there a simple fix
without going to NPTL, say just rebuilding glibc?  hmm... now that I
ask it I feel dumb, I do think I would need to rebuild glibc so it
knows the kernel has LinuxThreads, not NPTL.  OK, if that's true
are there any other libs I should need to rebuild?

thanks
/fc

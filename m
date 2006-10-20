Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWJTOkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWJTOkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWJTOkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:40:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46030 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932251AbWJTOkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:40:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <acahalan@gmail.com>, Cal Peake <cp@absolutedigital.net>,
       Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
	<Pine.LNX.4.64.0610181129090.3962@g5.osdl.org>
	<Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net>
	<20061018124415.e45ece22.akpm@osdl.org>
	<m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net>
	<m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com>
	<20061020075234.GA18645@flint.arm.linux.org.uk>
Date: Fri, 20 Oct 2006 08:38:07 -0600
In-Reply-To: <20061020075234.GA18645@flint.arm.linux.org.uk> (Russell King's
	message of "Fri, 20 Oct 2006 08:52:34 +0100")
Message-ID: <m1wt6v2gts.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> This assumes the binaries and/or libraries are not stripped, and they
> usually are stripped.  So, it is better to run something like:
> find / -type f -perm /111 | while read f; do readelf -Ws $f 2>/dev/null | fgrep
> -q sysctl@GLIBC && echo $f; done

Russell King <rmk+lkml@arm.linux.org.uk> writes:
> glibc on ARM _requires_ sys_sysctl for userspace ioperm, inb, outb etc
> emulation.


It looks like we have a small but interesting set of sysctl users.

The list of files below is a composite from a number of systems I have
access to, and the reply I have gotten so far.  I'm still hoping to hear
from other people so I can add some other users of sysctl to my list.

I'm still investigating to see how all of these pieces are using
sysctl, and how much they care:
- radvd seems to be an upstanding user.
- libsensors seems to be using sysctls so we have no responsibility to
  maintain the ABI there.
- libpthread uses sysctl but it doesn't much care.
- module_upgrade seems to be setting the printk verbosity?

The nvidia-installer sounds like a scary piece of code.

I'm puzzled why the majority of the users seem to be concentrated
in system configuration software and installers. 

These 


Compiling the results I have so far (Some of these are from older distros):
/sbin/kmodule
/sbin/sndconfig
/usr/X11R6/bin/Xconfigurator
/usr/bin/tiny-nvidia-installer
/usr/bin/nvidia-installer
/usr/sbin/glidelink
/usr/sbin/kudzu
/usr/sbin/module_upgrade
/usr/sbin/mouseconfig
/usr/sbin/radvd
/usr/sbin/updfstab

/usr/lib/libsensors.so.1.2.1
/usr/lib/libsensors.so.3.1.0
/usr/lib/libsensors.so.3.0.9
/usr/lib64/libsensors.so.2.0.0
/usr/lib64/libsensors.so.3.0.9

/usr/lib/python1.5/site-packages/_kudzumodule.so
/usr/lib/python2.2/site-packages/_kudzumodule.so
/usr/lib/python2.3/site-packages/_kudzumodule.so
/usr/lib64/python2.4/site-packages/_kudzumodule.so

/lib/i686/libpthread-0.10.so
/lib/i686/libpthread.so.0
/lib/i686/nosegneg/libpthread-2.4.so
/lib/libpthread-0.10.so
/lib/libpthread-0.9.so
/lib/libpthread.so.0
/lib/tls/libpthread-2.3.3.so
/lib/tls/libpthread-2.3.5.so
/lib/tls/libpthread-2.3.6.so
/lib/tls/libpthread.so.0
/lib/libpthread-2.4.so
/lib64/libpthread.so.0
/lib64/tls/libpthread.so.0
/lib64/libpthread-2.4.so
/usr/i386-glibc22-linux/lib/libpthread-0.9.so
/usr/i386-glibc22-linux/lib/libpthread.so.0


Eric

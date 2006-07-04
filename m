Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWGDTDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWGDTDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWGDTDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:03:33 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:52171 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932337AbWGDTDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:03:33 -0400
Message-ID: <44AABB31.8060605@colorfullife.com>
Date: Tue, 04 Jul 2006 21:02:09 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Kerrisk <michael.kerrisk@gmx.net>
CC: linux-kernel@vger.kernel.org, tytso@mit.edu, torvalds@osdl.com,
       drepper@redhat.com, Eric Paire <paire@ri.silicomp.fr>,
       Paul Eggert <eggert@cs.ucla.edu>, roland@redhat.com,
       Robert Love <rlove@rlove.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       mtk-lkml@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net>
In-Reply-To: <44A92DC8.9000401@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:

> c) The Linux baehviour has been arbitrary across kernel versions and 
> system calls.  In particular, the following system calls showed this 
> behaviour in earlier kernel versions, but then the behaviour was 
> changed without forewarning and (AFAIK) without subsequent complaint:
>
> [snip]
>
>       * msgsnd() and msgrcv() in kernels before 2.6.9.
>
That was my change - and I even forgot to mention it in the changelog 
(hiding in shame):
I replaced -EINTR with -ERESTARTNOHAND.
That hides signals that are handled in the kernel from user space - 
probably what we want.

Michael: Could you replace the EINTR in inotify.c with ERESTARTNOHAND? 
That should prevent the kernel from showing the signal to user space.
I'd guess that most instances of EINTR are wrong, except in device 
drivers: It means we return from the syscall, even if the signal handler 
wants to restart the system call.

--
    Manfred

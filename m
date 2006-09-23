Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWIWPkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWIWPkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWIWPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:40:43 -0400
Received: from mail.aknet.ru ([82.179.72.26]:32263 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751245AbWIWPkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:40:42 -0400
Message-ID: <451555CB.5010006@aknet.ru>
Date: Sat, 23 Sep 2006 19:42:03 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hugh Dickins wrote:
> automatically.  But they were put in for good reason, have been
> in for nearly three years, I doubt they should come out now.
I know they won't. I only thought I have to try, after seeing
the debian problem and googling out a few negative posts about
these checks.

> It's hardly any surprise, is it, that if a distro chooses now
> to mount something "noexec", a problem is then found with a few
> things which want otherwise?
They do not "want otherwise". They do the right thing - use
shm_open() and then mmap(), but mmap() suddenly fails. The apps
are not guilty. Neither I think the debian guys are.

> And it seems unlikely that the answer
> is then to modify the kernel, to weaken the very protection they're
> wanting to add?
I don't think they want to prevent PROT_EXEC mmaps. Almost
certainly not. Maybe they thought they would only block mere
execve() calls and the like, I don't know. My point is that
this change (use of "noexec") should not break the properly
written apps, but right now it does. Is it stated anywhere
in the shm_open() manpage or elsewhere that you must not use
"noexec" on tmpfs or you'll get troubles with mmap?

> The original 2.6.0 patch (later backported into 2.4.25) was
> <drepper@redhat.com>
> 	[PATCH] Fix 'noexec' behaviour
> 	We should not allow mmap() with PROT_EXEC on mounts marked "noexec",
> 	since otherwise there is no way for user-supplied executable loaders
> 	(like ld.so and emulator environments) to properly honour the
> 	"noexec"ness of the target.
Thanks for the pointer, but that looks like the user-space
issue to me. Why ld.so can't figure out the "noexecness" and
do the right thing itself? Or does it figure out the "noexecness"
exactly by trying the PROT_EXEC mmap and see if it fails?


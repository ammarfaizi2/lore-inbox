Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUGER5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUGER5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 13:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUGER5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 13:57:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:14559 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266142AbUGER5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 13:57:05 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Benjamin Collar <benjamin.collar@siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: using _syscall4 to call sys_futex with -fPIC won't
 compile
References: <je1xjqigxr.fsf@sykes.suse.de>
	<40E97F14.2060706@nortelnetworks.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Now I understand the meaning of ``THE MOD SQUAD''!
Date: Mon, 05 Jul 2004 19:57:03 +0200
In-Reply-To: <40E97F14.2060706@nortelnetworks.com> (Chris Friesen's message
 of "Mon, 05 Jul 2004 12:17:24 -0400")
Message-ID: <jewu1igwwg.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> The "_syscallx" macros are in the userspace versions of the kernel
> headers, and as such should be fair game.

They are known not to work with -fpic (on x86 anyway, other architectures
are less broken).  Anyway, just because there is no #ifdef __KERNEL__
doesn't mean a kernel header is meant for user space use.

> Also, you need to get a list of syscall numbers somehow, and those
> numbers are generally defined in the same file that contains the
> "_syscallx" macros.

They are duplicated in <sys/syscall.h> (which is auto-generated from the
list in <asm/unistd.h>).

> syscall() doesn't work for all system calls.  The man page explicitly
> warns that it doesn't work for pipe(2).

Only if pipe(2) uses the "two retvals" calling convention (Alpha and ia64,
but not x86 or m68k).  But then, pipe is already available without
syscall(), and new syscalls normally use simple enough calling conventions
that are suitable for syscall().

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

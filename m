Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVAPTTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVAPTTY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVAPTTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:19:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:55311 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262572AbVAPTTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:19:16 -0500
Date: Sun, 16 Jan 2005 20:07:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bill Pringlemeir <bpringle@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process system call access list.
Message-ID: <20050116190742.GL7048@alpha.home.local>
References: <m2wtudqjw9.fsf@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wtudqjw9.fsf@sympatico.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 16, 2005 at 02:00:22PM -0500, Bill Pringlemeir wrote:
> 
> [please CC me.]
> 
> I was looking at phrack and many of the remote exploits rely on
> injecting some arbitrary code.  Generally is is something like
> 'exec("/bin/sh")' or something like that.
> 
> I was wondering if a section could be added to the link phase of a
> user application that would keep a list/bit mask of all kernel calls
> that the compiler had encountered in some section.
> 
> When the kernel loaded a process, it would keep a copy of the bit mask
> and perform a comparison to see if the process was intended to make
> the system call (perhaps only a sub-set of the entire system calls are
> needed).

A friend of mine worked on something a bit like this for kernel 2.2. He
had a module which accepted syscall-based sets of rules based on prog
name, pid, uid, argument size and values, etc... He could even execute
code before and after the syscall (he could use it to keep an image of
what 'make install' touches). The goal was to identify all syscalls
needed from opensource programs through code reviewing, and try to
identify them using strace for closed-source programs (or simply let
them be vulnerable). We found it useful to protect against some attacks
on network-only programs; For example, a reverse-proxy has no reason to
either fork, exec, mount, mknod, etc... We did not have time to port this
to 2.4. However, now that the syscall_table is unexported, this is history.

There are other programs which do more or less the same (systrace comes
to mind). But in your case where the compiler gives the syscall list itself,
I have no knowledge of any similar tool. But I fear that if the bitmask is
kept within an ELF section, the attacker would first have to rewrite the
mask before using syscalls again (or put it in an RO section ?).

Regards,
Willy


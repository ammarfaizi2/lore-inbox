Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTKJNyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbTKJNyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:54:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11138 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263611AbTKJNyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:54:12 -0500
Date: Mon, 10 Nov 2003 08:55:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
In-Reply-To: <20031108162737.GB26350@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.53.0311100849260.12099@chaos>
References: <20031108162737.GB26350@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Nov 2003, Petr Vandrovec wrote:

> Hi Dave,
>   today I attempted to run 'x86info' on my system, and I was awarded by
> a bit unexpected answer:
>
> ppc:~/x# x86info -v
> x86info v1.12b.  Dave Jones 2001-2003
> Feedback to <davej@redhat.com>.
>
> readEntry: Bad address
> Found 1 CPUppc:~/x
>
>
> After some tweaking around I found that I cannot read some pages from /dev/mem -
> - I get -EFAULT on them. x86info run to the 0x86000 and 0x87000 pages, as it
> scans 0x80000-0x8FFFF range for mptable.
>

Your code works on 2.4.22 and probably somewhat higher versions. However,
as I understand it, the new kernels no longer mmap everything by default.
In other words, there are no PTEs unless you or a driver sets them.
In user-mode, you need to mmap() and in kernel mode, you use ioremap_*().

Since you can mmap() something that is already mmapped() without any
problem, the code should probably be "fixed" to mmap everything it
tries to read, page-by-page.

If this is not correct, I'm sure somebody will respond.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



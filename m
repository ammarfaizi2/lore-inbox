Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUG1TJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUG1TJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUG1TJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:09:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51429 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262382AbUG1TJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:09:01 -0400
Date: Wed, 28 Jul 2004 21:08:38 +0200 (MEST)
Message-Id: <200407281908.i6SJ8c9I015801@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: erik@harddisk-recovery.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 doesn't boot on a 386 without "Unsynced TSC support"
Cc: wli@holomorphy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004 17:47:49 +0200, Erik Mouw wrote:
>I tried to boot 2.4.26 on my good old 386 board, but got a kernel
>panic:
>
>  CPU: 386
>  Kernel panic: Kernel compiled for Pentium+, requires TSC feature!
...
>I am sure I selected support for a 80386 CPU, so the error message
>looks wrong to me. CONFIG_M586TSC is not set, but CONFIG_X86_TSC is
>enabled by default. The only way to disable it, is to enable "Unsynced
>TSC support", (CONFIG_X86_TSC_DISABLE).
...
>My question is: is this a code bug, or a documentation bug? Right now,
>I guess 2.4.26 will not run on anything < Pentium without
>CONFIG_X86_TSC_DISABLE enabled.

It's a limitation in scripts/Configure.
If you start with a .config with TSC enabled/required,
and just flip the CPU selection option to a TSC-less
CPU, like 386 or 486, then you end up with a .config
that _still_ has TSC enabled/required.

The workaround is to run 'make oldconfig' afterwards.

FWIW, both 2.4 and 2.6 kernels run Ok on my 486.
(My 486's Fedora user-space is another matter,
requiring kernel hacks for unconditional RDTSC
usage in RPM, but that's another issue.)

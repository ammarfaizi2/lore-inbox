Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263459AbVCMF4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbVCMF4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVCMF4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:56:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:39646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263459AbVCMF4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:56:13 -0500
Date: Sat, 12 Mar 2005 21:55:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.11-mm3] perfctr ia32 syscalls on x86-64 fix
Message-Id: <20050312215549.6e6dbd93.akpm@osdl.org>
In-Reply-To: <200503122326.j2CNQ6in029072@harpo.it.uu.se>
References: <200503122326.j2CNQ6in029072@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> The ia32 perfctr syscalls were moved due to addition of ioprio
>  syscalls, but the ia32 emulation code in x86-64 wasn't updated.

Ho hum.  The perfctr syscall API has changed so many times that whenever
someone adds a syscall I have rejects to fix up in probably ten different
patches.

It would be nice to start folding these patches together a bit to reduce
such problems, but that's rather non-trivial because there is no way to
simply join these patches together which maintains a sensible sequencing.

If we're going to do anything then it's either a major refactoring, or
simply wham the entire feature into a single diff.  That diff could then be
split into four patches: core, ppc, x86 and x86_64.  We would lose the
layering between ye olde perfctr, the inheritance implementation, the syfs
API, etc.  I could live with that.

What do you think?

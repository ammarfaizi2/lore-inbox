Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUKCPjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUKCPjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUKCPfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:35:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:6079 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261668AbUKCPdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:33:04 -0500
Date: Wed, 3 Nov 2004 07:32:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 12/14] FRV: Generate more useful debug info 
In-Reply-To: <12014.1099489103@redhat.com>
Message-ID: <Pine.LNX.4.58.0411030727540.2187@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411021750440.2187@ppc970.osdl.org> 
 <20041101162929.63af1d0d.akpm@osdl.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
 <200411011930.iA1JUMgs023243@warthog.cambridge.redhat.com> <5109.1099394496@redhat.com>
 <Pine.LNX.4.58.0411021747420.2187@ppc970.osdl.org>  <12014.1099489103@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Nov 2004, David Howells wrote:
> 
> I've been able to run a range of 2.4 and 2.6 kernels compiled with -O1 and
> without any -O flag at all, and with all "extern inline" changed to "static
> inline". It doesn't seem to be a problem on i386, x86_64, frv (which I'm
> trying to add) and am33 (which I haven't tried to add yet).

sparc64 was one of the things that definitely depended on it. Also, early
init/main.c depended on the stack not getting clobbered by the initial
fork, but that thankfully was cleaned up with the kernel threads
interfaces.

> Would you object to making it possible for the arch to override the
> optimisation level when debugging?

Quite frankly, I'd prefer developers to do it by just editing the 
Makefile, or doing it entirely statically for some architecture. 

For something like FRV in its current stages it simply doesn't _matter_,
but in architectures that get actual real usage, I absolutely hate the
idea of having different optimization options and wildly different code.
It just results in bugs being harder to reproduce.

And for architectures that don't have enough users to matter, arguably you 
shouldn't then need to have a config option that is visible to the rest of 
the world.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWFWDLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFWDLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWFWDLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:11:45 -0400
Received: from [198.99.130.12] ([198.99.130.12]:50058 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751126AbWFWDLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:11:44 -0400
Date: Thu, 22 Jun 2006 23:10:12 -0400
From: Jeff Dike <jdike@addtoit.com>
To: hpa@zytor.com, Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
Message-ID: <20060623031012.GA8395@ccure.user-mode-linux.org>
References: <20060619175243.24655.76005.sendpatchset@lappy> <20060619175253.24655.96323.sendpatchset@lappy> <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> <1151019590.15744.144.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151019590.15744.144.camel@lappy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 01:39:49AM +0200, Peter Zijlstra wrote:
> (PS, 2.6.17-mm1 UML doesn't seem to boot)

I don't get that far - it doesn't build for me.  It dies in klibc thusly:

  gcc -Wp,-MD,usr/klibc/syscalls/.typesize.o.d  -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.1/include -I/home/jdike/linux/2.6/test/linux-2.6.17/usr/include/arch/i386 -Iusr/include/arch/i386 -I/home/jdike/linux/2.6/test/linux-2.6.17/usr/include/bits32 -Iusr/include/bits32  -I/home/jdike/linux/2.6/test/linux-2.6.17/obj/usr/klibc/../include -I/home/jdike/linux/2.6/test/linux-2.6.17/usr/include -Iusr/include  -I/home/jdike/linux/2.6/test/linux-2.6.17/include -I/home/jdike/linux/2.6/test/linux-2.6.17/include2 -Iinclude2 -I/home/jdike/linux/2.6/test/linux-2.6.17/include -Iinclude  -I/home/jdike/linux/2.6/test/linux-2.6.17/include -D__KLIBC__=1 -D__KLIBC_MINOR__=4 -D_BITSIZE=32 -m32 -march=i386 -Os -g -fomit-frame-pointer -falign-functions=0 -falign-jumps=0 -falign-loops=0 -W -Wall -Wno-sign-compare -Wno-unused-parameter -c -o usr/klibc/syscalls/typesize.o usr/klibc/syscalls/typesize.c
usr/klibc/syscalls/typesize.c:1:23: error: syscommon.h: No such file or directory
usr/klibc/syscalls/typesize.c:5: error: '__u32' undeclared here (not in a function)
usr/klibc/syscalls/typesize.c:9: error: expected ')' before 'gid_t'
usr/klibc/syscalls/typesize.c:9: warning: type defaults to 'int' in declaration of 'type name'
usr/klibc/syscalls/typesize.c:10: error: expected ')' before 'sigset_t'
usr/klibc/syscalls/typesize.c:10: warning: type defaults to 'int' in declaration of 'type name'
usr/klibc/syscalls/typesize.c:21: error: 'dev_t' undeclared here (not in a function)
usr/klibc/syscalls/typesize.c:22: error: 'fd_set' undeclared here (not in a function)
usr/klibc/syscalls/typesize.c:22: error: expected expression before ')' token

syscommon.h is in usr/klibc/syscalls, but I don't see a -I pointing there.

				Jeff

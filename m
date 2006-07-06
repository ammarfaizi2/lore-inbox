Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWGFSjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWGFSjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWGFSjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:39:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750718AbWGFSjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:39:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060706105223.97b9a531.akpm@osdl.org> 
References: <20060706105223.97b9a531.akpm@osdl.org>  <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 06 Jul 2006 19:38:49 +0100
Message-ID: <26133.1152211129@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> llseek takes a loff_t and file->f_pos is loff_t.  I guess it's a bit moot
> on such a CPU.  Was it deliberate?

It compiles with no error and no warning, so I haven't noticed.  This is as
binfmt_elf.c is, I believe, so that is probably wrong too.

> (how come the kernel doesn't have a SEEK_SET #define?)

I don't know.  It probably should.

> Three callsites - seems too large to inline.

Again taken from binfmt_elf.c, although I added the debugging stuff.  It
shouldn't matter as the compiler will make its own decision (or does "inline"
get #defined to always-inline nowadays?).

> Which seems reasonable to me.  I'll steal it from them.

Okay.

> Embedding returns and gotos in macros is evil.  For new code it's worth
> doing it vaguely tastefully.

Again, stolen verbatim from binfmt_elf.c.  I'd prefer to keep it comparable by
the blink-comparator method if possible.

> Does this need locking?

It shouldn't do; we own our own vma chain, and because we're part of exec, we
have a fresh mm_struct to play with.  The VMAs themselves aren't allowed to
change, not even on NOMMU.

David

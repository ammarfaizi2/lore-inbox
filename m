Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUHTXFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUHTXFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 19:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268792AbUHTXFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 19:05:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47597 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268704AbUHTXF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 19:05:28 -0400
Date: Fri, 20 Aug 2004 19:05:21 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <reiserfs-dev@namesys.com>
Subject: Re: 2.6.8.1-mm2 - reiser4
In-Reply-To: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0408201852140.4192-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Rik van Riel wrote:
> On Thu, 19 Aug 2004, Andrew Morton wrote:
> 
> > - Added the reiser4 filesystem.

Oh, and another one.  The reiser 4 system call
sys_reiserfs seems to need an additional patch,
which is craftily hidden inside reiser4-only.patch

That patch creates fs/reiser4/linux-5_reiser4_syscall.patch,
which I can only assume reiser 4 users should apply...

Kind of ugly.

Looking further, the horrors only increase.  It looks like
sys_reiser4() is an interface to load programs into the
kernel, with reiserfs4 containing an interpreter.

I'll leave aside the issues of having a scripting language
inside the kernel, since I'm sure other people will comment
on it.

However, I am absolutely flabbergasted that Hans Reiser
is using a syscall here, instead of a filesystem interface.

Furthermore, why do the parsing in the kernel, instead of
compiling the human-readable strings in userspace and
loading something easy to use into the kernel, like the
selinux subsystem does?

Since this code is bound to be horribly controversial, it
may be an idea to remove this from the reiserfs4 core patch.
That way the battles over the filesystem, and its interactions
with the rest of the kernel can be fought first, without having
the whole reiserfs4 filesystem strand in the quicksand of 
"why do we need an interpreted language with completely new 
filesystem semantics in the kernel?"

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


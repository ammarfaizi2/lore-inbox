Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUBEDfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 22:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUBEDfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 22:35:38 -0500
Received: from thunk.org ([140.239.227.29]:40619 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264444AbUBEDff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 22:35:35 -0500
Date: Wed, 4 Feb 2004 22:35:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valdis.Kletnieks@vt.edu
Cc: Bill Davidsen <davidsen@tmr.com>, the grugq <grugq@hcunix.net>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040205033511.GA4452@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Valdis.Kletnieks@vt.edu,
	Bill Davidsen <davidsen@tmr.com>, the grugq <grugq@hcunix.net>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <20040204062936.GA2663@thunk.org> <4020EEB0.50002@hcunix.net> <40212643.4000104@tmr.com> <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 12:14:18PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > It would be useful to have this as a directory option, so that all files 
> > in directory would be protected. I think wherever you do it you have to 
> > prevent hard links, so that unlink really removes the data.
> 
> This of course implies that 'chattr +s' (or whatever it was) has to fail
> if the link count isn't exactly one.  Also makes for lots of uglyiness
> if it's a directory option - you then have to walk all the entries in the
> directory and check *their* link counts.  Bad Juju doing it in the kernel
> if you have a directory with a million entries - and racy as hell if you
> do it in userspace.

Disagree.  Unless you also want to make it illegal to establish a hard
link if the +s option is set.

A easier set of semantics is that when the inode count drops to zero,
the inode is securely deleted, but that if there are hard links, there
are hard links.  Basically the flag applies to inodes, and that in
some cases, where you create a file in a parent directory, the inode
may inherit the secure deletion flag.  But a creating a hard link
doesn't count as creating a new inode.

						- Ted




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVKKXl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVKKXl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVKKXl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:41:27 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:35206 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751321AbVKKXl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:41:27 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 23:41:15 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dl3a6r$ikf$1@taverner.CS.Berkeley.EDU>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511110211.05642.cloud.of.andor@gmail.com> <1131715816.3174.15.camel@localhost.localdomain> <200511112338.20684.cloud.of.andor@gmail.com>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1131752475 19087 128.32.168.222 (11 Nov 2005 23:41:15 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Fri, 11 Nov 2005 23:41:15 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Scordino  wrote:
>So, is the following patch right ? I've added both the lock and the owner 
>check...

I think this patch is too permissive.  It lets me run a setuid-root
program and then call getrusage() on it.  That's not a good idea.
(I might, say, run /bin/su and then mount a timing or cache side-channel
attacks on its password hashing code.  That particular example might or
might not work, but I hope it illustrates my concern.)

Should you be using the same permission check that ptrace() does?
ptrace() is more restrictive than what you seemed to have in mind.
However, if ptrace() lets you attach to a process, then it's probably
pretty safe to let you call getrusage(), as you could have just used
ptrace() to read the process's entire memory image.

kernel/ptrace.c:ptrace_may_attach() might be relevant.

TOCTTOU vulnerabilities could be a problem.  If I understand correctly,
your locking code should take care of this, but you might want to
double-check, as I'm not very familiar with the kernel's locking scheme.

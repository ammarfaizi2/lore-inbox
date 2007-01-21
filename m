Return-Path: <linux-kernel-owner+w=401wt.eu-S1751799AbXAUX6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXAUX6o (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXAUX6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:58:44 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:45017 "EHLO
	taverner.cs.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbXAUX6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:58:43 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] Undo some of the pseudo-security madness
Date: Sun, 21 Jan 2007 23:34:56 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ep0tb0$f6e$1@taverner.cs.berkeley.edu>
References: <87r6toufpp.wl@betelheise.deep.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1169422496 15566 128.32.168.222 (21 Jan 2007 23:34:56 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sun, 21 Jan 2007 23:34:56 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff  wrote:
>[...] directly setuid root the lisp system executable itself [...]

Like I said, that sounds like a bad idea to me.  Sounds like a recipe for
privilege escalation vulnerabilities.  Was the lisp system executable
really implemented to be secure even when you make it setuid root?
Setting the setuid-root bit on programs that didn't expect to be
setuid-root is generally not a very safe thing to do. [1]

The more I hear, the more unconvinced I am by this use case.

If you don't care about the security issues created by (mis)using the lisp
interpreter in this way, then like I suggested before, you can always
write a tiny setuid-root wrapper program that turns off address space
randomization and exec()s the lisp system executable, and leave the lisp
system executable non-setuid and don't touch the code in the Linux kernel.
That strikes me as a better solution: those who don't mind the security
risks can take all the risks they want, without forcing others to take
unwanted and unnecessary risks.

It's not that I'm wedded to address space randomization of setuid
programs, or that I think it would be a disaster if this patch were
accepted.  Local privilege escalation attacks aren't the end of the world;
in all honesty, they're pretty much irrelevant to many or most users.
It's just that the arguments I'm hearing advanced in support of this
change seem dubious, and the change does eliminate one of the defenses
against a certain (narrow) class of attacks.


[1] In comparison, suidperl was designed to be installed setuid-root,
and it takes special precautions to be safe in this usage.  (And even it
has had some security vulnerabilities, despite its best efforts, which
illustrates how tricky this business can be.)  Setting the setuid-root
bit on a large complex interpreter that wasn't designed to be setuid-root
seems like a pretty dubious proposition to me.

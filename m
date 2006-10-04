Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWJDEGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWJDEGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWJDEGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:06:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:20120 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932339AbWJDEGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:06:36 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 4 Oct 2006 03:17:59 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <efv957$31o$2@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159931879 3128 128.32.168.222 (4 Oct 2006 03:17:59 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 4 Oct 2006 03:17:59 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev  wrote:
>Arjan van de Ven wrote:
>> no what bothers me that on the one hand you want no execute from the
>> partition, and AT THE SAME TIME want stuff to execute from there (being
>> libraries or binaries, same thing to me).
>
>The original problem came from "noexec" on /dev/shm
>mount. There is no library and no binary there, but
>the programs do shm_open(), ftruncate() and
>mmap(MAP_SHARED, PROT_EXEC) to get some shared memory
>with an exec perm. That fails.

To be honest, I still don't think you've answered Arjan's question.  Ok,
so you say it is not a library and not a binary.  So what is it that you
are maping in as executable, and why do you think it is reasonable to
ask the Linux kernel to allow you to execute it, if it lives on a noexec
partition?  Whatever it is, you are executing it, and the goal of noexec
is to prevent execution of code that lives on a noexec partition, so
what you want to do seems in direct opposition to the goal of noexec.

Arjan's point is that what you want to do is take code that lives on a
noexec partition and execute it.  Isn't that exactly against the whole
point of noexec?

Or, to put it another way, if you want to execute code off of some
partition, why do you want to be able to mark it as noexec?  What is
the point of marking it noexec, when you're going to be executing code
off of it?  Why not just mark it exec and be done with it?  What are
your goals here?  Or, to put it yet another way, what problem are you
trying to solve (and why isn't marking the partition exec a satisfactory
solution to that problem)?

I think Arjan's question is a fair one and I think he deserves a straight
answer to his question.  I don't think he should have to ask it three
times.

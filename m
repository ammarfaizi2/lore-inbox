Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932788AbWJGTg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbWJGTg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWJGTg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:36:58 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:43984 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932788AbWJGTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:36:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] honour MNT_NOEXEC for access()
Date: Sat, 7 Oct 2006 19:36:49 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg8vkh$u1m$1@taverner.cs.berkeley.edu>
References: <4516B721.5070801@redhat.com> <45278D2A.4020605@aknet.ru> <4527D64A.7060002@redhat.com> <4527FC8B.8010208@aknet.ru>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1160249809 30774 128.32.168.222 (7 Oct 2006 19:36:49 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sat, 7 Oct 2006 19:36:49 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev  wrote:
>Ulrich Drepper wrote:
>>> Now, as the access(X_OK) is fixed, would it be
>>> feasible for ld.so to start using it?
>> Just must be kidding.  No access control can be reliably implemented at
>> userlevel.  There is no point starting something as stupid as this.
>But in this case how can you ever solve the
>problem of ld.so executing the binaries for which
>the user does not have an exec permission?

By using the kernel's existing access control -- not trying to roll
your own access control at the user level.  This is a standard recommendation
in the security world, and it is good advice.

For instance, in this case, this advice might mean that you just call
execve() and check whether it succeeded or failed, and let the kernel
do the access control check on whether the exec is permitted.  That tends
to be more fool-proof (or at least fool-resistant) than the alternatives.

>Yes, the userspace apps usually should not enforce
>the kernel's access control, but ld.so seems to be
>the special case - it is a kernel helper after all,
>so it have to be carefull and check what it does.

Perhaps.  But it seems to me that there would need to be a persuasive
argument before it makes sense to violate the general advice listed above.

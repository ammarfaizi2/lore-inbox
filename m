Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUHBHBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUHBHBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 03:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUHBG7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:59:44 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:10 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S266316AbUHBGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:52:28 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: secure computing for 2.6.7
Date: Mon, 2 Aug 2004 06:52:13 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cekoat$dok$1@abraham.cs.berkeley.edu>
References: <20040704173903.GE7281@dualathlon.random> <20040801150119.GE6295@dualathlon.random> <Pine.LNX.4.58.0408011801260.1368@sphinx.mythic-beasts.com> <20040801230647.GH6295@dualathlon.random>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1091429533 14100 128.32.168.222 (2 Aug 2004 06:52:13 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 2 Aug 2004 06:52:13 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli  wrote:
>On Sun, Aug 01, 2004 at 06:29:05PM +0100, chris@scary.beasts.org wrote:
>> How hard would it be to have a per-task bitmap of syscalls allowed?
>
>your app will have then to learn about the syscall details of every
>arch (which is normally a kernel internal thing),

I'm not convinced this is a big deal.  In security, you always white
list known safe operations (never black list unsafe ones!).  Therefore,
you only white list the ones you know, and the result will be fail-safe
when porting to new architectures.

If the only hard case is *sigreturn(), it's not too hard to hard-code
that once and be done with it.

It seems like a bitmap will be much more flexible.  I already spotted
issues with the list of syscalls someone else posted (it included open(),
if I recall correctly), and I bet others would dislike any list I would
come up with.  My experience working with experimental tools like these
is that different apps may need different restrictions.

>the syscall numbers vary across every arch 

Isn't that what #include <sys/syscall.h> is for?  

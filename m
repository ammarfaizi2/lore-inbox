Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUCVAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbUCVAS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:18:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65408 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261531AbUCVASz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:18:55 -0500
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
	<Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
	<20040321181430.GB29440@wohnheim.fh-wedel.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Mar 2004 17:18:41 -0700
In-Reply-To: <20040321181430.GB29440@wohnheim.fh-wedel.de>
Message-ID: <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> On Sun, 21 March 2004 09:59:39 -0800, Davide Libenzi wrote:
> > 
> > When I did that, fumes of an in-kernel implementation invaded my head for 
> > a little while. Then you start thinking that you have to teach apps of new 
> > open(2) semantics, you have to bloat kernel code a little bit and you have 
> > to deal with a new set of errors cases that open(2) is not expected to 
> > deal with. A fully userspace implementation did fit my needs at that time, 
> > even if the LD_PRELOAD trick might break if weak aliases setup for open 
> > functions change inside glibc.
> 
> 209 fairly simple lines definitely have more appear than a full
> in-kernel implementation with many new corner-cases, yes.  But it
> looks as if you ignore the -ENOSPC case, so you cheated a little. ;)
> 
> No matter how you try, there is no way around an additional return
> code for open(), so we have to break compatibility anyway.  The good
> news is that a) people not using this feature won't notice and b) all
> programs I tried so far can deal with the problem.  Vim even has a
> decent error message - as if my patch was anticipated already.

Actually there is...  You don't do the copy until an actual write occurs.
Some files are opened read/write when there is simply the chance they might
be written to so delaying the copy is generally a win.

A coworker of mine implemented a version of this idea as a filesystem.
It did the copy in the kernel, it handled directories, and could be
used to atomically snapshot your filesystem.  The only case that was
still a little sketchy was how do you handle cow to a file with hard
links. 

The interesting case for us is when you have multiple machines sharing
the same root filesystem.

Eric

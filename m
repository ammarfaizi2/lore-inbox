Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUC0K2m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 05:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUC0K2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 05:28:42 -0500
Received: from mail.shareable.org ([81.29.64.88]:11154 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261672AbUC0K2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 05:28:40 -0500
Date: Sat, 27 Mar 2004 10:28:28 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040327102828.GA21884@mail.shareable.org>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> It is easy to add something like a cowstat or a readcowlink and teach
> the few programs that care (i.e. diff, tar,...) how to use it.  So I
> would rather concentrate on making cow links look like a separate copy
> than early optimizations.

I agree, having each cowlink look like a separate copy, with separate
inode numbers, is best.  That _is_ POSIX compatible -- the sharing is
just a storage optimisation, and programs which only use the POSIX API
won't see the difference.

I have no problem with adding cowstat() to diff, and I'm sure other
people will eventually extend rsync and tar to use it, if it becomes
widely used.

It's not the simplest solution, though.  The filesystem changes are
non-trivial.  (The simplest solution is just an ext2 attribute which
says you can't write to the file if it has >1 links).

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbUCYSHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCYSHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:07:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51340 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263535AbUCYSHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:07:30 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
	<Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
	<20040321181430.GB29440@wohnheim.fh-wedel.de>
	<m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
	<20040325174942.GC11236@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Mar 2004 11:06:49 -0700
In-Reply-To: <20040325174942.GC11236@mail.shareable.org>
Message-ID: <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > Actually there is...  You don't do the copy until an actual write occurs.
> > Some files are opened read/write when there is simply the chance they might
> > be written to so delaying the copy is generally a win.
> 
> Programs depend on the inode number returned by fstat() not changing,
> and maybe in some other circumstances, even if they subsequently write
> to the file.
> 
> (It's ok for open() to change the inode number, because that's
> equivalent to another program changing the filesystem in parallel).
> 
> How do you handle that if COW occurs later than open()?
> You could also force COW when fstat() is called, I suppose.

One of the rougher patches, in that we don't have persistent inode
numbers.  Basically the two files never have the same inode number.
To the user they are always presented as two separate files.
Currently I believe the strategy is to assign an inode when the file
is read into the icache/dcache.  I think it is just a sequential
counter.

This was all implemented as a stackable filesystem.  Something
that gets down to the real filesystem could likely just reuse
the inode number of the cow link.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUC1Ane (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUC1Ane
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:43:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31895 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262027AbUC1Anc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:43:32 -0500
To: Jamie Lokier <jamie@shareable.org>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
References: <20040321125730.GB21844@wohnheim.fh-wedel.de>
	<Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com>
	<20040321181430.GB29440@wohnheim.fh-wedel.de>
	<m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
	<20040325174942.GC11236@mail.shareable.org>
	<m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
	<20040325194303.GE11236@mail.shareable.org>
	<m1ptb0zjki.fsf@ebiederm.dsl.xmission.com>
	<20040327102828.GA21884@mail.shareable.org>
	<m1vfkq80oy.fsf@ebiederm.dsl.xmission.com>
	<20040327214238.GA23893@mail.shareable.org>
	<m1ptax97m6.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Mar 2004 17:43:11 -0700
In-Reply-To: <m1ptax97m6.fsf@ebiederm.dsl.xmission.com>
Message-ID: <m1brmhvm1s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> The addictive thing about the prototype implementation was that you
> could do ``ln --cow / /some/other/directory'' and you would have an
> atomic snapshot of your filesystem.  Definitely not a feature for the
> first implementation but certainly something to dream about.

Addictive but broken by design.  If any of the files inside your
directory tree have hard links outside of the tree there is no way
short of recursing through all of the subdirectories directories to
tell if a given inode has is in use.  Except in the special case
where you are taking a cow copy of the entire filesystem.  At which
point a magic mount option is likely a better interface.

Ok that simplifies the long term design a little more.  cow
directories cannot work correctly in all cases even when implemented
in the kernel.  So the directory walking must still be done in user
space.


Eric

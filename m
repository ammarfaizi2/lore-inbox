Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUEIOKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUEIOKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 10:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbUEIOKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 10:10:06 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4621 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264344AbUEIOKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 10:10:01 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Sun, 9 May 2004 17:09:37 +0300
User-Agent: KMail/1.5.4
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405081645.06969.vda@port.imtp.ilyichevsk.odessa.ua> <20040508221017.GA29255@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040508221017.GA29255@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405091709.37518.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 May 2004 01:10, Pavel Machek wrote:
> Hi!
>
> > That is probably unfixable now, but you can avoid making similar
> > error. Provide is_cowlinked(fd1,fd2) syscall. Pity you will
> > have to use different inode numbers for cowlinks (due to tar/cp),
> > and this won't fly:
>
> is_cowlinked does not fly, either. For n files, you have to do O(n^2)
> calls to find those that are linked.

Hm, let me think about it. diff does not need to check all permutations,
it checks only those two which it needs to compare.

IMHO "inodes done right" is something like this: if inode numbers are
different, then files are not hardlinked/cowlinked. If they are the same,
check is_hardlinked(a,b) or is_cowlinked(a,b) to find out.

This beats O(n^2) argument.

But this is non-POSIX, would not be accepted.

I don't know how to handle this now. Introducing cow-inode number
with semantic "cowino1==cowino2 => files are cowlinked" is
ugly and won't deal with per-block cow. Sooner or later someone
will want to have per block cow. Think about cow'ing multi-gigabyte
database files for checkpointing/backup purposes...

> You want get_cowlinked_id which can return -1 "I do not know".

Is this the same to my "cow-inode number" concept above?
--
vda


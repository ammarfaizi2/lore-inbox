Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbSLKIsK>; Wed, 11 Dec 2002 03:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbSLKIsK>; Wed, 11 Dec 2002 03:48:10 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3090 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267070AbSLKIsJ>; Wed, 11 Dec 2002 03:48:09 -0500
Date: Wed, 11 Dec 2002 09:55:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: marcelo <marcelo@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021211085553.GB8740@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	marcelo <marcelo@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Marcelo Tosatti wrote:

> So here goes the first pre of 2.4.21 including the new IDE code merged
> from Alan's tree.
> 
> Test it carefully, since the new IDE code is not yet fully tested.
> 
> Do not use it with critical data.

Oh, speaking of "carefully", could Andrew Morton's mount -o dirsync
feature patch for 2.4.21 please be merged early in v2.4.21-pre? User
space (util-linux, e2fsprogs' lsattr/chattr) has been supporting it for
a while, just the kernel lacked it.

This -o dirsync feature is necessary to give applications that are
either unaware of Linux' default -o async or that do not want to cater
for deliberate incompatibilities a big performance boost: these
applications (Postfix on ext2fs but not on 2.4 ext3fs or reiserfs, qmail
on any Linux fs, probably a lot others I haven't even looked at)
traditionally *require* chattr +S or mount -o sync to work reliably,
after the merge, they could instead go with mount -o dirsync or chattr
+D, which improves write speed quite a bit.

Not applying the dirsync patch means that a stupid BSD ffs in default
configuration will beat Linux (that needs -o sync) hands-down without
any tuning the admin could do. One might also consider making -o dirsync
the default while one's there, to give users a default-reliable setting,
but this is going to rouse the performance fetishists who don't care
about data persistence and who don't care to collect their new files
from lost+found on ext2fs but rather cheat benchmarks.

I can elaborate a bit more, but this has been discussed multiple times
and after all, the code is there.

> Summary of changes from v2.4.20 to v2.4.21-pre1

...

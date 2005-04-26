Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDZEOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDZEOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 00:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVDZEOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 00:14:43 -0400
Received: from mail.timesys.com ([65.117.135.102]:36378 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261290AbVDZEOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 00:14:25 -0400
Message-ID: <426DBF94.3010502@timesys.com>
Date: Mon, 25 Apr 2005 21:12:04 -0700
From: Mike Taht <mike.taht@timesys.com>
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pasky@ucw.cz, git@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
References: <20050426032422.GQ13467@pasky.ji.cz>
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2005 04:08:55.0609 (UTC) FILETIME=[A9F4D290:01C54A15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Yes, this is a huge change. No, I don't expect any further changes of
> similar scale. I think the new interface is significantly simpler _and_
> cleaner than the old one.

Heh. Another huge change would be moving the top level directories 
around a bit.


bindings  COPYING  git.spec  Makefile  programs  README.reference  tests
contrib   doc      include   po        README    src  VERSION

Leaving fixing the makefiles aside as an exercise for the interested 
reader... that's:

#!/bin/sh

# completely rearrange the file structure of cogito/git
# just to make pasky and other scm users insane once again
# FIXME - fix the makefiles, git.spec

CFILES=`ls *.c`
DFILES=`ls ppc/* mozilla-sha1/*`
HFILES=`ls *.h`
SRCDIR=src # or libgit?
INCDIR=include/git-guts # or keep in SRCDIR or include/git or whatever
COGDIR=programs/cogito # or just cogito. is git-web likely to be inc?

mkdir -p $SRCDIR $INCDIR $COGDIR \
bindings/perl bindings/python bindings/ruby po tests doc # just ideas,
# no files (yet)

mv $CFILES ppc mozilla-sha1 $SRCDIR
mv $HFILES $INCDIR
COGFILES=`file * | grep "script text executable" | cut -f1 -d:`
mv $COGFILES $COGDIR

cg-rm $CFILES $HFILES $COGFILES
for i in $CFILES $DFILES
do
         cg-add $SRCDIR/$i
done
for i in $HFILES
do
         cg-add $INCDIR/$i
done

cg-commit




-- 

Mike Taht


   "A straw vote only shows which way the hot air blows.
	-- O'Henry"

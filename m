Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVDJKXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVDJKXL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDJKXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:23:11 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:44808 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261464AbVDJKXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:23:07 -0400
Message-Id: <200504101022.j3AAMtg03784@blake.inputplus.co.uk>
To: Paul Jackson <pj@engr.sgi.com>
cc: torvalds@osdl.org, pasky@ucw.cz, rddunlap@osdl.org, ross@jose.lug.udel.edu,
       mingo@elte.hu, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more git updates.. 
In-Reply-To: <20050409173944.247252eb.pj@engr.sgi.com> 
Date: Sun, 10 Apr 2005 11:22:55 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,

> Ralph wrote:
> > Watch out for when xargs invokes do_something more than once and the
> > `<' is parsed by a different one than the `>'.
> 
> It will take a pretty long list to do that.  It seems that GNU xargs
> on top of a Linux kernel has a 128 KByte ARG_MAX.

I didn't realise it was that long, but one pair of files to diff takes
128 bytes of that.

    $ wc -c <<\E
    > <100664 aff074c63ac827801a7d02ff92781365957f1430 update-cache.c
    > >100664 3a672397164d5ff27a19a6888b578af96824ede7 update-cache.c
    > E
        128

So that's space for 1024 pairs.  (Doesn't envp take some up too?)  That
doesn't seem enough for diffs between revisions, but good enough for
most uses that people will get caught out when it fails.

    $ bzip2 -dc patch-2.6.10.bz2 | grep -c '^diff '      
    5384

Cheers,


Ralph.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVDIHhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVDIHhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVDIHhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:37:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42248 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261307AbVDIHhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:37:38 -0400
Date: Sat, 9 Apr 2005 09:37:27 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409073726.GC7858@alpha.home.local>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org> <20050408071428.GB3957@opteron.random> <Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org> <4256AE0D.201@tiscali.de> <Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org> <4256C0F8.6030008@pobox.com> <Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org> <20050408185608.GA5638@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408185608.GA5638@taniwha.stupidest.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 11:56:09AM -0700, Chris Wedgwood wrote:
> On Fri, Apr 08, 2005 at 11:47:10AM -0700, Linus Torvalds wrote:
> 
> > Don't use NFS for development. It sucks for BK too.
> 
> Some times NFS is unavoidable.
> 
> In the best case (see previous email wrt to only stat'ing the parent
> directories when you can) for a current kernel though you can get away
> with 894 stats --- over NFS that would probably be tolerable.
> 
> After claiming such an optimization is probably not worth while I'm
> now thinking for network filesystems it might be.

I've just checked, it takes 5.7s to compare 2.4.29{,-hf3} over NFS (13300
files each) and 1.3s once the trees are cached locally. This is without
comparing file contents, just meta-data. And it takes 19.33s to compare
the file's md5 sums once the trees are cached. I don't know if there are
ways to avoid some NFS operations when everything is cached.

Anyway, the system does not seem much efficient on hard links, it caches
the files twice :-(

Willy


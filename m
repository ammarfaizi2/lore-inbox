Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbRAPWjA>; Tue, 16 Jan 2001 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132091AbRAPWiv>; Tue, 16 Jan 2001 17:38:51 -0500
Received: from fungus.teststation.com ([212.32.186.211]:46729 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130237AbRAPWii>; Tue, 16 Jan 2001 17:38:38 -0500
Date: Tue, 16 Jan 2001 23:38:34 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>, <rmager@vgkk.com>
Subject: Re: Oops with 4GB memory setting in 2.4.0 stable
In-Reply-To: <12C574CB1236@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0101162250320.13791-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Petr Vandrovec wrote:

> If there is new dentry, which is at fpos postion, and it is child of
> readdir-ed directory, we should return it anyway, no? There must not be
> two ncpfs dentries with same d_parent and d_fsdata if d_fsdata != 0,
> as each dentry can be in only one directory.
>
> This looked as reasonable limitation to me ;-)

Right. I chose not to read those tests for some reason ... good.

The parent test should be ok. d_fsdata is only set in ncpfs if it is put
in the cache and d_alloc sets it to 0. Works for me (whatever that may be
worth).


Rewriting the smbfs cache code allows for a nice speedup too.

In ncpfs when reading a directory you create dentries and inodes at once.
I assume that when reading the dir list from the server that you get all
the info you need in one go.

I think smbfs gets all needed info on all protocol versions it supports,
so that should be a nice speedup for readdir() + stat()-each file (ls -l).
Currently it only caches name info and then does a remote call for each
entry.

Too bad this is 2.4.0, the biggest problem may be sneaking it past Linus.
oh well ... :)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

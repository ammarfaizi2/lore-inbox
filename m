Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSEQEW1>; Fri, 17 May 2002 00:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSEQEW0>; Fri, 17 May 2002 00:22:26 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:16396 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315414AbSEQEW0>;
	Fri, 17 May 2002 00:22:26 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205170422.g4H4M5q295551@saturn.cs.uml.edu>
Subject: Re: Htree directory index for Ext2, updated
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Fri, 17 May 2002 00:22:04 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E178Vhr-0008Vj-00@starship> from "Daniel Phillips" at May 17, 2002 02:34:51 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After learning to my horror that gnu patch will, if a patch was made to be 
> applied with option -p0, sometimes apply patches to your 'clean' tree (the 
> one with the ---'s) instead of the target tree (the one with the +++'s) I 
> decided to switch to -p1, and that is how this patch is to be applied.

The worst thing is that gnu patch will make
this decision on a per-file basis, so you
can't then back out the changes with -R.

Do like this:

diff -Naurd old new

IMPORTANT: the directory names should have
the same number of characters in them.
Do not try something like:

diff -Naurd bad idea
diff -Naurd doomed 2fail

Don't use "linux" for a name. Don't use
anything Linus might use. Pick your own
equal-length directory names, and don't
distribute tarballs containing them.
This prevents source-destroying disasters.

Then to apply:

(cd my-linux && bzip2 -dc ../foo.bz2 | patch -p1 -s -E)


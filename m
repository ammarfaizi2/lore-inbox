Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbQLOUAJ>; Fri, 15 Dec 2000 15:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLOT77>; Fri, 15 Dec 2000 14:59:59 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:3332 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S129413AbQLOT7w>; Fri, 15 Dec 2000 14:59:52 -0500
Message-ID: <3A3A7284.DE48A381@alacritech.com>
Date: Fri, 15 Dec 2000 11:35:32 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <Pine.GSO.4.21.0012141900140.10441-100000@weyl.math.psu.edu> <20001215152137.K599@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> 
> Alexander Viro wrote:
> > In the situation above they should have -I<wherever_the_tree_lives>/include
> > in CFLAGS. Always had to. No links, no pain in ass, no interference with
> > userland compiles.
> 
> As long as there's a standard location for "<wherever_the_tree_lives>",
> this is fine. In most cases, the tree one expects to find is "roughly
> the kernel we're running". Actually, maybe a script to provide the
> path would be even better (*). Such a script could also complain if
> there's an obvious problem.

I personally think the definition of an environment variable to point to
a header file location is the right way to go.  Same with tools -- that
way I can say build with $(TOOLDIR), which pulls whatever tools that
tree uses, and use $(INCDIR) as my kernel include files.

Then you can build using whatever header files you want to use, using
whatever compilers/linkers/whatever you want to.  So:

TOOLDIR=/src/gcctree
INCDIR=/src/2.2.18

or:

TOOLDIR=/src/egcstree
INCDIR=/src/2.4.0-test12-custom

Then a 'make' from my $(TOPDIR) builds everything with the tools in
$(TOOLDIR) and uses -I$(INCDIR) for header files.  It's a beautiful
thing.

--Matt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

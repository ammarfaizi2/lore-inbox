Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUGOP6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUGOP6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUGOP6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:58:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63153 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266227AbUGOP6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:58:19 -0400
Date: Thu, 15 Jul 2004 16:58:15 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, axboe@suse.de, wli@holomorphy.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org, dgilbert@interlog.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Message-ID: <20040715155815.GH32326@parcelfarce.linux.theplanet.co.uk>
References: <200407150946.i6F9kqXn010635@harpo.it.uu.se> <40F68212.2020405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F68212.2020405@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 09:09:38AM -0400, Jeff Garzik wrote:
> >Compilers for top-down (define-before-use) languages like C
> >have traditionally also worked in a top-down fashion, processing
> >one top-level declaration at a time. Forward references are
> >either errors, or are (when a proper declaration is in scope)
> >left to the linker to resolve.
> >
> >Processing an entire compilation-unit (e.g. whole C file)
> >as a single unit is typically _only_ done when either the
> >language semantics requires it (not C, but e.g. Haskell),
> >or when very high optimisation levels are requested.
> 
> Or in the case where you parse the entire file, then generate code for 
> the entire file in a separate pass.  Which does NOT imply 
> unit-at-a-time, for the readers at home.  It just implies generation of 
> the AST.

... which GCC didn't use to do.  It used to generate RTL directly from
the source.  From the GCC news and announcements page:

October 5, 2001
    Alexandre Oliva of Red Hat has generalized the tree inlining
    infrastructure, formerly in the C++ front end, so that it is now
    used in the C front end too.

> >In the case of gcc-3.4.1 failing to inline, you are asking
> >gcc to do something (peeking forward) which it never has
> >promised to do. And with the kernel using -fno-unit-at-a-time
> >for stack conservation reasons, gcc is actually being _told_
> >not to do global compilation.
> >
> >This is not a gcc bug, nor is it being "exceedingly dumb".
> 
> Actually, yes it is.

No, it's not.  It's always been this way.  You seemed to ignore that
message I posted yesterday.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266715AbUHDDOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266715AbUHDDOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 23:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUHDDOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 23:14:16 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:43471 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266715AbUHDDOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 23:14:11 -0400
Date: Wed, 4 Aug 2004 05:13:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804031346.GV2241@dualathlon.random>
References: <20040804021332.GT2241@dualathlon.random> <Pine.LNX.4.44.0408032221310.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408032221310.5948-100000@dhcp83-102.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:22:30PM -0400, Rik van Riel wrote:
> On Wed, 4 Aug 2004, Andrea Arcangeli wrote:
> 
> > > Normal hugetlb file creation (through the filesystem) isn't touched
> > > by these patches.
> > 
> > it is:
> 
> Hugetlb file creation through the filesystem never calls
> hugetlb_zero_setup!  What are you talking about ?
> 
> > diff -purN linux-2.6.7/fs/hugetlbfs/inode.c linux/fs/hugetlbfs/inode.c
> > --- linux-2.6.7/fs/hugetlbfs/inode.c    2004-07-29 11:36:55.744448953
> > +0200
> > +++ linux/fs/hugetlbfs/inode.c  2004-07-29 11:38:04.292595263 +0200
> > @@ -722,7 +722,7 @@ struct file *hugetlb_zero_setup(size_t s
> >         struct qstr quick_string;
> >         char buf[16];
> > 
> > -       if (!capable(CAP_IPC_LOCK))
> > +       if (!can_do_mlock())
> >                 return ERR_PTR(-EPERM);
> 
> > this breaks local security if you set the rlimit to 1 byte (well, 1 byte
> > == disable_cap_mlock).
> 
> Please read my incremental patch.  It adds a quota check
> right after this code segment.

I thought the check was applied to files too, and such code would not
have worked correctly with files.

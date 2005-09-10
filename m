Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVIJO4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVIJO4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVIJO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:56:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:48832 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932074AbVIJO4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:56:08 -0400
Date: Sat, 10 Sep 2005 23:55:25 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: Re: [PATCH 0/6] jbd cleanup
Message-ID: <20050910145525.GB7593@miraclelinux.com>
References: <20050909084214.GB14205@miraclelinux.com> <20050909021522.1a271e4b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050909021522.1a271e4b.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 02:15:22AM -0700, Andrew Morton wrote:
> Akinobu Mita <mita@miraclelinux.com> wrote:
> >
> > The following 6 patches cleanup the jbd code and kill about 200 lines. 
> >
> 
> Thanks, but I'm not inclined to apply them.
> 
> a) Maybe 70-80% of the Linux world uses this filesystem.  We need to be
>    very cautious in making changes to it.

And we need many eyeballs.
(I've tried to understand how the jbd works several times.
 But I always failed.)

> b) A relatively large number of people are carrying quite large
>    out-of-tree patches, some of which they're hoping to merge sometime. 
>    Admittedly more against ext3 than JBD, but there is potential here to
>    cause those people trouble.
> 
> Plus the switch to list_heads in journal_s has some impact on type safety
> and debuggability - I considered doing it years ago but decided not to
> because I found I _used_ those pointers fairly commonly in development. 
> list_heads are a bit of a pain in gdb (kgdb and kernel core dumps), for
> example.

About the debuggability of list_heads, how about adding the kind of
the following gdb macros in .gdbinit?

---

define list_entry
	set $ptr=$arg0
	p ($arg1 *)((char *)$ptr - (size_t) &(($arg1 *)0)->$arg2)
end

define list_entry_s
	set $ptr=$arg0
	p (struct $arg1 *)((char *)$ptr - (size_t) &((struct $arg1 *)0)->$arg2)
end

define to_journal_head
	list_entry_s $arg0 journal_head b_list
end


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273828AbSISXrz>; Thu, 19 Sep 2002 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273908AbSISXrz>; Thu, 19 Sep 2002 19:47:55 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:13698 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S273828AbSISXry>; Thu, 19 Sep 2002 19:47:54 -0400
Message-Id: <200209192352.g8JNqqZ06542@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: robn@verdi.et.tudelft.nl, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: ext3 fs: no userspace writes == no disk writes ? 
In-Reply-To: Your message of "20 Sep 2002 00:25:59 BST."
             <1032477959.29068.12.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 20 Sep 2002 01:52:52 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

> On Fri, 2002-09-20 at 00:04, Andrew Morton wrote:
> > There are frequently written areas of an ext3 filesystem - the
> > journal, the superblock.  Those would wear out pretty quickly.
> 
> CF is -supposed- to wear level.

Yes I know.

But I haven't been able to find any specs from any CF manufacturer
about this mechanism, percentage of spare sectors or number of allowed
write-cycles in general.  Does it work by writing and than reading it
back and if it's different remapping the sector from a pool of spare
sectors ?

My guess is that it will work OK in a typical CF-in-a-camera situation:
after some thousands of photo's something gets remapped without the
user noticing.

But if you write every few seconds to the same block(s) (journal and/or
superblock, which I was/am afraid of happening with ext3 in my original
question) you'll run out of remap sectors and kill any CF reliably
within a couple of days.  Suppose there is a write to a certain sector
every 5 seconds and assume a 100000 allowed writecycles (I read this
number several times in several flashdocs, but not in any CF docs ..).
That results in a lifetime of 5.8 days for this particular sector.
Then it gets remapped.  How long you can get away with this depends on
how many "hot" sectors like this you have in your fs and how many spares
are available on your CF.  But in the (not so far away) end you *will* kill
your CF I think.

Now if there are NO kernel/ext3 "automatic" writes and your application
has the right behaviour (mine has I think) using ext3 on CF looks like
a nice, easy & stable solution in which killing your CF takes many years :-)

	greetings,
	Rob van Nieuwkerk

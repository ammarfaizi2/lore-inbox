Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUHZJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUHZJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 05:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268020AbUHZJXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 05:23:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:43684 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266626AbUHZJWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 05:22:10 -0400
Date: Thu, 26 Aug 2004 02:21:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: riel@redhat.com, mikulas@artax.karlin.mff.cuni.cz, torvalds@osdl.org,
       hch@lst.de, reiser@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826022137.1504ffb7.pj@sgi.com>
In-Reply-To: <412D968B.9030107@hist.no>
References: <Pine.LNX.4.44.0408252052420.13240-100000@chimarrao.boston.redhat.com>
	<412D968B.9030107@hist.no>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge wrote:
> So an old "tar" won't get this right as it will assume that an object
> is either file or directory.

There are many backup apps, not just one.  I've written a few myself,
none of which will ever be worthy of notice.  The sourceforge
Topic.System.Archiving.Backup lists 335 projects at present.

I find the idea that most backup tools and scripts will silently
stop working correctly to be pretty scary.  

And then there's archiving, installation, distribution, administration,
emulation, file system and partition managers, and on and on.

===

I wonder if we can make this "modal" somehow.

The one consistency I see is that apps that want the "enhanced" view
need to ask for it, somehow.  It is the new views of the data that are
being added - let the app announce to the kernel (usually via
specialized code in some shared library that the app is using to get the
alternate views) that either per-task, or per-file descriptor, it is to
see the "enhanced" view, as a side affect of trying to access it.

Old stuff, or even new stuff that is content to work with the "classic"
view that a file is a single data stream, and that directories only
have pathnames, not data, would by default see that view, and see
_all_ the data, presented somehow in that view, perhaps as additional
files with magic names.

This still leaves the breakage that such tools don't know, and don't
preserve, the magic linkage between such magic files.  But that is
much less of an issue, in my view.  Programs such as backups that are
manipulating the files of apps they know nothing about already have
to presume that all the files are important in inscrutable ways, and
just be careful to preserve or copy or backup all of them.

Yeah - I realize that there will be a few followups denouncing modal
architectures.  I might even agree with some of them.

If this were easy, it would have been done years ago.

The onus should be on the new stuff to request the enhanced view,
rather than on the old dogs to learn new tricks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

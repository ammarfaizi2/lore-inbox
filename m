Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTJJSFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTJJSF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:05:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:62170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263073AbTJJSFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:05:25 -0400
Date: Fri, 10 Oct 2003 11:05:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Jamie Lokier <jamie@shareable.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <16262.62026.603149.157026@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0310101059330.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Trond Myklebust wrote:
>
> Apart from O_DIRECT, we have nothing in the kernel as it stands that
> will allow userland to deal with this case.

Oh, but that's just another case of the general notion of allowing people 
to control the page cache a bit more. 

There's nothing wrong with having kernel interfaces that say "this region
is potentially stale" or "this region is dirty" or "this region is not
needed any more".

For example, using DIRECT_IO to make sure that something is uptodate is
just _stupid_, because clearly it only matters to shared-disk (either over
networks/FC or though things like SCSI device sharing) setups. So now the 
app has to have a way to query for whether the storage is shared, and 
have two totally different code-paths depending on the answer. 

This is another example of a bad design, that ends up causing more
problems (remember why this thread started in the first place: bad design
of O_DIRECT causing the app to have to care about something _else_ it
shouldn't care about. At all).

If you had a "this region is stale" thing, you'd just use it. And if it 
was local disk, it wouldn't do anything. 

		Linus


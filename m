Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUEKMRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUEKMRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKMRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:17:14 -0400
Received: from CPE0000c02944d6-CM00003965a061.cpe.net.cable.rogers.com ([69.193.74.215]:32672
	"EHLO tentacle.dhs.org") by vger.kernel.org with ESMTP
	id S263227AbUEKMRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:17:10 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: John McCutchan <ttb@tentacle.dhs.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: nautilus-list@gnome.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040511024701.GA19489@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <20040511024701.GA19489@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084278001.1225.9.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 08:20:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-10 at 22:47, Chris Wedgwood wrote:
> On Mon, May 10, 2004 at 06:17:40PM -0400, John McCutchan wrote:
> 
> > According to everyone who uses dnotify it is.
> 
> I don't buy that.  I have used dnotify and signals where not an issue.
> Why is this an issue for others?
> 

Signals cause a big performance penalty when you are receiving a lot of
them. Signals interrupt your program, switch the signal handler and then
restarts your program. And signals in multi-threaded programs is a pain
as well. Signals just are not suitable for receiving lots of messages
quickly.

> > > 3) dnotify cannot easily watch changes for a directory hierarchy
> 
> > People don't seem to really care about this one. Alexander Larsson
> > has said he doesn't care about it. It might be nice to add in the
> > future.
> 
> I don't know who that is and why it matters.
> 
> Without being able to watch a hierarchy, I'm not sure inotify buys
> anything that we can't get from dnotify right now though.  It's also
> more complex.

Inotify will support watching a hierarchy. The reason it was not
implemented yet is because the one app that I really care about is
nautilus and the maintainer of it says he doesn't care. 

The big feature that inotify is trying to provide is not having to keep
a file open (So that unmounting is not affected). I asked for some
guidance from people more familiar with the kernel so that I can
implement this feature, it requires changes made to the inode cache, and
how unmounting is done.

> 
> > The idea is to encourage use of a user-space daemon that will
> > multiplex all requests, so if 5 people want to watch /somedir the
> > daemon will only use one watcher in the kernel. The number might be
> > too low, but its easily upped.
> 
> If you are to use a daemon for this, why no use dnotify?

Because of the problems that dnotify has, as well if people would prefer
to just use a direct interface, those #defines can be upped. Its very
easy to play with the limits on the number of watchers. I am not sure
what kind of impact this will have on the kernel resources, so I wanted
to keep it small.

John

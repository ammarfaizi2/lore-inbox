Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264779AbUEKPC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbUEKPC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUEKPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:02:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264779AbUEKPC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:02:26 -0400
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
From: Alexander Larsson <alexl@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Nautilus <nautilus-list@gnome.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040511024701.GA19489@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex>
	 <20040510021141.GA10760@taniwha.stupidest.org>
	 <1084227460.28663.8.camel@vertex>
	 <20040511024701.GA19489@taniwha.stupidest.org>
Content-Type: text/plain
Message-Id: <1084287762.19104.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 11 May 2004 17:02:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 04:47, Chris Wedgwood wrote:
> On Mon, May 10, 2004 at 06:17:40PM -0400, John McCutchan wrote:
> 
> > According to everyone who uses dnotify it is.
> 
> I don't buy that.  I have used dnotify and signals where not an issue.
> Why is this an issue for others?

Its the single thing which forces users of dnotify to have an otherwise
useless daemon. Signals are process global resources. As such, a library
can't allocate them, so dnotify can't be used in a library.

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

Hierarchical watches are not important to Nautilus, and the lack of them
has not generally been a problem for Gnome. Furthermore, they are
basically impossible to implement in a way that is sane wrt resource
management in the kernel. Unlimited queues in the kernel is an instant
DOS, and if the queue can overflow there is bascially no way to handle
that correctly from userspace without keeping the entire subtree in
memory (and even that breaks in the presence of aliases).

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                            Red Hat, Inc 
                   alexl@redhat.com    alla@lysator.liu.se 
He's a gun-slinging pirate gangster on the hunt for the last specimen of a 
great and near-mythical creature. She's a manipulative winged Hell's Angel who 
can talk to animals. They fight crime! 


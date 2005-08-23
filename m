Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVHWTqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVHWTqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVHWTqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:46:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2578 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932339AbVHWTqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:46:02 -0400
Date: Tue, 23 Aug 2005 21:45:57 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: Willy Tarreau <willy@w.ods.org>, bert hubert <bert.hubert@netherlabs.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: select() efficiency / epoll
Message-ID: <20050823194557.GC10110@alpha.home.local>
References: <42E162B6.2000602@davyandbeth.com> <20050722212454.GB18988@outpost.ds9a.nl> <430AF11A.5000303@davyandbeth.com> <20050823182405.GA21301@outpost.ds9a.nl> <430B01FB.2070903@davyandbeth.com> <20050823191254.GB10110@alpha.home.local> <430B077A.10700@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430B077A.10700@davyandbeth.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 06:24:42AM -0500, Davy Durham wrote:
> That's probably a good idea.  Where would I find out what other projects 
> use it?

I use it in my load-balancer (haproxy), and it could somewhat match your
needs, because I ported the select()-based earlier version to epoll() with
the smallest possible changes. Indeed, the new epoll() loop still uses the
FD_ISSET() to determine what to do with epoll_ctl(). If you have changed
your code to use select(), you may find similarities. But I want to tell
you from now that my code is NOT multi-threaded. It could be a bug in the
epoll implementation, because I don't think that there are so many
applications using epoll on MT models. Bert says that the epoll implementation
is heavily benchmarked, which is true, but which does not guarantee that it
is tested under every condition.

You can download it from there :

  http://w.ods.org/tools/haproxy/src/devel/

Use version 1.2.6. I added epoll in 1.2.5, so the diff between 1.2.4 and
1.2.5 could help you too.

Good luck !
Willy


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbSKSFz0>; Tue, 19 Nov 2002 00:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbSKSFz0>; Tue, 19 Nov 2002 00:55:26 -0500
Received: from mark.mielke.cc ([216.209.85.42]:39696 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267097AbSKSFz0>;
	Tue, 19 Nov 2002 00:55:26 -0500
Date: Tue, 19 Nov 2002 01:09:41 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Edgar Toernig <froese@gmx.de>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119060941.GB17927@mark.mielke.cc>
References: <Pine.LNX.4.44.0211182000590.979-100000@blue1.dev.mcafeelabs.com> <3DD9CDB2.2075CCB4@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD9CDB2.2075CCB4@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 06:35:46AM +0100, Edgar Toernig wrote:
> Davide Libenzi wrote:
> > > What happens if the epollfd is put into its own fd set?
> > You might find your machine a little bit frozen :)
> > Either 1) I remove the read lock from poll() or 2) I check the condition
> > at insetion time to avoid it. I very much prefer 2)
> Hehe, sure.  But could become tricky: someone may build a circular chain
> of epoll-fd-sets.

This could be an indication that epoll of an epoll fd should not be
allowed.  This kind of sucks as epoll event hierarchies appear, at
least on the surface, very natural, and better than poll()/epoll.

Another option would be to allow a reasonable depth (2? 3?). The extra
checking (depth calculation) only needs to be performed if a file is
added or removed where f_op == epoll_f_op.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


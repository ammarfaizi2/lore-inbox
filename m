Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUBMCBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266658AbUBMCBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:01:42 -0500
Received: from mail.shareable.org ([81.29.64.88]:20866 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266646AbUBMCBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:01:40 -0500
Date: Fri, 13 Feb 2004 02:01:13 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Tim Hockin <thockin@sun.com>
Cc: Jim Houston <jim.houston@ccur.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040213020113.GD25499@mail.shareable.org>
References: <20040211222849.GL9155@sun.com> <20040211144844.0e4a2888.akpm@osdl.org> <20040211233852.GN9155@sun.com> <20040211155754.5068332c.akpm@osdl.org> <20040212003840.GO9155@sun.com> <20040211164233.5f233595.akpm@osdl.org> <20040212010822.GP9155@sun.com> <20040211172046.37e18a2f.akpm@osdl.org> <1076606773.990.165.camel@new.localdomain> <20040212184903.GS9155@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212184903.GS9155@sun.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> > The rational for avoiding immediate reuse of id values is to catch
> > application errors.   Consider:
> > 
> > 	fd1 = open_like_call(...);
> > 	read(fd1,...);
> > 	close(fd1);
> > 	fd2 = open_like_call(...);
> > 	write(fd1...);
> > 
> > If fd2 has a different value than the recently closed fd1, the
> > error is detected immediately.
> 
> Is that really worth working around in such a gross way?  No offense to the
> idea, but that's a pretty dumb bug to be hacking a failsafe for :)

I'm pretty sure POSIX requires fd2 to be equal to fd1 if it is the
lowest free file descriptor number.

Unfortunately.  An O(1) fd allocation algorithm would be nice.

-- Jamie

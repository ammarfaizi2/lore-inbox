Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUBTNTz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUBTNMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:12:53 -0500
Received: from mail.shareable.org ([81.29.64.88]:48000 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261221AbUBTMyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:54:24 -0500
Date: Fri, 20 Feb 2004 12:54:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Junio C Hamano <junkio@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Tridge <tridge@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
Message-ID: <20040220125410.GA8994@mail.shareable.org>
References: <20040220000054.GA5590@mail.shareable.org> <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <7vznbeleam.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vznbeleam.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> JL> The other thing I like is that DN_IGNORE_SELF would be useful for
> JL> other applications too.
> 
> While I agree in principle that DN_IGNORE_SELF would be quite an
> effective and clean way to solve the Samba problem and also
> applicable to other situations,

> I also imagine that the value of DN_IGNORE_SELF would be greatly
> affected by how the "self" is defined.  A server implementation may
> be multithreaded, and you may or may not want to count all your
> threads in that server process as self; another may be implemented
> as one master process spawning multiple worker bee processes, in
> which case it would be more convenient if all the processes in one
> process group is counted as self.

Yes, indeed this is an issue.  A multi-threaded program I'm working on
would want each thread to count separately - because the threads don't
know much about each other.  Samba is more likely to want all threads
treated as a single unit.

Even in a program like Samba, you can imagine a plugin architecture or
something where 3rd party add-ons spawn threads, and those 3rd party
threads want to monitor a directory they are using, independent of the
main Samba threads.

-- Jamie


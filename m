Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSKJDpP>; Sat, 9 Nov 2002 22:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSKJDpP>; Sat, 9 Nov 2002 22:45:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31816 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263589AbSKJDpN>; Sat, 9 Nov 2002 22:45:13 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
	<m1u1iqcpjg.fsf@frodo.biederman.org>
	<20021109223142.A31205@almesberger.net>
	<m17kfmce6c.fsf@frodo.biederman.org>
	<20021110003027.C31205@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 20:49:15 -0700
In-Reply-To: <20021110003027.C31205@almesberger.net>
Message-ID: <m1vg36axtw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > What I was thinking is that the process would for and exec
> > something like "/etc/rc 6" or maybe "/etc/rc 7" to be clean.
> > And that script would do all of the user space shutdown.
> 
> Yes, but init also does a kill(-1,...) to get rid of all processes,
> before the last steps of system shutdown. So you have to somehow
> make your "page holding" process survive beyond this point.

True.  But it is just as easy to drop the file into something like
ramfs.  Or a file on the read only file on the root filesystem.  Now
that we can having shutdown do a pivot_root and totally unmounting
the root filesystem is probably a good idea.

> > My feel is that kexec-on-panic is a rather different problem.
> 
> You make it a different problem by assuming that you'd have a
> kernel that is specifically built for running at a "safe"
> location.  

Well at least the part cleans up after the running kernel.  That is
what I think it takes to make it stable.  Perhaps I am wrong, but
I think getting other architecture stable is very hard.

> If you assume that you're just using your normal
> kernel, the two problems converge again. There are still a
> few things that are different, like the checksumming, but
> they can safely be added at a later time.

I guess I can be proven wrong.

Eric

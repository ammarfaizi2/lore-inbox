Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbTCKSIH>; Tue, 11 Mar 2003 13:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbTCKSIH>; Tue, 11 Mar 2003 13:08:07 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6287 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261499AbTCKSIG>; Tue, 11 Mar 2003 13:08:06 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 Mar 2003 10:27:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Niels Provos <provos@citi.umich.edu>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030311142447.GA14931@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50.0303111023190.1855-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <20030311142447.GA14931@bjl1.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Jamie Lokier wrote:

> > LT epoll you simply use epoll_ctl(EPOLL_CTL_MOD) to switch between
> > EPOLLIN and EPOLLOUT.
>
> ?? Is this poorly worded?  EPOLLIN and EPOLLOUT are independent events,
> aren't they?

Yes, they're. But since ET epoll has the edge feature that filter events,
you can safely register both events and insertion time *if you want*.


> > In front of this considerations we
> > have three options that I can think :
> >
> > 1) We leave epoll as is ( ET )
> > 2) We apply the patch that will make epoll LT
> > 3) We add a parameter to epoll_create() to fix the interface behaviour at
> > 	creation time ( small change on the current patch )
>
> Is it not better to (4) select the behaviour when an fd interest is
> registered?  I think this is cleanest, if the code is not too
> horrible.

The code does not change much ( I think about 10 lines of code :) ), and
I'm for this option. That has also the other advantage to not change the
API parameters. Obviously man pages will have to be reviewed, but this is
another story :)



- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWDGUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWDGUGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:06:52 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:42624 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932431AbWDGUGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:06:51 -0400
Date: Fri, 7 Apr 2006 22:06:45 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: edwin@gurde.com
cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
In-Reply-To: <42865.86.125.51.175.1144436283.squirrel@www.gurde.com>
Message-ID: <Pine.LNX.4.58.0604072149110.2496@be1.lrz>
References: <5X7nH-7n6-7@gated-at.bofh.it> <E1FRTVC-0000i5-PH@be1.lrz>
 <42865.86.125.51.175.1144436283.squirrel@www.gurde.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2006 edwin@gurde.com wrote:

> > I'd deliberately allow access to these sockets if it's passed to other
> > applications since it's the intended behaviour.

> It might be intended behaviour, or it might be a file descriptor leak.
> If I have a rule in iptables saying to allow only apache (just an example)
> access to port 80, I don't want any other program to have access to it.
> If apache might leak a file descriptor (it doesn't, just an example), and
> give access to other programs, the firewall would restrict those programs.
> If I would implicitly trust them, then fireflier rules wouldn't be any
> better, than just creating rules to allow any program to listen on port
> 80.

If apache is running a CGI script, it must pass the socket (bound to 
remote:port,local:80, to the CGI at fd 2*. If your firewall is blocking
this, your CGI scripts will stop working.

* unless it intends to proxy the connection

> > (BTW: Your approach isn't
> > going to be 100 % reliable, since it will allow other processes to
> > illegaly
> > receive data if the socket is transfered after filtering, isn't it?)
> filtering is done on each packet, how could the socket be transfered
> between the time the packet is filtered, and the time it is received by
> the program?
> A socket transfer can be done via execve, or IPC, both covered (I hope) by
> the fireflier lsm.
> >
> > Downside of both approaches:
> >  You'll have to guarantee stable dev:inode pairs.
> This could be ensured from userspace, if it becomes an issue.
> > NFS?

> running a program via NFS, and giving access for it to the network? why
> would I want that?

Why not? E.g. you could set up a farm of redundand apache servers.

> Anyway, if somebody wants that, we could determine the inode of the
> program on nfs mount time. We could store the path+hash of the program to
> be sure it is the same program.

> >umount/mount?
> Aren't inodes stored on the disk?

At least Mostly, but is this a requirement?
-- 
Fun things to slip into your budget
True and it was approved:  128 MBytes of VIRTUAL memory.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTGAMBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 08:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTGAMBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 08:01:36 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:34800 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262202AbTGAMBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 08:01:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Fredrik Tolf <fredrik@dolda2000.cjb.net>
Subject: Re: PTY DOS vulnerability?
Date: Tue, 1 Jul 2003 07:15:30 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200306301613.11711.fredrik@dolda2000.cjb.net> <200306302331.38071.fredrik@dolda2000.cjb.net> <1057008994.17589.40.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057008994.17589.40.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <03070107153001.01125@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 16:36, Alan Cox wrote:
> On Llu, 2003-06-30 at 22:31, Fredrik Tolf wrote:
> > That is true, though, of course. Stupid me not to think about
> > that. However, that means that an administrator who could find
> > himself being under such an attack might not think about it
> > either. Also, from the outside, the ssh client just does
> > nothing, making it look as if the server is unresponsive. Of
> > course, the exact error is logged to the server's syslog, but if
> > you can't view it, then you won't know about it.
> >
> > So all in all, do you think I should implement a per-user
> > resource limit on PTYs?
>
> There are a whole collection of things that would benefit from that kind
> of management - go for it but make it possible to add other stuff too

In thinking about that...

I would suggest a "resource allocation daemon", where resource is defined
to be non-kernel objects - devices mostly... ptys /dev/tape unmounted disks
removable media, specific files (not sure how to explain this one though, but
controlling access to specified fifo's, memory mapped files? how about 
printer queues...)

Anything that gets defined as a system wide resource that users may access, 
but exist as external (to the kernel) objects. It would need some kind of 
kernel interface, but the access control would be defined outside the kernel.

The most the kernel would need is a "resource controlled by" and "resource 
allocated to" identification so that the appropriate daemon could be invoked
(I do see a possibility for multiple resource allocation daemons).

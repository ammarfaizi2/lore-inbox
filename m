Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUADTUe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUADTUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:20:30 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:35463 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261875AbUADTU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:20:29 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Jan 2004 11:20:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       <lse-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <200401042002.03684.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.44.0401041112290.12250-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004, Ingo Oeser wrote:

> > The impression I had was that the code is quite complicated and
> > invasive, and select/poll aren't considered worth optimising because
> > epoll is an overall better solution (which is true; optimising
> > select/poll would change the complexity of the slow part but not
> > reduce the complexity of the API part, while epoll does both).
> 
> This is true. But old software continues to exist and for INN there is
> pretty much nothing else in this category available, I've been told by
> several admins. Nobody really likes it, but it is used and improved
> where necessary (epoll might be on the list already).

The problem with poll/select is not the Linux implementation. It is the 
API that is flawed when applied to large fd sets. Every call pass to the 
system the whole fd set, and this makes the API O(N) by definition. While 
poll/select are perfectly ok for small fd sets, epoll LT might enable the 
application to migrate from poll/select to epoll pretty quickly (if the 
application architecture is fairly sane). For example, it took about 15 
minutes to me to make an epoll'd thttpd.




- Davide



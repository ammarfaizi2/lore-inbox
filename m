Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbUDBPWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbUDBPWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:22:36 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:32916 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264072AbUDBPWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:22:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 2 Apr 2004 07:22:31 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben Mansell <ben@zeus.com>
cc: Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll reporting events when it hasn't been asked to
In-Reply-To: <Pine.LNX.4.58.0404020950560.3066@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Ben Mansell wrote:

> > If an exception occurs (example a socket is disconnected) the socket
> > should be removed from the fd list.  There is really no point in passing
> > in an excepted fd.
> 
> Is there any difference, speed-wise, between turning off all events to
> listen to with EPOLL_MOD, and removing the file descriptor with
> EPOLL_DEL? I had vaguely assumed that the former would be faster
> (especially if you might later want to resume listening for events),
> although that was just a guess.

It is faster. OTOH nothing prevent you to use your current method. You 
have only to handle exceptional condition instead of ignoring them. 
Handling by, for example, removing the fd from the epoll set and 
unregistering/freeing the associated data structures. IMO we can leave the 
current behaviour, but if someone sees huge problems with this, the fix is 
a one-liner.



- Davide



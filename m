Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUDDTk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 15:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUDDTk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 15:40:59 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:5781 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262648AbUDDTk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 15:40:58 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Apr 2004 12:41:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ben Mansell <ben@zeus.com>
cc: Jamie Lokier <jamie@shareable.org>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll
 reporting events when it hasn't been asked to)
In-Reply-To: <Pine.LNX.4.58.0404041912460.5216@stones.cam.zeus.com>
Message-ID: <Pine.LNX.4.44.0404041236460.14764-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004, Ben Mansell wrote:

> With epoll, adding a fd into the epoll set is a separate operation from
> the epoll_wait(), so if you really don't want to listen for any events
> on one FD, you'll have to do a EPOLL_DEL, and then later on do a
> EPOLL_ADD again if you want to bring it back in. Which is a bit nasty
> and inefficient.

I really fail to see how handling POLLHUP and POLLERR would be a problem, 
even for fds where you specified a 0 event mask. If you receive them, you 
remove the fd from the set, and you flag the associated data structure for 
a lazy removal at the end of the current event loop. Where is the problem 
here?



- Davide



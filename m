Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265301AbSJXDRd>; Wed, 23 Oct 2002 23:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265302AbSJXDRd>; Wed, 23 Oct 2002 23:17:33 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22656 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265301AbSJXDRb>; Wed, 23 Oct 2002 23:17:31 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 20:32:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] sys_epoll ( 0.8 ) ...
Message-ID: <Pine.LNX.4.44.0210232017290.1022-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The updated version ( 0.8 ) of the sys_epoll patch is available here :

http://www.xmailserver.org/linux-patches/nio-improve.html#patches

Changes :

*) Suggestions/bug-fixes from Andrew

*) More robust interface from bad user parameters

*) The shared memory area for events is now seen with PROT_READ from the
	user. Users of the old /dev/epoll interface will have to mmap() it
	using PROT_READ if they don't want to receive an EACCES

To be decieded :

*) Adding an "int minevents" parameter to sys_epoll_wait() to let the
	caller to specify the minimum number of events that he'll expect
	returned by the wait call in the given timeout

*) Making sys_epoll_wait() to return a new event structure :

	struct sys_epoll_event {
		int fd;
		unsigned int revents;
		void *priv;
	};

	to be able to let the caller to specify his own private data. This
	will avoid applications to perform lookups using the fd and will
	also better optimize the returned data by removing the unused
	"events" field




- Davide



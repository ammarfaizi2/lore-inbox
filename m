Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSKYW14>; Mon, 25 Nov 2002 17:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbSKYW14>; Mon, 25 Nov 2002 17:27:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:18057 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265767AbSKYW1z>; Mon, 25 Nov 2002 17:27:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Nov 2002 14:36:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Myers <jgmyers@netscape.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] new poll callback'd wake up hell ...
In-Reply-To: <3DE29EB9.9050301@netscape.com>
Message-ID: <Pine.LNX.4.50.0211251433200.1793-100000@blue1.dev.mcafeelabs.com>
References: <3DE29EB9.9050301@netscape.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, John Myers wrote:

> Davide Libenzi writes:
>  > 1) Move the wake_up() call done inside the poll callback outside the lock
>
> You can't.  You need to hold the lock over the callback or your callback
> could end up accessing a freed epitem.

No, look at the code :

http://www.xmailserver.org/linux-patches/sys_epoll-2.5.49-0.58.diff

The function ep_collect_ready_items() increases the usage count under
lock. So the epintem is protected, and the file* cannot desappear because
of the read lock on epsem.



- Davide


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRFMI4W>; Wed, 13 Jun 2001 04:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbRFMI4L>; Wed, 13 Jun 2001 04:56:11 -0400
Received: from ns.suse.de ([213.95.15.193]:6920 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261651AbRFMIz5>;
	Wed, 13 Jun 2001 04:55:57 -0400
To: <eg_nth@sinocdn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CLOSE_WAIT bug?
In-Reply-To: <Pine.LNX.4.21.0106130037330.10007-200000@sinocdn.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jun 2001 10:55:47 +0200
In-Reply-To: <eg_nth@sinocdn.com>'s message of "12 Jun 2001 19:26:27 +0200"
Message-ID: <oupwv6glpws.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<eg_nth@sinocdn.com> writes:

> Hi all,
> 
> I suppect that there is bug in both kernel 2.2.19 and 2.4.5.
> The situation is as follow.
> 
> One server socket created and listening, blocking on select(),
> once a client connect to that port, there is another thread in server
> side issues a close() to the new connection. 
> After the client close the connection. The connection in server side will
> stuck on CLOSE_WAIT forever until the program being killed.

It is a known problem that unfortunately cannot be easily fixed with the current VFS. 
select has a reference to the file handle and it keeps it open until the select ends.
Do a shutdown() in the thread before the close, then the select should wake up.

-Andi

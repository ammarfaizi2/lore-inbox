Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264775AbSJOWNk>; Tue, 15 Oct 2002 18:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbSJOWNk>; Tue, 15 Oct 2002 18:13:40 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:12692 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264775AbSJOWNL>; Tue, 15 Oct 2002 18:13:11 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Oct 2002 15:27:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
In-Reply-To: <3DAC9035.2010208@netscape.com>
Message-ID: <Pine.LNX.4.44.0210151521090.1554-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, John Gardiner Myers wrote:

> Davide Libenzi wrote:
>
> >Why would you need to use threads with a multiplex-like interface like
> >/dev/epoll ?
> >
> Because in some applications processing an event can cause the thread to
> block, potentially for a long time.  Multiple threads are needed to
> isolate that block to the context associated with the event.

I don't want this to become the latest pro/against threads but if your
processing thread block for a long time you should consider handling the
blocking condition asynchronously. If your procesing thread blocks, your
application model should very likely be redesigned, or you just go with
threads ( and you do not need any multiplex interface ).



> >	while (read() == EGAIN)
> >		wait(POLLIN);
> >
> >
> Assuming registration of interest is inside wait(), this has a race.  If
> the file becomes readable between the time that read() returns and the
> time that wait() can register interest, the connection will hang.

Your assumption is wrong, the registration is done as soon as the fd
"born" ( socket() or accept() for example ) and is typically removed when
it dies.



- Davide



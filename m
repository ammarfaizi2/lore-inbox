Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265345AbSJRTiT>; Fri, 18 Oct 2002 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265347AbSJRTiS>; Fri, 18 Oct 2002 15:38:18 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:17803 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265345AbSJRTiQ>; Fri, 18 Oct 2002 15:38:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Oct 2002 12:52:39 -0700 (PDT)
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
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DB05AB2.3010907@netscape.com>
Message-ID: <Pine.LNX.4.44.0210181241300.1537-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, John Gardiner Myers wrote:

> Your claim was that even if the API will drop an event at registration
> time, my code scheme would not work.  Thus, we can take "the API will
> drop an event at registration time" as postulated.  That being
> postulated, if there is still data to be read/written on the file
> descriptor then the first event_wait will return immediately.
>
> In fact, given that postulate and the appropriate axioms about the
> behavior of event_wait() and do_io(), one can prove that my code scheme
> is equivalent to yours.  The logical conclusion from that and your claim
> would be that you don't understand how edge triggered APIs have to be used.

No, the concept of edge triggered APIs is that you have to use the fd
until EAGAIN. It's a very simple concept. That means that after a
connect()/accept() you have to start using the fd because I/O space might
be available for read()/write(). Dropping an event is an attempt of using
the API like poll() & Co., where after an fd born, it is put inside the
set to be later wake up. You're basically saying "the kernel should drop an
event at creation time" and I'm saying that, to keep the API usage
consistent to "use the fd until EAGAIN", you have to use the fd as soon as
it'll become available.



> >The reason you're asking /dev/epoll to drop an event at
> >fd insertion time shows very clearly that you're going to use the API is
> >the WRONG way and that you do not understand how such APIs works.
> >
> The wrong way as defined by what?  Having /dev/epoll drop appropriate
> events at registration time permits a useful simplification/optimization
> and makes the system significantly less prone to subtle progamming errors.
>
> I do understand how such APIs work, to the extent that I am pointing out
> a flaw in their current models.

I'm sorry but why do you want to sell your mistakes for API flaws ?



- Davide



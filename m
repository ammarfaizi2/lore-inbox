Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbTCKSAy>; Tue, 11 Mar 2003 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbTCKSAx>; Tue, 11 Mar 2003 13:00:53 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:911 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261541AbTCKSAw>; Tue, 11 Mar 2003 13:00:52 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 Mar 2003 10:20:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Niels Provos <provos@citi.umich.edu>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030311093427.GA19658@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.50.0303111015370.1855-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <20030311093427.GA19658@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, bert hubert wrote:

> On Mon, Mar 10, 2003 at 12:15:25PM -0800, Davide Libenzi wrote:
>
> > 2) Existing apps using poll/select can easily be ported usinf LT epoll
>
> This is a big thing. I created a webserver based on MTasker
> (ds9a.nl/mtasker) that used select, poll or epoll and it was very hard to
> abstract this properly as level and edge semantics differ so wildly.
>
> Most programs will not abandon 'legacy' interfaces like poll and select and
> will only want to offer epoll in addition. Right now that is hard to do.

I agree here. It took 15 minutes to port thttpd to LT epoll.



> > 1) We leave epoll as is ( ET )
> > 2) We apply the patch that will make epoll LT
> > 3) We add a parameter to epoll_create() to fix the interface behaviour at
> > 	creation time ( small change on the current patch )
> >
> > With 2) and 3) there are also man pages to be reviewed to be posted to
> > Andries. Comments ?
>
> I'd vote for 2.

I received a bunch of private emails ( ppl that are using ET epoll )
asking me to have both behaviours. The code require no more than 10 lines
of code to give both possibilities. We have two options in doing that :

1)
We add a parameter to epoll_create() that will set the interface behaviour
at creation time :

	#define EPOLL_ET (1 << 0)

	int epoll_create(int size, int flags);

2)
We can go at fd granularity by leaving the API the same, and we define :

	#define EPOLLET (1 << 31)

	...
	events = EPOLLIN | EPOLLET;


What do you think ?




- Davide


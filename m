Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbTCLQ6F>; Wed, 12 Mar 2003 11:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbTCLQ6E>; Wed, 12 Mar 2003 11:58:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:9384 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261773AbTCLQ6C>; Wed, 12 Mar 2003 11:58:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 Mar 2003 09:17:57 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030312120539.GA25626@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.50.0303120910020.2050-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <20030311093427.GA19658@outpost.ds9a.nl> <Pine.LNX.4.50.0303111015370.1855-100000@blue1.dev.mcafeelabs.com>
 <20030312120539.GA25626@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, bert hubert wrote:

> On Tue, Mar 11, 2003 at 10:20:38AM -0800, Davide Libenzi wrote:
>
> > > Most programs will not abandon 'legacy' interfaces like poll and select and
> > > will only want to offer epoll in addition. Right now that is hard to do.
> >
> > I agree here. It took 15 minutes to port thttpd to LT epoll.
>
> Having level ability will massively speed up epoll adoption. By the way, was
> there a reason to go to edge in the first place?

Well, the first version of /dev/epoll was truly ET and it wasn't using
poll kernel hooks. With the usage of poll hook it became more affordable
to consider to have both ET and LT behaviours. ET would be my pick if I
have to start a new application from scratch anyway.



> > We add a parameter to epoll_create() that will set the interface behaviour
> > at creation time :
> ...
> > We can go at fd granularity by leaving the API the same, and we define :
> > 	#define EPOLLET (1 << 31)
>
> This last option would retain the current ABI *and* semantics for unchanged
> programs. I do wonder if there is a case where you'd want to run in mixed
> mode, however. But if the code to support mixed operation is truly trivial,
> I think we should not set policy from the kernel ('only do epoll in one
> mode') and leave it up to userspace to discover if there is a use for this.
>
> Anyhow, as a member of the kCowSay [1] association of userspace people
> meddling in the affairs of kernel coders, I vote strongly for having level
> triggered epoll on the kernel, with the ability to do mixed mode.

The patch I posted yesterday does the per-fd selectable ET/LT behaviour.
It ran fine on UP and 2SMP tonight, so I'm going to ping Linus for a merge
later today.




- Davide


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284147AbRLFRSF>; Thu, 6 Dec 2001 12:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLFRRz>; Thu, 6 Dec 2001 12:17:55 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:57349 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284147AbRLFRRm>; Thu, 6 Dec 2001 12:17:42 -0500
Date: Thu, 6 Dec 2001 09:28:45 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>, <lm@bitmover.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: SMP/cc Cluster description
In-Reply-To: <Pine.LNX.4.33L.0112061223520.1282-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.40.0112060922060.1603-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Rik van Riel wrote:

> On Wed, 5 Dec 2001, Davide Libenzi wrote:
> > On Thu, 6 Dec 2001, Rusty Russell wrote:
> >
> > > I'd love to say that I can solve this with RCU, but it's vastly non-trivial
> > > and I haven't got code, so I'm not going to say that. 8)
> >
> > Lockless algos could help if we're able to have "good" quiescent point
> > inside the kernel. Or better have a good quiescent infrastructure to
> > have lockless code to plug in.
>
> Machines get dragged down by _uncontended_ locks, simply
> due to cache line ping-pong effects.

Rik, i think you're confused about lockless algos.
It's not an rwlock where the reader has to dirty a cacheline in any case,
the reader simply does _not_ write any cache line accessing the
list/hash/tree or whatever you use.
These algo uses barries and all changes are done when the system walk
through a quiescent state by flushing a list-of-changes.
Drawback, you've to be able to tollerate stale data.



- Davide



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278244AbRJMC0D>; Fri, 12 Oct 2001 22:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278245AbRJMCZx>; Fri, 12 Oct 2001 22:25:53 -0400
Received: from [208.129.208.52] ([208.129.208.52]:35345 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278244AbRJMCZg>;
	Fri, 12 Oct 2001 22:25:36 -0400
Date: Fri, 12 Oct 2001 19:31:42 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.33.0110121903031.8148-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0110121921240.1505-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Linus Torvalds wrote:

>
> On Fri, 12 Oct 2001, Davide Libenzi wrote:
> >
> > The problem is that even if cpu1 schedule the load of  p  before the
> > load of  *p  and cpu2 does  a = 1; wmb(); p = &a; , it could happen that
> > even if from cpu2 the invalidation stream exit in order, cpu1 could see
> > the value of  p  before the value of  *p  due a reordering done by the
> > cache controller delivering the stream to cpu1.
>
> Umm - if that happens, your cache controller isn't honouring the wmb(),
> and you have problems quite regardless of any load ordering on _any_ CPU.
>
> Ehh?

I'm searching the hp-parisc doc about it but it seems that even Paul
McKenney pointed out this.
Suppose that  p  and  *p  are on two different cache partitions and the
invalidation order that comes from the wmb() cpu is 1) *p  2) p
Suppose that the partition when  *p  lies is damn busy and the one where
p  lies is free.
The reader cpu could pickup the value of  p  before the value of  *p  by
reading the old value of  a
The barrier on the reader side should establish a checkpoint that enforce
the commit of  *p  before  p





- Davide



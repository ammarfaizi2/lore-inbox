Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130999AbQLHWuU>; Fri, 8 Dec 2000 17:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbQLHWuJ>; Fri, 8 Dec 2000 17:50:09 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:31466 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130999AbQLHWt7>; Fri, 8 Dec 2000 17:49:59 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, ch.rohland@gmx.net
Subject: Re: [PATCH,preliminary] cleanup shm handling
In-Reply-To: <Pine.LNX.4.10.10012081023170.11302-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10012081023170.11302-100000@penguin.transmeta.com>
Message-ID: <m3snnyo92i.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 08 Dec 2000 23:21:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds <torvalds@transmeta.com> writes:
> On 8 Dec 2000, Christoph Rohland wrote:
> > 
> > here is my first shot for cleaning up the shm handling. It did
> > survive some basic testing but is not ready for inclusion.
> 
> The only comment I have right now is that you probably should not
> mark the page dirty in "nopage" - theoretically somebody might have
> a sparse mapping and depend on zero pages for the ones that aren't
> touched. It's better to delay the dirty marking until swapout() (and
> write(), when that is implemented), so that we don't needlessly
> create swap entries for zero pages.

OK. I simply copied that from shm.c without thinking. Actually I do
not yet understand the implications of it. (I never thought that I
would get so deeply involved into these issues and still struggle
often with the details)

> Other than that the approach at least looks reasonable. And cleaner
> than what we currently have.

Only reasonable? :-(

It's what I always thought would be the Right Thing (TM):

1) The mm layer should have the abilty to handle shared anonymous
   pages
2) To access this we should use the 'everything is a file' mantra
   which means shm fs
3) sysv shm should only care about handling shm ids (and it special
   attributes which unfortunately makes shm_vm_operations necessary.)

So how would you improve it conceptually? And where are the
implementation flaws?

And compared to all the ipc/shm.c hacks we had so far it looks for me
beautiful. (And to make this clear: The main part is not my work. I
simply gathered the work of others to make this possible)

        Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

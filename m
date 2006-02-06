Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWBFUlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWBFUlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWBFUlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:41:03 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27559 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964809AbWBFUlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:41:00 -0500
Message-ID: <43E7B452.2080706@watson.ibm.com>
Date: Mon, 06 Feb 2006 15:40:50 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> There have been several discussions in the past month about how
> to do a good job of implementing a subset of user space that
> looks like it has the system to itself.  Essentially making
> chroot everything it could be.  This is my take on what
> the implementation of a pid namespace should look like.
> 

Eric, this looks very good. The pspace internal implementation
is very similar to what I was working on objectifying the pidmap
etc. I was pursuing the same route in using find_pid()
functions as the means to distinguish pspaces rather then
actually virtualizing them.

But this code already goes so much further in many many aspects.
Kudos to you.
I am still going through some of the details, but this is an
excellent starting position.

> 
> What follows is a real patch set that is sufficiently complete
> to be used and useful in it's own right.  There are a few areas
> of the kernel where the patchset does not reach, mostly these
> cause the compile to fail.  In addition a good thorough review
> still needs to be done.  This patchset does paint a picture
> of how I think things should look.
> 
> From the kernel community at large I am asking:
>   Does the code look generally sane?

Yes, but I have one question for you...
Large parts of the patch are adding the pspace argument
to find_task_by_pid() and in many cases that argument is
current->pspace.
It might bring down the size of the patch if you
have

find_task_by_pid( pid )  {  return find_task_pidspace_by_pid ( current->pspace, pid ); }

and then only deal with the exceptional cases using find_task_pidspace_by_pid
when the pidspace is different..

> 
>   Does the use of clone to create a new namespace instance look
>   like the sane approach?
> 

At he surface it looks OK .. how does this work in a multi-threaded
process which does cloen ( CLONE_NPSPACE ) ?
We discussed at some point that exec is the right place to do it,
but what I get is that because this is the container_init task
we are OK !
A bit clarification would help here ...

> Hopefully this code is sufficiently comprehensible to allow a good
> discussion to come out of this.
> 

Yes

> Thanks for your time,
> 
> Eric

-- Hubertus


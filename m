Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWBKLGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWBKLGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWBKLGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:06:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50116 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751401AbWBKLGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:06:20 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 04:03:43 -0700
In-Reply-To: <43ECF803.8080404@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Feb 2006 23:30:59 +0300")
Message-ID: <m1wtg2w41c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Actually I can't say your patch is cleaner somehow.
> It is very big and most of the changes are trivial, which creates an illusion
> that it is straightforward and clean.

It is hard to make a comparison.  Your patch posted to the mail list
was incomplete, and I could only find a giant patch for OpenVZ.

Beyond that if your patch introduced a type change for internal pids
and used that generate compile errors when someone did not use the
appropriate type, I would be a lot happier and the code would
be a lot more maintainable.  I.e. It would not take an audit of
the kernel source to find the issues an allyesconfig build would find
them for you.

I don't think my current implementation actually causes enough compile
errors, but I need think closely about it before I go much farther.

Maintainable code is a delicate balancing act between things that
trip you up when you get it wrong, and not being so cumbersome you
get in the programmers way.

The advantages I see with my approach.
- I have hierarchical pids so nesting is possible.
- The state after migration is not suboptimal.
- I cause compiler errors which makes maintenance easier.
- Other kernel developers gut feel is that (container, pid) is the proper
  representation.  
  I actually flip flop on the issue of if I want the internal representation
  to be (container, pid) or a magic kpid that combines the into one integer.
  I know I don't want the kpid to be user space visible though.

So far you have not addressed the issues of maintaining code in the
kernel tree.  

Eric

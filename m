Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWBPFyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWBPFyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWBPFyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:54:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54171 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932495AbWBPFyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:54:18 -0500
To: Sam Vilain <sam@vilain.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
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
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	<43F3B820.8030907@vilain.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Feb 2006 22:50:12 -0700
In-Reply-To: <43F3B820.8030907@vilain.net> (Sam Vilain's message of "Thu, 16
 Feb 2006 12:24:16 +1300")
Message-ID: <m1mzgrrgx7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> Serge E. Hallyn wrote:
>> However, if we're going to get anywhere, the first decision which we
>> need to make is whether to go with a (container,pid), (pspace,pid) or
>> equivalent pair like approach, or a virtualized pid approach.  Linus had
>> previously said that he prefers the former.  Since there has been much
>> discussion since then, I thought I'd try to recap the pros and cons of
>> each approach, with the hope that the head Penguins will chime in one
>> more time, after which we can hopefully focus our efforts.
>
> IOW, we can stop arguing and start implementing :-).

PID Space god mode....

If internally each pspace had a small number, that we could prepend
to the pid.  We would have a local global pid view.

If we hashed each pid by the unsigned long version of pspace->nr | pid.
We would have a hash table with a global view.

If we exported this number to user space we would have global pids.

I absolutely hate the idea because it yields a set of processes whose
view of the world is difficult if not impossible to migrate to another
machine, plus those processes need an extra set of translation functions.

It is worth mentioning because it is easy to implement, and either everyone
else will like it and it will get adopted or it will at least provide
an easy way to implement a transition API, for those people currently stuck.

Eric

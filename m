Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWA3UPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWA3UPB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWA3UPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:15:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26758 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964935AbWA3UPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:15:00 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<20060129190539.GA26794@kroah.com>
	<m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>
	<20060130045153.GC13244@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 13:13:12 -0700
In-Reply-To: <20060130045153.GC13244@kroah.com> (Greg KH's message of "Sun,
 29 Jan 2006 20:51:53 -0800")
Message-ID: <m14q3l79uv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sun, Jan 29, 2006 at 02:58:51PM -0700, Eric W. Biederman wrote:
>> 
>> What does the kref abstraction buy?  How does it simplify things?
>> We already have equivalent functions in atomic_t on which it is built.
>
> It ensures that you get the logic of the reference counting correctly.
> It forces you to do the logic of the get and put and release properly.
>
> To roughly quote Andrew Morton, "When I see a kref, I know it is used
> properly, otherwise I am forced to read through the code to see if the
> author got the reference counting logic correct."
>
> It costs _nothing_ to use it, and let's everyone know you got the logic
> correct.
>
> So don't feel it is a "abstraction", it's a helper for both the author
> (who doesn't have to get the atomic_t calls correct), and for everyone
> else who has to read the code.

So looking at kref and looking at my code I have a small amount of feedback.
It looks like using kref would increase the size of my code as I would
have to add an additional function.  Further I don't see that it would
simplify anything in my code. 

The extra debugging checks in krefs are nice, but not something I
am lusting over.

As for code recognition I don't see how recognizing the atomic_t idiom
versus the kref idiom is much different.  But I haven't had this issue
come up in a code review so I have no practical experience there.

The biggest issue I can find with kref is the name.  kref is not a
reference it is a count.  A reference count if you want to be long
about it. Just skimming code using it looks like kref is a pointer to
a generic object that you are getting and putting. 

It also doesn't help that current krefs are used in little enough code
that I still find it jarring to see one.  One more abstraction to
read.  Whereas atomic_t are everywhere, so I am familiar with them.

So those are all of the nits I can pick. :)  I don't kref seems to be
a perfectly usable piece of code but not one that seems to help my
code.  Unless it becomes a mandate from the code correctness police.

Eric

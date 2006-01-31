Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWAaQGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWAaQGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWAaQGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:06:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42642 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750770AbWAaQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:06:12 -0500
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
	<m14q3l79uv.fsf@ebiederm.dsl.xmission.com>
	<20060131065843.GA24733@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 31 Jan 2006 09:04:14 -0700
In-Reply-To: <20060131065843.GA24733@kroah.com> (Greg KH's message of "Mon,
 30 Jan 2006 22:58:44 -0800")
Message-ID: <m1d5i84c5d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Mon, Jan 30, 2006 at 01:13:12PM -0700, Eric W. Biederman wrote:
>
> What function would you have to add?  A release function?  You should
> have that logic somewhere already, so net gain should be the same.

Yes inline in my if statement all 3 lines of it. Adding a function
makes the code less clear.

>> The extra debugging checks in krefs are nice, but not something I
>> am lusting over.
>
> Heh, but they do catch a lot of improper usages.

Agreed.

>> As for code recognition I don't see how recognizing the atomic_t idiom
>> versus the kref idiom is much different.  But I haven't had this issue
>> come up in a code review so I have no practical experience there.
>
> It's not a different "idiom", but rather, a way to implement the
> reference counting logic without having to code it all by hand, and
> ensure that you get it correct.

Yes a way to implement the reference counting logic that requires more
lines of code to implement and obscures my code in this instance.

> They are used all the time, and there's not that many atomic_t usages in
> the kernel that do reference counting that have not been already
> converted to use kref (the vfs not-withstanding, for other reasons.)

Well either that is all code that is still to be merged in the
mainline or I am looking with a very different filter than you are.

A quick grep for atomic_t in the kernel include files (filtering
out the asm headers where it was defined) I got several screen fulls
of hits.  Things like the network stack, shared process resources are
places I have worked lately and where atomic_t is used, all of the
core bits of the kernel.  My similar grep for kref should barely returned
a screen full of hits.

>> So those are all of the nits I can pick. :)  I don't kref seems to be
>> a perfectly usable piece of code but not one that seems to help my
>> code.  Unless it becomes a mandate from the code correctness police.
>
> As you are adding a new reference count, it is highly encouraged that
> you not reimplement the same logic, but rather use the functions already
> provided in the kernel to do that work for you.  That way you don't have
> to write the extra code, and we don't have to check the logic for you.

If there was something to implement I would agree with you.  In drivers
out at the fringes of the kernel where looking at some of the code submissions
you wonder if the implementors know C I can totally understand anything
to make things less error prone.  But that isn't what this code is.

Given how short my code is and what the effects are I am actually
disappointed that the review only got as far as noticing I was using
an atomic_t.  Oh well.  Thanks for getting that far.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWBQMTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWBQMTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWBQMTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:19:53 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36525 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751399AbWBQMTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:19:52 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
	<m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	<20060216142928.GA22358@sergelap.austin.ibm.com>
	<m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
	<20060216175326.GA11974@sergelap.austin.ibm.com>
	<m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com>
	<20060216184407.GC11974@sergelap.austin.ibm.com>
	<1140115979.21383.11.camel@localhost.localdomain>
	<m1bqx6p815.fsf@ebiederm.dsl.xmission.com>
	<20060217114441.GA17940@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 17 Feb 2006 05:16:06 -0700
In-Reply-To: <20060217114441.GA17940@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Fri, 17 Feb 2006 12:44:41 +0100")
Message-ID: <m1vevenptl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Fri, Feb 17, 2006 at 03:57:26AM -0700, Eric W. Biederman wrote:
>> As for that.  When I mad that suggestion to Herbert Poetzl 
>> his only concern was that a smart init might be too heavy weight 
>> for lightweight vserver.  Generally I like the idea.
>
> well, may I remind that this solution would require _two_
> init processes for each guest, which could easily make up
> 300-400 unnecessary processes in a lightweight server
> setup?

I take it seriously enough that I remembered the concern,
and I think it is legitimate.  Figuring out how to safely
set the policy is a challenge.  That is something a
user space daemon trivially gets right.  

The kernel side of a process is about 10K if the user space
side was also lightweight we could have the entire
per process cost in the 30K range.  30K*400 = 12000K = 12M.

That is significant but we are still cheap enough that it
isn't necessarily a show stopper.

I think the cost was only one extra process, for the case where you
have fakeinit now it would be init, for other cases it would be a
daemon that gets setup when you initialize the vserver.

If we can get a permission checking model in the kernel right
it is potentially much cheaper, to have an enter model.

Having user space as a backup to that is still interesting.

>> > (Read the last sentence, and in case you're wondering, no I don't have
>> > any children in real life)
>> 
>> Speaking of that.  One of my coworkers mentioned that it is unfortunate
>> that our names don't have the double meaning.  So it was suggested we
>> call them 
>> 
>> Speaking of that problematic naming.  One of my coworkers mentioned that
>> it is unfortunate that our set of names does not have a double meaning.
>> After that the suggestion came up to call them families, instead of guest
>> or pidspaces.  Although I guess calling them guests is about as bad :)
>
> well, at least Guests or VEs are terms already used by
> existing projects, where pspace sounds somewhat strange.
>
> at the same time I'd like to point out that *spaces is
> a good name for the building blocks, but we definitely
> have to name the 'construct' different, i.e. a 'guest'
> (or VPS or VE or whatever) is _more_ than just a p-space
> it's the sum of all *-spaces required to make it look
> like a real linux system.

I totally agree.  Sorry.  This was meant as a humerous tangent!
I thought the smiley and the fact I was looking for a name
with a double meaning that would have made it easier to get
confused would have made that clear!

Oh well such is confusion an email :)

Eric

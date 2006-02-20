Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWBTP1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWBTP1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWBTP1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:27:35 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:3812 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030286AbWBTP1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:27:34 -0500
Date: Mon, 20 Feb 2006 16:27:33 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
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
Message-ID: <20060220152732.GC18841@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Hansen <haveblue@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Suleiman Souhlal <ssouhlal@FreeBSD.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Cedric Le Goater <clg@fr.ibm.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg <gkurz@fr.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
	Andi Kleen <ak@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jes Sorensen <jes@sgi.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <43F98DD5.40107@sw.ru> <20060220124745.GC17478@MAIL.13thfloor.at> <43F9D379.5000803@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9D379.5000803@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 05:34:33PM +0300, Kirill Korotaev wrote:
>>> yes, acceptable.
>>> once, again, believe me, this is very required feature for
>>> troubleshouting and management (as Eric likes to take about
>>> maintanance :) )
> 
>> IMHO there are certain things which _are_ required
>> and others which are nice to have but not strictly
>> required, just think "ptrace across pid spaces"
> these "nice to have" features often make one solution more usable than
> another.

agreed, but do you really have to strace the OpenVZ
tools so often, as I don't see any other purpose 
for cross space strace. usually you strace either
inside or outside the space, as the transition is
not that well defined anyway ...

>>>> This is to support using pidspaces for vservers, and creating
>>>> migrateable sub-pidspaces in each vserver.

>>> this doesn't help to create migratable sub-pidspaces.
>>> for example, will you share IPCs in your pid parent and child pspaces?
>>> if yes, then it won't be migratable;

>> well, not the child pspace, but the parent, no?

> if IPC objects are shared between them, then they can only be migrated 
> together.

not all spaces will be done fur the purpose of
migration, some of them might have other purposes

>>> if no, then you need to create fully isolated spaces to the end and
>>> again you end up with a question, why nested pspaces are required at
>>> all?
>> because we are not trying to implement a VPS only
>> solution for mainline, we are trying to provide
>> building blocks for many different uses, including
>> the VPS approach ...
> nice! do you think I'm against building blocks? no :) 

> I'm just trying to get out from you how this can be used in real 
> life and how will it work.

ah, I'm glad to share my experience here ...

the linux-vserver.org wiki shows some of those
real world usage scenarios, which include, but are
not limited to:

 - Administrative Separation
 - Service Separation
 - Enhancing Security (better chroot)
 - Easy Maintenance (hardware independance)
 - Testing

most application scenarios do not require a complete
VPS or Guest to make them usable, often only a single
* space would suffice to accomplish the goal ...

best,
Herbert

> Kirill

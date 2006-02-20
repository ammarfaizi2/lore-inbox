Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWBTMea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWBTMea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWBTMea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:34:30 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:13539 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030185AbWBTMe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:34:29 -0500
Date: Mon, 20 Feb 2006 13:34:27 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, "Serge E. Hallyn" <serue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process id namespace
Message-ID: <20060220123427.GA17478@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	"Serge E. Hallyn" <serue@us.ibm.com>,
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
References: <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <43F9A80A.6050808@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9A80A.6050808@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 02:29:14PM +0300, Kirill Korotaev wrote:
> >>And we are too cycled on PIDs. Why? I think this is the most minor 
> >>feature which can easily live out of mainstream if needed, while 
> >>virtualization is the main goal.
> >
> >
> >although I could be totally ignorant regarding the PID
> >stuff, it seems to me that it pretty well reflects the
> >requirements for virtualization in general, while being
> >simple enough to check/test several solutions ...
> >
> >why? simple: it reflects the way 'containers' work in
> >general, it has all the issues with administration and
> >setup, similar to 'guests' (it requires some management
> >and access from outside, while providing security and
> >isolation inside), containers could be easily built on
> >top of that or as an addition to the pid space structures
> >at the same time it's easy to test, and issues will show
> >up quite early, so that they can be discussed and, if
> >necessary, solved without rewriting an entire framework.

> I would disagree with you. These discussions IMHO led us to the wrong
> direction.
>
> Can I ask a bunch of questions which are related to other
> virtualization issues, but which are not addressed by Eric anyhow?
> 
> - How are you planning to make hierarchical namespaces for such 
>   resources as IPC? Sockets? Unix sockets?

in the same way as for resources or filesystems -
management is within the parent, usage within the
child

> Process tree is hierarchical by it's nature. But what is heirarchical 
> IPC and other resources?

for resources it's simple, you have to 'give away'
a certain share to your children, which in turn will
enable them to utilize them up to the given amount,
or (depending on the implementation) up to the total
amount of the parent.

(check out ckrm as a proof of concept, and example
how it should not be done :)

> And no one ever told me why we need heierarchy at all. No any _real_
> use cases. But it's ok.

there are many use cases here, first, the VPS within
a VPS (of course, not the most useful one, but the
most obvious one), then there are all kind of test,
build and security scenarios which can benefit from
hierarchical structures and 'delegated' administrative
power (just think web space management)

> - Eric wants to introduce name spaces, but totally forgots how much
>   they are tied with each other. IPC refers to netlinks, network refers
>   to proc and sysctl, etc. It is some rare cases when you will be able
>   to use namespaces without full OpenVZ/vserver containers. 

well, we already visited the following:

 - filesystem namespaces (works quite fine completely
   independant of all other)

 - pid spaces (again they are quite fine without any
   other namespace)

 - resource spaces (another one which makes perfect
   sense to have without the others)

the fact that some things like proc or netlink is tied
to networking and ipc IMHO is just a sign that those
interfaces need revisiting and proper isolation or
virtualization ...

>   But yes, you are right it will be quite easy for us to use
>   containers on top of namespaces :)
> 
> - How long these namespaces live? And which management interface each
>   of them will have?

well, the lifetime of such a space is very likely to
be at least the time of the users, including all
created sockets, file-handles, ipc resources, etc ...

> For example, can you destroy some namespace? 

not directly, well, you 'could' make some kind of
crawler which goes and kills off all structures
keeping a reference to that particular namespace

> Or it is automatically destroyed when the last reference to it is     
> dropped? 

yup, that's how it could/should work ...

> This is not that simple question as it may seem to be, especially
> taking into account that some namespaces can live longer (e.g. time
> wait buckets should live some time after container died; or shm which
> also can die in a foreign context...).

yes, those have to be adressed and a very specific
semantic has to be found, so that no surprises happen

> So I really hate that we concentrated on discussion of VPIDs,
> while there are more general and global questions on the whole
> virtualization itself.

well, I was not the one rolling out the 'perfect'
vpid solution ...

> >now that you mention it, maybe we should have a few
> >rounds how those 'generic' container syscalls would 
> >look like?
> 
> First of all, I don't think syscalls like
> "do_something and exec" should be introduced.

Linux-VServer does not have any of those syscalls
and it works quite well, so why should we need such
syscalls?

note: I do not consider clone() or unshare() to be
of this category (just to avoid confusion)

> Next, these syscalls interfaces can be introduced only after we 
> discussed the _general_ concepts, like: how these containers exist, 
> live, are created, waited and so on. But this is impossible to discuss 
> on PID example only. Because:

> 1. pids are directly related to process lifetime. no much issues here.
> 2. pids are hierarchical by its nature.
> 3. there are much more approaches here, then in network for example.

I have no problem at all to discuss a general plan
(hey I though we were already doing so :) or move
to some other area (like networking :)

best,
Herbert

> Kirill

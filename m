Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWBTPgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWBTPgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWBTPgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:36:10 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:11236 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964936AbWBTPgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:36:08 -0500
Date: Mon, 20 Feb 2006 16:36:07 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Hansen <haveblue@us.ibm.com>,
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
Message-ID: <20060220153606.GD18841@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
	vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216143030.GA27585@MAIL.13thfloor.at> <43F990CA.5080102@sw.ru> <20060220130020.GD17478@MAIL.13thfloor.at> <43F9D5DF.6030009@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9D5DF.6030009@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 05:44:47PM +0300, Kirill Korotaev wrote:
>> >fine, agreed on this finally, same for OpenVZ.
>> hey we have soemthing :)
> :)

>>>> definitely, we (Linux-VServer) added this some time ago
>>>> and it helps to maintain/restart a guest.

>>> but why sys_waitpid? we can make it in many other ways,

>> yes, we currently have a syscall switch command 
>> to wait for the guest, but, of course, it is
>> very similar to the 'normal' unix waitpid()

> this is more logically clean to me, since containers/namespaces are
> not tasks. If someone wants to use more unix-like semantics, he can
> obtain fd for namespace and call select/poll on it :))))

well, I'm neither for nor against a separate syscall
here, don't get me wrong, but it will take ages to
get the 'new' syscalls added to all archs, and the
arch maintainers will probably have a dozent reasons
why this particular syscall is completely wrong :)

>>> And we had issues in OpenVZ, that very fast VPS stop/start can fail
>>> due to not freed resources yet.

>> this is a design problem, if your design allows
>> to have _more_ than one pid space with the same
>> identifier/properties, but with only one active
>> and thus reachable space, it is no problem to 
>> create a new one right after the old one did send
>> the event (which doesn't mean that it was destroyed
>> just that the last process left the space)

> see my another email about sockets.

which one?

[ some context lost here ]

>>> How about third party apps?

>> I don't think we care about third party apps when
>> adding new kernel functionality, especially not
>> proprietary ones which cannot be modified easily

> Even if we don't take into account proprietary apps, there too many
> opensource control panels, management tools etc. So this doesn't look
> good to me anyhow.

well, they would see exactly the same as before, not
more and not less, new features will require new tools
and/or adaptations to the old ones. period.

>>> agreed. Though I don't like a backdoor name :) 
>>> It is just a way to get access to VPS.

>> well, it is often a way to get access to the VPS
>> without the 'owner' of that VPS even knowing, so
>> IMHO it's a backdoor, access would be via sshd or
>> console :)

> When you have a physical box there are many ways to get access to it
> without knowing passwords etc. This is the same.

does that change what it is, a backdoor circumventing
established security? I don't think so ...

best,
Herbert

> Kirill

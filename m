Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWBPRyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWBPRyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWBPRyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:54:24 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33446 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932195AbWBPRyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:54:23 -0500
Date: Thu, 16 Feb 2006 11:53:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
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
Message-ID: <20060216175326.GA11974@sergelap.austin.ibm.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> > I think it should be acceptable if a pidspace is visible in all it's
> > ancestor pidspaces.  I.e. if I create pspace2 and pspace3 from pid 234
> > in pspace1, then pspace2 doesn't need to be able to address pspace3
> > and vice versa.
> 
> A good rule.  Now consider pspace 4 which is a child of pid 567
> in pspace 3.
> 
> What should pspace 3 see? 

Implementation dependent.

What I'd like to see is:

> What should pspace 3 see? 

The pid of the init process for pspace 4.

> What should pspace 1 see?

The pid of the init process for pspace 3.

> What happens when you migrate pspace 3 into a different pspace
> on a different machine?

Nothing special.  "Migrate" was just a checkpoint (from pspace 1)
and a resume (from pspace N on some machine).  So now pspace N on
the new machine has created a new pspace - which happens to be
immediately populated with the contents of the old pspace 3 - and
see the pid of the init process of this new pspace.

> Is there a sane implementation for this?

IMO, definately yes.

But I haven't tried it, so my opinion is just that.

-serge

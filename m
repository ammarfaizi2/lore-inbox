Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWD0EPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWD0EPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWD0EPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:15:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37067 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964923AbWD0EPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:15:41 -0400
From: Andi Kleen <ak@suse.de>
To: "Ken Brush" <kbrush@gmail.com>
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Thu, 27 Apr 2006 06:15:19 +0200
User-Agent: KMail/1.9.1
Cc: "Neil Brown" <neilb@suse.de>, "Stephen Smalley" <sds@tycho.nsa.gov>,
       "Chris Wright" <chrisw@sous-sol.org>,
       "James Morris" <jmorris@namei.org>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17487.61698.879132.891619@cse.unsw.edu.au> <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
In-Reply-To: <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604270615.20554.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 01:06, Ken Brush wrote:

> > 2/ What advantages does AppArmor provide over techniques involving
> >    virtualisation or gaol mechanisms?  Are these advantages worth
> >    while?

I would guess the advantage is easier administration. e.g. I always
found it a PITA to synchronize files like /etc/resolv.conf and similar
files into chroots.

It's similar as to why managing a single machine is much easier
than a cluster. Chroots already get you many of the drawbacks from
a cluster. That said it has its places, but chroot is not always
the answer.

> If you just wish to run every application in a chrooted jail. Would
> you still need a MAC solution?

Current chroot is probably not strong enough - if someone gets root
inside it it is easy to escape.

> > 3/ Is AppArmour's approach of using d_path to get a filename from a
> >    dentry valid and acceptable? 

I suppose it needs at least to use the proper vfsmounts instead of
walking the global list. That would need better hooks. And probably 
some caching (trying to match dentries directly?) to get better performance.

Regarding the basic use of pathnames I don't see a big problem. After
all the kernel uses dentries for everything too and dentries are
just a special form of path name too.

-Andi

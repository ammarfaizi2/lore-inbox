Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVELNtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVELNtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 09:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVELNtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 09:49:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:22716 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261975AbVELNtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 09:49:09 -0400
Date: Thu, 12 May 2005 08:47:34 -0500
From: serue@us.ibm.com
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Jamie Lokier <jamie@shareable.org>, Ram <linuxram@us.ibm.com>,
       Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512134734.GA17062@serge.austin.ibm.com>
References: <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost> <20050511212810.GD5093@mail.shareable.org> <1115851333.6248.225.camel@localhost> <a4e6962a0505111558337dd903@mail.gmail.com> <20050512010215.GB8457@mail.shareable.org> <a4e6962a05051119181e53634e@mail.gmail.com> <20050512064514.GA12315@mail.shareable.org> <a4e6962a0505120623645c0947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a0505120623645c0947@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Van Hensbergen (ericvh@gmail.com):
> Let's focus on baby steps first, and to me that's:
> a) get rid of holes that allow users to traverse out of a chroot jail
> by using the creation of private name spaces (is anyone working on
> this, did I miss a patch?)

I have tested doing
	clone(CLONE_NEWNS);
	chdir(/some_jail_dir);
	pivot_root(., tmp)
	umount2(tmp, MNT_DETACH)
	chroot(.)

which appears to prevent escapes from chroot jails.  So unless my tests
were insufficient, we don't need additional kernel support.  We can just
use something like chroot_ns.c from www.sf.net/projects/linux-jail/.

> b) make CLONE_NEWNS (and any other name space creation mechanisms such
> as the proposed unshare system call) available to normal users
> c) Get the unshare system call adopted as it seems to be generally useful
> d) Get Miklos' unprivileged mount/umount patch adopted in mainline

and I'd say

e) Work towards the shared namespaces, which are really one of the
main reasons not to use namespaces right now.

I know this work is being done, so this isn't so much a request for the
shared namespaces, as just a reminder that this will be one of the major
pieces of functionality to consider along with the ones you listed.

thanks,
-serge

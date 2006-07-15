Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945984AbWGOELW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945984AbWGOELW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWGOELW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:11:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34954 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1945984AbWGOELW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:11:22 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
	<m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	<1152896138.24925.74.camel@localhost.localdomain>
	<20060714170814.GE25303@sergelap.austin.ibm.com>
	<1152897579.24925.80.camel@localhost.localdomain>
	<m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
	<1152900911.5729.30.camel@lade.trondhjem.org>
	<m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
	<1152911079.5729.70.camel@lade.trondhjem.org>
Date: Fri, 14 Jul 2006 22:09:50 -0600
In-Reply-To: <1152911079.5729.70.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Fri, 14 Jul 2006 17:04:38 -0400")
Message-ID: <m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Fri, 2006-07-14 at 12:40 -0600, Eric W. Biederman wrote:
>> Now I do agree if I can set the information in vfsmount and not in
>> the superblock it is probably better.  But even with nfs mount superblock
>> collapsing (which I almost understand) I don't see it as a real
>> problem, as long as I could prevent the superblock from collapsing.
>
> NFS is the least of your problems. You can only have one superblock for
> most local filesystems too and with good reason: imagine, for instance,
> the effect of having 2 different block allocators working on the same
> device.

Let me try to explain the idea again.

Currently there is a global context in which we interpret uids.
But different machines can have different global contexts.

Each filesystem to be sane needs to store uids from only one such
context.  For network filesystems typicall the context is extended to
multiple machines so that everyone who mounts a filesystem will
interpret a uid with the same meaning.

The idea of creating multiple a user id namespaces on a single machine
creates multiple contexts for the interpretation of uid values on
the same machine.  Allowing a single id to refer to different
users depending on the context in which it is interpreted.

I can think of no circumstance in which a single filesystem
will have multiple contexts in which user id's will be interpreted.
Nor can I think of a sane scenario in which that would occur.

Given the fact that we are referring to a global property of a filesystem
why is it fundamentally a problem to put it in the superblock?

Eric

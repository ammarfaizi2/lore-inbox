Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWGNOwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWGNOwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWGNOwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:52:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60349 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161117AbWGNOwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:52:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<20060713214101.GB2169@sergelap.austin.ibm.com>
	<m1y7uwyh9z.fsf@ebiederm.dsl.xmission.com>
	<20060714140237.GD28436@sergelap.austin.ibm.com>
Date: Fri, 14 Jul 2006 08:50:42 -0600
In-Reply-To: <20060714140237.GD28436@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 14 Jul 2006 09:02:37 -0500")
Message-ID: <m1k66gw88t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> If you permission checks are not (user namespace, uid) what can't you do?
>
> File descripters can only be passed over a unix socket, right?

No.  You can use /proc to do the same thing.  You can inherit
file descriptors, etc.  This isn't a door you can just close and ignore.
It is too easy to do this to assume you have closed every possible
way to get a descriptor from outside of ``container''.

Suppose you have user fred uid 1000 outside of any containers,
and you have user joe uid 1000 inside user uid namespace.  If you don't
make your permission checks (user namespace, uid) fred can do terrible
things to joe.

If I we don't do the expanded permission checks the only alternative
is to check to see if every object is in our ``container'' at every
access.  That isn't something I want to do.

I don't intend to partition objects just partition object look ups by name.
Which means that if you very carefully setup your initial process you
will never be able to find an object outside of your namespace.  But
the kernel never should assume user space has done that.

> So this seems to fall into the same "userspace should set things up
> sanely" argument you've brought up before.

For using it yes.  But not for correct kernel operation.

> Don't get me wrong though - the idea of using in-kernel keys as
> cross-namespace uid's is definately interesting.

That is their role in the kernel.  A flavor of key to handle uid
mapping needs to be added, but that is all.

Eric

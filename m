Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWGMTD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWGMTD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWGMTD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:03:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16295 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030284AbWGMTD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:03:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
Date: Thu, 13 Jul 2006 13:02:13 -0600
In-Reply-To: <1152815391.7650.58.camel@localhost.localdomain> (Dave Hansen's
	message of "Thu, 13 Jul 2006 11:29:50 -0700")
Message-ID: <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Thu, 2006-07-13 at 12:14 -0600, Eric W. Biederman wrote:
>> Maybe.  I really think the sane semantics are in a different uid namespace.
>> So you can't assumes uids are the same.  Otherwise you can't handle open
>> file descriptors or files passed through unix domain sockets.
>
> Eric, could you explain this a little bit more?  I'm not sure I
> understand the details of why this is a problem?

Very simply.

In the presence of a user namespace.  
All comparisons of a user equality need to be of the tuple (user namespace, user id).
Any comparison that does not do that is an optimization.

Because you can have access to files created in another user namespace it
is very unlikely that optimization will apply very frequently.  The easy scenario
to get access to a file descriptor from another context is to consider unix
domain sockets.

So my impression was that Cedric's patchset was overoptimized because
it did not change most of the uid comparisons, to (user namespace, user id).

This is one of those strange cases where the optimization is less work
because it means not applying a patch.

Eric

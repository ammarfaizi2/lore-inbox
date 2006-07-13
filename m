Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWGMVmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWGMVmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWGMVmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:42:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6024 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030412AbWGMVmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:42:00 -0400
Date: Thu, 13 Jul 2006 16:41:01 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060713214101.GB2169@sergelap.austin.ibm.com>
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com> <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <44B684A5.2040008@fr.ibm.com> <20060713174721.GA21399@sergelap.austin.ibm.com> <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > On Thu, 2006-07-13 at 12:14 -0600, Eric W. Biederman wrote:
> >> Maybe.  I really think the sane semantics are in a different uid namespace.
> >> So you can't assumes uids are the same.  Otherwise you can't handle open
> >> file descriptors or files passed through unix domain sockets.
> >
> > Eric, could you explain this a little bit more?  I'm not sure I
> > understand the details of why this is a problem?
> 
> Very simply.
> 
> In the presence of a user namespace.  
> All comparisons of a user equality need to be of the tuple (user namespace, user id).
> Any comparison that does not do that is an optimization.
> 
> Because you can have access to files created in another user namespace it
> is very unlikely that optimization will apply very frequently.  The easy scenario
> to get access to a file descriptor from another context is to consider unix
> domain sockets.

What does that have to do with uids?  If you receive an fd, uids don't
matter in any case.  The only permission checks which happen are LSM
hooks, which should be uid-agnostic.

-serge

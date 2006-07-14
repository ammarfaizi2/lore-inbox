Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWGNR6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWGNR6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWGNR6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:58:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23733 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422668AbWGNR6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:58:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
	<m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	<20060714170523.GD25303@sergelap.austin.ibm.com>
Date: Fri, 14 Jul 2006 11:56:51 -0600
In-Reply-To: <20060714170523.GD25303@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 14 Jul 2006 12:05:23 -0500")
Message-ID: <m13bd4t6ho.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> 
>> Capabilities have always fitted badly in with the normal unix
>> permissions.
>
> Well they're not supposed to fit in.

A better way to phrase that is to say the don't fit into the unix
culture well.

> If we keep permchecks as uid==0 on files which invoke kernel callbacks,
> then we can only say once what root is allowed to do.  If we make them
> capability checks, then for differnet uses of namespaces we can have
> them do different things.  For instance if we're making a separate user
> namespace for a checkpoint/restart purpose, we might want root to retain
> more privs than if we're making a vserver.

Yes. :)

> Look I just have to keep responding because you keep provoking :), but
> I'm looking at other code and don't even know which entries we're
> talking about.  If when I get to looking at them I find they really
> should be done by capabilities, I'll submit a patch and we can argue
> then.

Roughly the set can be found with:
find /proc/ -type f -uid 0 -perm -0200 ! '(' -path '/proc/[0-9]*' ')' ! '(' -perm 0022 ')'
find /sys/ -type f -uid 0 -perm -0200 !  ! '(' -perm 0022 ')'

Very few writable files in /proc or sysfs do any sort of capability checking.

In essence every little file by every little driver out there has
this problem.  

The unix permission way to handle this would be to chown these files
after bootup to the appropriate users (because the permissions cannot
be stored in the filesystem).

I have a hard time believing that chasing ever little driver is going to 
be a tractable solution to this problem.

>> So if we have a solution that works nicely with normal
>> unix permissions we will have a nice general solution, that is
>> easy for people to understand.
>> 
>> What I am talking about is making a small tweak to the permission
>> checking as below.  Why do you keep avoiding even considering it?
>
> Not only don't I avoid considering it, I thought I'd even suggested it
> a while ago  :)

Sorry. Too many email messages that just seemed to miss the point,
when we had that miscommunication...

> It sounds good to me.

Cool.

Eric


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWGNRQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWGNRQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161276AbWGNRQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:16:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13282 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161275AbWGNRQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:16:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<44B684A5.2040008@fr.ibm.com>
	<20060713174721.GA21399@sergelap.austin.ibm.com>
	<m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
	<m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	<1152896138.24925.74.camel@localhost.localdomain>
Date: Fri, 14 Jul 2006 11:14:37 -0600
In-Reply-To: <1152896138.24925.74.camel@localhost.localdomain> (Dave Hansen's
	message of "Fri, 14 Jul 2006 09:55:38 -0700")
Message-ID: <m1odvst8g2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Fri, 2006-07-14 at 10:49 -0600, Eric W. Biederman wrote:
>> -       if (current->fsuid == inode->i_uid)
>> +       if ((current->fsuid == inode->i_uid) &&
>> +               (current->nsproxy->user_ns == inode->i_sb->user_ns))
>>                 mode >>= 6; 
>
> I really don't think assigning a user namespace to a superblock is the
> right way to go.  Seems to me like the _view_ into the filesystem is
> what you want to modify.  That would seem to me to mean that each
> 'struct namespace' (filesystem namespace) or vfsmount would be assigned
> a corresponding user namespace, *not* the superblock.

I guess since you can't bind mount across filesystem namespaces looking
at the vfsmount is ok, and more flexible.

But inode->i_sb->user_ns or nd->mnt->user_ns isn't nearly as important
as simply comparing some the appropriate user_ns values.

Eric

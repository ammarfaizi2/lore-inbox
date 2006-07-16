Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGPKJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGPKJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 06:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWGPKJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 06:09:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27357 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750743AbWGPKJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 06:09:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
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
	<44B9FA87.30006@sw.ru>
Date: Sun, 16 Jul 2006 04:08:03 -0600
In-Reply-To: <44B9FA87.30006@sw.ru> (Kirill Korotaev's message of "Sun, 16 Jul
	2006 12:36:23 +0400")
Message-ID: <m13bd1q2v0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>-       if (current->fsuid == inode->i_uid)
>>>+       if ((current->fsuid == inode->i_uid) &&
>>>+               (current->nsproxy->user_ns == inode->i_sb->user_ns))
>>>                mode >>= 6;
>> I really don't think assigning a user namespace to a superblock is the
>> right way to go.  Seems to me like the _view_ into the filesystem is
>> what you want to modify.  That would seem to me to mean that each
>> 'struct namespace' (filesystem namespace) or vfsmount would be assigned
>> a corresponding user namespace, *not* the superblock.
> I dislike this way either. We need an ability to have an access to container
> filesystems and data from the host.
> such a strong checks break this.

No this check doesn't.  CAP_DAC_OVERRIDE still works.

Of course enter a running container is a subject for major debate.

Eric


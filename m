Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946147AbWGPIgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946147AbWGPIgg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 04:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWGPIgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 04:36:36 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:8101 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750710AbWGPIgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 04:36:36 -0400
Message-ID: <44B9FA87.30006@sw.ru>
Date: Sun, 16 Jul 2006 12:36:23 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1psgaag7y.fsf@ebiederm.dsl.xmission.com>	 <44B684A5.2040008@fr.ibm.com>	 <20060713174721.GA21399@sergelap.austin.ibm.com>	 <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>	 <1152815391.7650.58.camel@localhost.localdomain>	 <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>	 <1152821011.24925.7.camel@localhost.localdomain>	 <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>	 <1152887287.24925.22.camel@localhost.localdomain>	 <m17j2gw76o.fsf@ebiederm.dsl.xmission.com>	 <20060714162935.GA25303@sergelap.austin.ibm.com>	 <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com> <1152896138.24925.74.camel@localhost.localdomain>
In-Reply-To: <1152896138.24925.74.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-       if (current->fsuid == inode->i_uid)
>>+       if ((current->fsuid == inode->i_uid) &&
>>+               (current->nsproxy->user_ns == inode->i_sb->user_ns))
>>                mode >>= 6; 
> 
> 
> I really don't think assigning a user namespace to a superblock is the
> right way to go.  Seems to me like the _view_ into the filesystem is
> what you want to modify.  That would seem to me to mean that each
> 'struct namespace' (filesystem namespace) or vfsmount would be assigned
> a corresponding user namespace, *not* the superblock.
I dislike this way either. We need an ability to have an access to container
filesystems and data from the host.
such a strong checks break this.

Thanks.
Kirill

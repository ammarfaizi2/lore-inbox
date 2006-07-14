Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWGNQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWGNQzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWGNQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:55:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8156 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422638AbWGNQzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:55:45 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
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
Content-Type: text/plain
Date: Fri, 14 Jul 2006 09:55:38 -0700
Message-Id: <1152896138.24925.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 10:49 -0600, Eric W. Biederman wrote:
> -       if (current->fsuid == inode->i_uid)
> +       if ((current->fsuid == inode->i_uid) &&
> +               (current->nsproxy->user_ns == inode->i_sb->user_ns))
>                 mode >>= 6; 

I really don't think assigning a user namespace to a superblock is the
right way to go.  Seems to me like the _view_ into the filesystem is
what you want to modify.  That would seem to me to mean that each
'struct namespace' (filesystem namespace) or vfsmount would be assigned
a corresponding user namespace, *not* the superblock.

-- Dave


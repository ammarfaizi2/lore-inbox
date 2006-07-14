Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWGNRJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWGNRJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbWGNRJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:09:18 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34223 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161269AbWGNRJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:09:17 -0400
Date: Fri, 14 Jul 2006 12:08:14 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060714170814.GE25303@sergelap.austin.ibm.com>
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com> <20060714162935.GA25303@sergelap.austin.ibm.com> <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com> <1152896138.24925.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152896138.24925.74.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen (haveblue@us.ibm.com):
> On Fri, 2006-07-14 at 10:49 -0600, Eric W. Biederman wrote:
> > -       if (current->fsuid == inode->i_uid)
> > +       if ((current->fsuid == inode->i_uid) &&
> > +               (current->nsproxy->user_ns == inode->i_sb->user_ns))
> >                 mode >>= 6; 
> 
> I really don't think assigning a user namespace to a superblock is the
> right way to go.  Seems to me like the _view_ into the filesystem is
> what you want to modify.  That would seem to me to mean that each
> 'struct namespace' (filesystem namespace) or vfsmount would be assigned
> a corresponding user namespace, *not* the superblock.

yes, of course, vfsmount, which I assume is what Eric meant?

Which means we'd have to do this at permission() using the nameidata, or
pass nd to generic_permission.

-serge

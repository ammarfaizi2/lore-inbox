Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWGNRGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWGNRGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWGNRGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:06:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:61150 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161268AbWGNRGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:06:24 -0400
Date: Fri, 14 Jul 2006 12:05:23 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060714170523.GD25303@sergelap.austin.ibm.com>
References: <20060713174721.GA21399@sergelap.austin.ibm.com> <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com> <20060714162935.GA25303@sergelap.austin.ibm.com> <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Eric W. Biederman (ebiederm@xmission.com):
> >> Dave Hansen <haveblue@us.ibm.com> writes:
> >> 
> >> > On Thu, 2006-07-13 at 21:45 -0600, Eric W. Biederman wrote:
> >> >> I think for filesystems like /proc and /sys that there will normally
> >> >> be problems.  However many of those problems can be rationalized away
> >> >> as a reasonable optimization, or are not immediately apparent.
> >> >
> >> > Could you talk about some of these problems?
> >> 
> >> Already mentioned but.  rw permissions on sensitive files are for 
> >> uid == 0.  No capability checks are performed.
> >
> > As Herbert (IIRC) pointed out that could/should be fixed.
> 
> Capabilities have always fitted badly in with the normal unix
> permissions.

Well they're not supposed to fit in.

If we keep permchecks as uid==0 on files which invoke kernel callbacks,
then we can only say once what root is allowed to do.  If we make them
capability checks, then for differnet uses of namespaces we can have
them do different things.  For instance if we're making a separate user
namespace for a checkpoint/restart purpose, we might want root to retain
more privs than if we're making a vserver.

Look I just have to keep responding because you keep provoking :), but
I'm looking at other code and don't even know which entries we're
talking about.  If when I get to looking at them I find they really
should be done by capabilities, I'll submit a patch and we can argue
then.

> So if we have a solution that works nicely with normal
> unix permissions we will have a nice general solution, that is
> easy for people to understand.
> 
> What I am talking about is making a small tweak to the permission
> checking as below.  Why do you keep avoiding even considering it?

Not only don't I avoid considering it, I thought I'd even suggested it
a while ago  :)

It sounds good to me.

-serge

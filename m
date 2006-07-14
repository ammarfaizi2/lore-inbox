Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422728AbWGNTl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422728AbWGNTl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWGNTl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:41:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59358 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422728AbWGNTl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:41:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com>
	<1152815391.7650.58.camel@localhost.localdomain>
	<m1wtahz5u2.fsf@ebiederm.dsl.xmission.com>
	<1152821011.24925.7.camel@localhost.localdomain>
	<m17j2gzw5u.fsf@ebiederm.dsl.xmission.com>
	<1152887287.24925.22.camel@localhost.localdomain>
	<m17j2gw76o.fsf@ebiederm.dsl.xmission.com>
	<20060714162935.GA25303@sergelap.austin.ibm.com>
	<m18xmwuo5r.fsf@ebiederm.dsl.xmission.com>
	<1152896138.24925.74.camel@localhost.localdomain>
	<20060714170814.GE25303@sergelap.austin.ibm.com>
	<1152897579.24925.80.camel@localhost.localdomain>
	<m17j2gt7fo.fsf@ebiederm.dsl.xmission.com>
	<1152900911.5729.30.camel@lade.trondhjem.org>
Date: Fri, 14 Jul 2006 12:40:05 -0600
In-Reply-To: <1152900911.5729.30.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Fri, 14 Jul 2006 14:15:11 -0400")
Message-ID: <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Fri, 2006-07-14 at 11:36 -0600, Eric W. Biederman wrote:
>> Dave Hansen <haveblue@us.ibm.com> writes:
>> 
>> > On Fri, 2006-07-14 at 12:08 -0500, Serge E. Hallyn wrote:
>> >> yes, of course, vfsmount, which I assume is what Eric meant?
>> >> 
>> >> Which means we'd have to do this at permission() using the nameidata, or
>> >> pass nd to generic_permission. 
>> >
>> > Yeah, I think so.  But, this is well into Al territory, and there might
>> > be a better way.
>> 
>> Well until we get that sorted out I will keep picking on i_sb.
>
> Don't bother: labelling superblocks with process-specific data is always
> going to be unacceptable.

It's not process specific data.  It is a pointer to global context in
which uid's on the filesystem uniquely specify a user.  This is
something that would get set when the filesystem is mounted.

> In order to avoid aliased superblocks, you would have to be able
> guarantee to be the sole owner of the data on the device that it refers
> to. You'd have to own the device in order to do that, in which case you
> are better off just labelling the device instead.

Now I do agree if I can set the information in vfsmount and not in
the superblock it is probably better.  But even with nfs mount superblock
collapsing (which I almost understand) I don't see it as a real
problem, as long as I could prevent the superblock from collapsing.

Eric

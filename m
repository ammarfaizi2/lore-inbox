Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWGOXav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWGOXav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWGOXau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:30:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:476 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964795AbWGOXau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:30:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Dave Hansen <haveblue@us.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
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
	<m1hd1krpx6.fsf@ebiederm.dsl.xmission.com>
	<1152911079.5729.70.camel@lade.trondhjem.org>
	<m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
	<4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com>
	<m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
	<1152982872.5715.15.camel@lade.trondhjem.org>
Date: Sat, 15 Jul 2006 17:29:25 -0600
In-Reply-To: <1152982872.5715.15.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Sat, 15 Jul 2006 13:01:12 -0400")
Message-ID: <m1zmfaphuy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Sat, 2006-07-15 at 06:35 -0600, Eric W. Biederman wrote:
>> I hope the confusion has passed for Trond.  My impression was he
>> figured this was per process data so it didn't make sense any where
>> near a filesystem, and the superblock was the last place it should
>> be.
>
> You are still using the wrong abstraction. Data that is not global to
> the entire machine has absolutely _no_ place being put into the
> superblock. It doesn't matter if it is process-specific,
> container-specific or whatever-else-specific, it will still be vetoed.

Sure, I have no problem with only global data, and filesystem specific
data being in a super block.  In this case my impression is that the
data is at least arguably filesystem specific.  filesystem-specific
data is ok on the super block is it not?

> If your real problem is uid/gid mapping on top of generic filesystems,
> then have you looked into the *BSD solution of using a stackable
> filesystem (i.e. umapfs)?

I haven't and it sounds reasonable to look at.  As far as I know BSDs
don't have my specific problem.  uid mapping is simply a tool for
dealing with the problem, not the problem itself.  A stackable
filesystem is a reasonable alternative to using security keys to
do the mapping.

My real problem is that there is a good case for uids that are not
global to a machine.  The discussion is simply how do you cope with
that.

Now I do believe that there is a good case for uids being global to a
filesystem and all I was really talking about was a tag that marked
which parts of the entire system that used the same uids as the
filesystem.

Eric

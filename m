Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWGPQSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWGPQSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWGPQSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 12:18:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:64428 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751026AbWGPQSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 12:18:37 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <m1zmfaphuy.fsf@ebiederm.dsl.xmission.com>
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
	 <m1zmfaphuy.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 09:18:29 -0700
Message-Id: <1153066709.314.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-15 at 17:29 -0600, Eric W. Biederman wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> > You are still using the wrong abstraction. Data that is not global to
> > the entire machine has absolutely _no_ place being put into the
> > superblock. It doesn't matter if it is process-specific,
> > container-specific or whatever-else-specific, it will still be vetoed.
> 
> Sure, I have no problem with only global data, and filesystem specific
> data being in a super block.  In this case my impression is that the
> data is at least arguably filesystem specific.  filesystem-specific
> data is ok on the super block is it not?

Yes, it is OK if you can win that argument. ;)  I'll let you take that
one up with Al.  You're just saying that since there is a possibility of
an argument, it should be OK to put the data in the sb?  

I think the uid mapping properties are OK to keep in the superblock if
and only if there is only one possible way to interpret the uids on the
disk into the uids that are seen in userspace.

This is the same argument for putting things like mnt_root in the
vfsmount.  Is there only one possible place in the filesystem in which a
given superblock may be mounted?  No.  So, it goes in the vfsmount.

I personally trust people like Trond's judgment on this stuff like this.
He's been messing with the VFS much longer than I.  Eric, would you like
to start another thread on this topic, and CC the main people from this
thread, and include Al?

Or, is this something we should address briefly at the kernel summit?

-- Dave


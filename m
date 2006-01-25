Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWAYSDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWAYSDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWAYSDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:03:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51880 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751092AbWAYSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:03:23 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<m1hd7xmylo.fsf@ebiederm.dsl.xmission.com>
	<43D52592.8080709@watson.ibm.com>
	<m1oe22lp69.fsf@ebiederm.dsl.xmission.com>
	<1138050684.24808.29.camel@localhost.localdomain>
	<m1bqy2ljho.fsf@ebiederm.dsl.xmission.com>
	<1138062125.24808.47.camel@localhost.localdomain>
	<m17j8pl95v.fsf@ebiederm.dsl.xmission.com>
	<1138137060.14675.73.camel@localhost.localdomain>
	<1138137305.2977.92.camel@laptopd505.fenrus.org>
	<m1ek2wk4ro.fsf@ebiederm.dsl.xmission.com>
	<1138201811.8720.9.camel@lade.trondhjem.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 11:01:34 -0700
In-Reply-To: <1138201811.8720.9.camel@lade.trondhjem.org> (Trond Myklebust's
 message of "Wed, 25 Jan 2006 10:10:11 -0500")
Message-ID: <m1zmlki3up.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Wed, 2006-01-25 at 02:58 -0700, Eric W. Biederman wrote:
>> >> On Maw, 2006-01-24 at 12:26 -0700, Eric W. Biederman wrote:
>> >> > There is at least NFS lockd that appreciates having a single integer
>> >> > per process unique identifier.  So there is a practical basis for
>> >> > wanting such a thing.
>
> The NFS lock manager mainly wants a unique 32-bit identifier that can
> follow clone(CLONE_FILES). The reason is that the Linux VFS is forced to
> use the pointer to the file table as the "process identifier" for posix
> locks (i.e. fcntl() locks).

Ok.  I think I was thinking of a different case, but if I missed one
this could explain the weirdness I was seeing.

Let me list the cases I know of and see if I hit what
you are thinking of.

fs/nfs/nfs3proc.c:nfs3_proc_create()
For O_EXCL we have arg.verifier = current->pid.


fs/lockd/clntproc.c:nlmclnt_setlockargs()
We have:	lock->oh.len  = sprintf(req->a_owner, "%d@%s",
					current->pid, system_utsname.nodename);

I think this is the fcntl() case.
I would suggest fl_pid might have something to do with it 
but that is part flock based locking.

So I'm not certain I see the part of NFS you are refering to.

Eric

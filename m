Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWAYWAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWAYWAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWAYWAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:00:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46763 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751177AbWAYWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:00:54 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
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
	<m1zmlki3up.fsf@ebiederm.dsl.xmission.com>
	<1138217416.8718.10.camel@lade.trondhjem.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 14:59:50 -0700
In-Reply-To: <1138217416.8718.10.camel@lade.trondhjem.org> (Trond
 Myklebust's message of "Wed, 25 Jan 2006 14:30:16 -0500")
Message-ID: <m13bjchstl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Wed, 2006-01-25 at 11:01 -0700, Eric W. Biederman wrote:
>> fs/nfs/nfs3proc.c:nfs3_proc_create()
>> For O_EXCL we have arg.verifier = current->pid.
>
> Yes, but that does not result in any permanent state that would be tied
> to the pid on the server. The verifier here is used only to ensure
> idempotency of the exclusive create RPC call.
>
>> fs/lockd/clntproc.c:nlmclnt_setlockargs()
>> We have:	lock->oh.len  = sprintf(req->a_owner, "%d@%s",
>> 					current->pid, system_utsname.nodename);
>> 
>> I think this is the fcntl() case.
>> I would suggest fl_pid might have something to do with it 
>> but that is part flock based locking.
>
> That name is not interpreted by the NLM server. It is, AFAIK, only used
> for debugging purposes.

Ok I though it might have been compared to equality someplace.

> nlm_find_lockowner() is used to define a unique identifier that is
> supposed to be sent to the server as the 'pid'.

Ok interesting.

All I know for certain was that with 2 pidspaces using the
same nfs mount I was confusing something, with regards to locking.


Eric

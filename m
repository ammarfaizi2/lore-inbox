Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWAYTar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWAYTar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWAYTar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:30:47 -0500
Received: from pat.uio.no ([129.240.130.16]:45530 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932132AbWAYTaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:30:46 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <m1zmlki3up.fsf@ebiederm.dsl.xmission.com>
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
	 <m1zmlki3up.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 14:30:16 -0500
Message-Id: <1138217416.8718.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.146, required 12,
	autolearn=disabled, AWL 1.67, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 11:01 -0700, Eric W. Biederman wrote:
> fs/nfs/nfs3proc.c:nfs3_proc_create()
> For O_EXCL we have arg.verifier = current->pid.

Yes, but that does not result in any permanent state that would be tied
to the pid on the server. The verifier here is used only to ensure
idempotency of the exclusive create RPC call.

> fs/lockd/clntproc.c:nlmclnt_setlockargs()
> We have:	lock->oh.len  = sprintf(req->a_owner, "%d@%s",
> 					current->pid, system_utsname.nodename);
> 
> I think this is the fcntl() case.
> I would suggest fl_pid might have something to do with it 
> but that is part flock based locking.

That name is not interpreted by the NLM server. It is, AFAIK, only used
for debugging purposes.
nlm_find_lockowner() is used to define a unique identifier that is
supposed to be sent to the server as the 'pid'.

Cheers,
  Trond


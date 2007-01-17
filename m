Return-Path: <linux-kernel-owner+w=401wt.eu-S1750957AbXAQWrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXAQWrN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbXAQWrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:47:13 -0500
Received: from pat.uio.no ([129.240.10.15]:56943 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbXAQWrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:47:11 -0500
Subject: Re: NFS causing oops when freeing namespace
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, akpm@osdl.org,
       Linux Containers <containers@lists.osdl.org>
In-Reply-To: <m1d55d8ex3.fsf@ebiederm.dsl.xmission.com>
References: <57238.192.168.101.6.1169029688.squirrel@intranet>
	 <m18xg1akmd.fsf@ebiederm.dsl.xmission.com>
	 <51072.192.168.101.6.1169039633.squirrel@intranet>
	 <20070117185823.GA878@tv-sign.ru> <45AE7705.4040603@fr.ibm.com>
	 <20070117194632.GA1071@tv-sign.ru> <45AE87BC.4030404@fr.ibm.com>
	 <m1d55d8ex3.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 17:46:42 -0500
Message-Id: <1169074003.6523.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=0.0, required=12.0, autolearn=disabled, none)
X-UiO-Scanned: 898E8C4FA327C87FB934EEF7091DEF6BE870CF54
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: 0 maxlevel 99990 minaction 0 bait 0 mail/h: 100 total 9430 max/h 9430 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 15:30 -0700, Eric W. Biederman wrote:
> Cedric Le Goater <clg@fr.ibm.com> writes:
> >
> > your first analysis was correct : exit_task_namespaces() should be moved 
> > above exit_notify(tsk). It will require some extra fixes for nsproxy 
> > though.
> 
> I think the only issue is the child_reaper and currently we only have one of
> those.  When we really do the pid namespace we are going to have to revisit
> this.  My gut feel says that we won't be able to exit our pid namespace until
> the process is waited on.  So we may need to break up exit_task_namespace into
> individual components.

It makes little sense, afaics, to have an interruptible sleep in
something like lockd_down() if you have no pid space or signal handling.

That isn't the only place where the process has to wait in an NFS
unmount, BTW. Things like rpc client cleanup (waiting for all the RPC
tasks to complete) also tend to lead to interruptible sleeps.

Trond


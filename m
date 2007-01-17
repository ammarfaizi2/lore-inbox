Return-Path: <linux-kernel-owner+w=401wt.eu-S1751016AbXAQW4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXAQW4V (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXAQW4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:56:20 -0500
Received: from mail.screens.ru ([213.234.233.54]:59516 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbXAQW4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:56:19 -0500
Date: Thu, 18 Jan 2007 01:55:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, akpm@osdl.org, trond.myklebust@fys.uio.no,
       Linux Containers <containers@lists.osdl.org>
Subject: Re: NFS causing oops when freeing namespace
Message-ID: <20070117225524.GA1572@tv-sign.ru>
References: <57238.192.168.101.6.1169029688.squirrel@intranet> <m18xg1akmd.fsf@ebiederm.dsl.xmission.com> <51072.192.168.101.6.1169039633.squirrel@intranet> <20070117185823.GA878@tv-sign.ru> <45AE7705.4040603@fr.ibm.com> <20070117194632.GA1071@tv-sign.ru> <45AE87BC.4030404@fr.ibm.com> <m1d55d8ex3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d55d8ex3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17, Eric W. Biederman wrote:
>
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

I agree, but please note that the child_reaper is not the only issue. Think
about sub-thread which auto-reaps itself. I'd suggest to add the comment in
do_exit() after exit_notify() to remind that the task is really dead now, it
has no ->signal, it can't be seen in /proc/, we can't send a signal to it, etc.

Oleg.


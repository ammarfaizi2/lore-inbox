Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWCTTeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWCTTeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWCTTeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:34:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37504 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964845AbWCTTeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:34:11 -0500
Date: Mon, 20 Mar 2006 11:34:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 2/6] sysvmsg: containerize
Message-ID: <20060320193414.GQ15997@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235250.35676515@localhost.localdomain> <20060307015745.GG27645@sorel.sous-sol.org> <1141697323.9274.64.camel@localhost.localdomain> <20060307023445.GI27645@sorel.sous-sol.org> <m1r74ywinp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r74ywinp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> Chris Wright <chrisw@sous-sol.org> writes:
> > The /proc interface is registering with &context->ids of init_task.  So,
> > all other contexts using that interface will be looking at the wrong
> > info, AFAICT.
> 
> We need to make this per process in /proc to get it right.
> So /proc/sysvipc becomes a symlink to /proc/<pid>/sysvipc.

That, and any considerations for context access to protect against
reading /proc/pid/sysvipc/* (assuming you can share pid namespace,
while not sharing sysvipc context).

> > As you can tell my concerns are in resource consumption.  If a user can
> > create contexts which it can hide from sysadmin, and they aren't subject
> > to sysadmin mandated resource limits, it's effectively a leak, esp. since
> > these resources don't die with exit(2).
> 
> I haven't spotted it yet in Dave's series but this is something that should
> happen when all of the tasks using the ipc_context in this case exit.

Making it look like an 'init 0' from the P.O.V. of that ipc_context, WFM.
Seems the context needs to have context limits so any privileged process
in the context is still subject to the top-level administered limits.

thanks,
-chris

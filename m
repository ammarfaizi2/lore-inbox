Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWAQRZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWAQRZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWAQRZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:25:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:9426 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932218AbWAQRZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:25:29 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1137513818.14135.23.camel@localhost.localdomain>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 09:25:14 -0800
Message-Id: <1137518714.5526.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 16:03 +0000, Alan Cox wrote: 
> On Maw, 2006-01-17 at 09:56 -0600, Serge E. Hallyn wrote:
> > The virtual pid is different depending on who is asking.  So simply
> > storing current->realpid and current->pid isn't helpful, as we would
> > still need to call a function when a pid crosses user->kernel boundary.
> 
> This is an obscure, weird piece of functionality for some special case
> usages most of which are going to be eliminated by Xen. I don't see the
> kernel side justification for it at all.

At least OpenVZ and vserver want very similar functionality.  They're
both working with out-of-tree patch sets.  We each want to do subtly
different things with tsk->pid, and task_pid() seemed to be a decent
place to start.  OpenVZ has a very similar concept in its pid_task()
function.

Arjan had a very good point last time we posted these: we should
consider getting rid of as many places in the kernel where pids are used
to uniquely identify tasks, and just stick with task_struct pointers.  

> Maybe you should remap it the other side of the user->kernel boundary ?

We would very much like to run unmodified applications and libraries.
Doing it in a patched libc is certainly a possibility, but it wouldn't
make any future customers very happy.

I also wonder if RedHat or SUSE would ever ship and support a special
set of libraries for us.  Oh, and there are always statically linked
apps... :)

-- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWELQya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWELQya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWELQya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:54:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26024 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750721AbWELQy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:54:29 -0400
Date: Fri, 12 May 2006 11:54:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, dev@sw.ru,
       sam@vilain.net, xemul@sw.ru, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
Message-ID: <20060512165421.GA15971@sergelap.austin.ibm.com>
References: <29vfyljM-1.2006059-s@us.ibm.com> <20060510021135.GC32523@sergelap.austin.ibm.com> <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com> <20060510132623.GB20892@sergelap.austin.ibm.com> <m1ac9pwves.fsf@ebiederm.dsl.xmission.com> <20060510203449.GA12215@sergelap.austin.ibm.com> <m1ejz1vc2d.fsf@ebiederm.dsl.xmission.com> <20060512152412.GA11734@sergelap.austin.ibm.com> <1147448681.6623.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147448681.6623.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Hansen (haveblue@us.ibm.com):
> On Fri, 2006-05-12 at 10:24 -0500, Serge E. Hallyn wrote:
> > 
> > -       exit_utsname(current);
> > -       exit_namespace(current);
> > -       exit_nsproxy(current);
> > +       exit_task_namespaces(current);
> >         current->nsproxy = init_task.nsproxy;
> > -       get_nsproxy(current->nsproxy);
> > -       get_namespace(current->nsproxy->namespace);
> > -       get_uts_ns(current->nsproxy->uts_ns);
> > +       get_namespaces(current); 
> 
> That really cleans up the main path quite a bit.  Very nice.
> 
> For parity with exit_task_namespaces(), should that be called
> get_task_namespaces()?

Yup, that would make sense.  Will update the patch in my git tree.

Though those functions be renamed when the namespaces->count becomes
#nsproxies.  Getting a weird regression with that patch, though, so
won't be sending that out today.

thanks,
-serge

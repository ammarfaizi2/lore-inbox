Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWDGT2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWDGT2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWDGT2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:28:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15002 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964908AbWDGT2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:28:07 -0400
Date: Fri, 7 Apr 2006 14:28:00 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 0/5] uts namespaces: Introduction
Message-ID: <20060407192800.GE28729@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <m1wte1mcim.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wte1mcim.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Introduce utsname namespaces.  Instead of a single system_utsname
> > containing hostname domainname etc, a process can request it's
> > copy of the uts info to be cloned.  The data will be copied from
> > it's original, but any further changes will not be seen by processes
> > which are not it's children, and vice versa.
> >
> > This is useful, for instance, for vserver/openvz, which can now clone
> > a new uts namespace for each new virtual server.
> >
> > This patchset is based on Kirill Korotaev's Mar 24 submission, taking
> > comments (in particular from James Morris and Eric Biederman) into
> > account.
> >
> > Some performance results are attached.  I was mainly curious whether
> > it would be worth putting the task_struct->uts_ns pointer inside
> > a #ifdef CONFIG_UTS_NS.  The result show that leaving it in when
> > CONFIG_UTS_NS=n has negligable performance impact, so that is the
> > approach this patch takes.
> 
> Ok.  This looks like the best version so far.
> 
> I like the utsname() function thing to shorten the 
> idiom of  current->uts_ns->name.
> 
> We probably want to introduce utsname() and an init_utsname()
> before any of the other changes, and then perform the substitutions,

This is the same as what Sam is saying, right?  Just making sure I
understand.

> before we actually change the code so the patchset can make it
> through a git-bisect.  This will also allows for something

Ok, I've finally got the rest of git doing my bidding, I'll go read
up on git-bisect.

thanks for the comments,
-serge

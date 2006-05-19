Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWESIwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWESIwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 04:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWESIwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 04:52:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52647 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751102AbWESIwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 04:52:14 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 19 May 2006 02:50:19 -0600
In-Reply-To: <20060518154700.GA28344@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Thu, 18 May 2006 10:47:00 -0500")
Message-ID: <m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> This patchset introduces a per-process utsname namespace.  These can
> be used by openvz, vserver, and application migration to virtualize and
> isolate utsname info (i.e. hostname).  More resources will follow, until
> hopefully most or all vserver and openvz functionality can be implemented
> by controlling resource namespaces from userspace.
>
> Previous utsname submissions placed a pointer to the utsname namespace
> straight in the task_struct.  This patchset (and the last one) moves
> it and the filesystem namespace pointer into struct nsproxy, which is
> shared by processes sharing all namespaces.  The intent is to keep
> the taskstruct smaller as the number of namespaces grows.


Previously you mentioned:
> BTW - a first set of comparison results showed nsproxy to have better
> dbench and tbench throughput, and worse kernbench performance.  Which
> may make sense given that nsproxy results in lower memory usage but
> likely increased cache misses due to extra pointer dereference.

Is this still true?  Or did our final reference counting tweak fix
the kernbench numbers?

I just want to be certain that we don't add an optimization,
that reduces performance.

> Changes:
> 	- the reference count on fs namespace and uts namespace now
> 	  refers to the number of nsproxies pointing to it
> 	- some consolidation of namespace cloning and exit code to
> 	  clean up kernel/{fork,exit}.c
> 	- passed ltp and ltpstress on smp power, x86, and x86-64
> 	  boxes.

Nice.

Eric


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbVLOW65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVLOW65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVLOW64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:58:56 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:64203 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751195AbVLOW6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:58:55 -0500
Subject: Re: [ckrm-tech] Re: [RFC][patch 00/21] PID Virtualization:
	Overview and Patches
From: Matt Helsley <matthltc@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Hubertus Franke <frankeh@watson.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <1134676961.22525.72.camel@localhost>
References: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
	 <1134676961.22525.72.camel@localhost>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 14:52:49 -0800
Message-Id: <1134687169.10396.33.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 12:02 -0800, Dave Hansen wrote:
> On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> > I think perhaps this could also be the basis for a CKRM "class"
> > grouping as well.  Rather than maintaining an independent class
> > affiliation for tasks, why not have a class devolve (evolve?) into
> > a "container" as described here.
> 
> Wasn't one of the grand schemes of CKRM to be able to have application
> instances be shared?  For instance, running a single DB2, Oracle, or
> Apache server, and still accounting for all of the classes separately.
> If so, that wouldn't work with a scheme that requires process
> separation.

	f-series CKRM manages tasks via the task struct -- this means it
manages each thread and not a process. Since, generally speaking, each
thread is assigned the same class as the main thread this effectively
manages processes. So yes, separate DB2, Oracle, Apache, etc. threads
could be assigned to different classes. This is definitely something a
strict container could not do.

> But, sharing the application instances is probably mostly (only)
> important for databases anyway.  I would imagine that most of the

<nit>
I wouldn't say only for databases. human-interaction-bound processes can
share instances (gnome-terminal). Granted, these probably would never
need to span a container or a class...
</nit>

> overhead in a server like an Apache instance is for the page cache for
> content, as well as a bit for Apache's executables themselves.  The
> container schemes should be able to share page cache for both cases.
> The main issues would be managing multiple configurations, and the
> increased overhead from having more processes around than with a single
> server.
> 
> There might also be some serious restrictions on containerized
> applications.  For instance, taking a running application, moving it out
> of one container, and into another might not be feasible.  Is this
> something that is common or desired in the current CKRM framework?
> 
> -- Dave

	Yes, being able to move a process from one class to another is
important. This can happen as a consequence of the system administrator
deciding to change the distribution of resources without having to
restart services. The change in distribution can be done by changing
shares of a class, manually moving processes between classes, by making
or deleting classes, or a combination of these operations.

Cheers,
	-Matt Helsley


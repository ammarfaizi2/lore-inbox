Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWATUOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWATUOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWATUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:14:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:16304 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932151AbWATUN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:13:59 -0500
Date: Fri, 20 Jan 2006 14:13:53 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org,
       "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC: Multiple instances of kernel namespaces.
Message-ID: <20060120201353.GA13265@sergelap.austin.ibm.com>
References: <43CD18FF.4070006@FreeBSD.org> <1137517698.8091.29.camel@localhost.localdomain> <43CD32F0.9010506@FreeBSD.org> <1137521557.5526.18.camel@localhost.localdomain> <1137522550.14135.76.camel@localhost.localdomain> <1137610912.24321.50.camel@localhost.localdomain> <1137612537.3005.116.camel@laptopd505.fenrus.org> <1137613088.24321.60.camel@localhost.localdomain> <1137624867.1760.1.camel@localhost.localdomain> <m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
> At this point I have to confess I have been working on something
> similar, to IBM's pid virtualization work.  But I have what is at
> least for me a unifying concept, that makes things easier to think
> about.
> 
> The idea is to think about things in terms of namespaces.  Currently
> in the kernel we have the fs/mount namespace already implemented.
> 
> Partly this helps on what the interface for creating a new namespace
> instance should be.  'clone(CLONE_NEW<NAMESPACE_TYPE>)', and how
> it should be managed from the kernel data structures.
> 
> Partly thinking of things as namespaces helps me scope the problem.
> 
> Does this sound like a sane approach?

And a bonus of this is that for security and vserver-type applications,
the CLONE_NEWPID and CLONE_NEWFS will often happen at the same time.

How do you (or do you?) address naming namespaces?  This would be
necessary for transitioning into an existing namespace, performing
actions on existing namespaces (i.e. checkpoint, migrate to another
machine, enter the namespace and kill pid 521), and would just be
useful for accounting purposes, i.e. how else do you have a
"ps --all-namespaces" specify a process' namespace?

Doubt we want to add an argument to clone(), so do we just add a new
proc, sysfs, or syscall for setting a pid-namespace name?

Do we need a new syscall for transitioning into an existing namespace?

thanks,
-serge

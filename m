Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWATUWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWATUWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWATUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:22:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1723 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932164AbWATUWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:22:46 -0500
Message-ID: <43D14695.3000102@watson.ibm.com>
Date: Fri, 20 Jan 2006 15:22:45 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC: Multiple instances of kernel namespaces.
References: <43CD18FF.4070006@FreeBSD.org> <1137517698.8091.29.camel@localhost.localdomain> <43CD32F0.9010506@FreeBSD.org> <1137521557.5526.18.camel@localhost.localdomain> <1137522550.14135.76.camel@localhost.localdomain> <1137610912.24321.50.camel@localhost.localdomain> <1137612537.3005.116.camel@laptopd505.fenrus.org> <1137613088.24321.60.camel@localhost.localdomain> <1137624867.1760.1.camel@localhost.localdomain> <m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com> <20060120201353.GA13265@sergelap.austin.ibm.com>
In-Reply-To: <20060120201353.GA13265@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
>>At this point I have to confess I have been working on something
>>similar, to IBM's pid virtualization work.  But I have what is at
>>least for me a unifying concept, that makes things easier to think
>>about.
>>
>>The idea is to think about things in terms of namespaces.  Currently
>>in the kernel we have the fs/mount namespace already implemented.
>>
>>Partly this helps on what the interface for creating a new namespace
>>instance should be.  'clone(CLONE_NEW<NAMESPACE_TYPE>)', and how
>>it should be managed from the kernel data structures.
>>
>>Partly thinking of things as namespaces helps me scope the problem.
>>
>>Does this sound like a sane approach?
> 
> 
> And a bonus of this is that for security and vserver-type applications,
> the CLONE_NEWPID and CLONE_NEWFS will often happen at the same time.
> 
> How do you (or do you?) address naming namespaces?  This would be
> necessary for transitioning into an existing namespace, performing
> actions on existing namespaces (i.e. checkpoint, migrate to another
> machine, enter the namespace and kill pid 521), and would just be
> useful for accounting purposes, i.e. how else do you have a
> "ps --all-namespaces" specify a process' namespace?
> 
> Doubt we want to add an argument to clone(), so do we just add a new
> proc, sysfs, or syscall for setting a pid-namespace name?
> 
> Do we need a new syscall for transitioning into an existing namespace?
> 
> thanks,
> -serge
> 


Just addressed a few of this in my previous reply to the other thread.

However, question here is whether the container (as we used it) provides
the "binding" object for these clones. One question for me then is
whether cloning of namespaces is always done in tandem.
As you are bringing the migration up, we can only clone fully contained
namespaces ! One could make that a condition of the migration or build
it right into the initial structure. Any thoughts on that ?

-- Hubertus


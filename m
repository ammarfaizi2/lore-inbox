Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293633AbSCFQEX>; Wed, 6 Mar 2002 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293639AbSCFQEN>; Wed, 6 Mar 2002 11:04:13 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:21553 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S293634AbSCFQD6>; Wed, 6 Mar 2002 11:03:58 -0500
Date: Wed, 6 Mar 2002 10:03:57 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200203061603.KAA21855@tomcat.admin.navo.hpc.mil>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <E16ict0-0002zT-00@starship.berlin>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@bonn-fries.net>:
> On March 5, 2002 07:30 pm, Benjamin LaHaise wrote:
> > On Tue, Mar 05, 2002 at 01:12:19PM -0500, Jeff Dike wrote:
> > > Really?  And you're unconcerned about the impact on the rest of the system
> > > of a UML grabbing (say) 128M of memory when it starts up?  Especially if it
> > > may never use it?
> > 
> > Honestly, I think that most people want to know if the system they've setup 
> > is overcommited at as early a point as possible: a UML failing at startup 
> > with out of memory is better than random segvs at some later point when the 
> > system is under load.  Refer to the principle of least surprise.  And if the 
> > user truely wants to disable that, well, you can give them a command line 
> > option to shoot themselves in the foot with.
> 
> Suppose you have 512 MB memory and an equal amount of swap.  You start 8
> umls with 64 MB each.  With your and Peter's suggestion, the system always
> goes into swap.  Whereas if the memory is only allocated on demand it
> probably doesn't.

Not unless the VM is really bad... All that is called for is that the
virtual space be available. Each umls gets 64 MB, but the rest is guaranteed
available via swap. Nothing has to swap until all processes have expanded
to use all available ram. Currently the only way to ensure that the memory
IS available is to modify every page at startup. Yes it will swap the modified
pages.

But it should only do so once, until the pages are really needed.

Otherwise the umls run until the system goes OOM - then somebody gets killed.
Much nicer to have it die at the beginning instead of after 4-5 hours of
operation when it needs just "one more page" only to find out that the system
lied when it said it was available.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

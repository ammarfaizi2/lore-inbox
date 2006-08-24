Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965330AbWHXBqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965330AbWHXBqf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbWHXBqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:46:35 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60988 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965330AbWHXBqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:46:34 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=r4+euuMl1pjIpaYlUhX1HTfbKUiaeYeKIgq6dR1uocCOR1eBMIDv+rSSVGqI8flhj
	gQQWJ84KfiIwqNZ923maw==
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156272902.6479.110.camel@linuxchandra>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 23 Aug 2006 18:44:41 -0700
Message-Id: <1156383881.8324.51.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 11:55 -0700, Chandra Seetharaman wrote:
> On Mon, 2006-08-21 at 18:45 -0700, Rohit Seth wrote:
> > 
> > > > this is not 100% true.
> > > > UBC itself doesn't prevent from changing context on the fly.
> > > > But since this leads to part of resources to be charged to
> > > > one UBC and another part to another UBC and so long and so
> > > 
> > > Let the controllers and the users worry about that part. 
> > > 
> > 
> > I think as the tasks move around, it becomes very heavy to move all the
> > pages belonging to previous container to a new container.
> 
> Not for all resources, CPU could handle it very nicely, whereas memory
> would be heavy. My point is that the infrastructure should be open, and
> controller is the one that decides whether it wants to handle it or not.

With open you are implying being able to use different ones.  It would
be nice to get one in and make sure it is stable and optimized...

>  
> > 
> > > As I mentioned UBC might be perfect for container resource management,
> > > but what I am talking for is resource management _without_ a container.
> > > 
> > 
> > Can you explain that part a bit more?
> 
> Basically I was saying that even though resource management in container
> and non-container have mostly same requirements, there are few
> requirements that are critical in non-container scenario which are non-
> issue in container scenario (for example, moving tasks from one resource
> group to another).
> 
> In effect, Design of the infrastructure should not limit non-container
> usages. 
> 
> IMO, non-container requirements are a superset of container requirements
> (resource management purposes only :).
> 

hmm, non-container world (and its resource management part) already
exist.  And sure those requirements are superset of this discussion.
And hopefully container support will not break/modify that much.
 
> > 
> > > > 
> > > > > - No ability to maintain resource specific data in the controller.
> > > > it's false. fields can be added to user_beancounter struct easily.
> > > > and that's what our controllers do.
> > > 
> > > With the model of static array for resources (struct ubparm ub_parms
> > > [UB_RESOURCES] in struct user_beancounter), it is not be possible to
> > > attach _different_ "controller specific" information to each of the
> > > entries.
> > > 
> > > I do not think it is good idea to add controller specific information of
> > > _different_ controllers to the user_beancounter. Think of all the fields
> > > it will have when all the numproc controller needs is just the basic 3-4
> > > fields.
> > > 
> > 
> > IMO it is okay to add  the fields whenever necessary as Kirill
> > suggested.  I think once the container subject gets baked a little more,
> > the controllers will also get tightly coupled.  
> 
> I think my point is not understood. I do not think it is right to add
> _controller specific_ fields to the generic data structure (struct
> user_beancounter), as we will end up with a generic data structure which
> will have so many fields that are not used in so many controllers.
> 

A single centralized structure that has fields that are mostly used by
every one should be okay I think.

> > 
> > > > 
> > > > > - No ability to get the list of tasks belonging to a UBC.
> > > > it is not true. it can be read from /proc or system calls interface,
> > > > just like the way one finds all tasks belonging to one user :)
> > > > 
> > > > BTW, what is so valueable in this feature?
> > > 
> > > Again, it may not be useful for container type usages (you can probably
> > > get the list from somewhere else, but for resource management it is
> > > useful for sysadmins).
> > > 
> > 
> > I'm also debating about whether printing task information is really any
> > useful.  If a sysadm wants to get information about any particular task
> > then that can come from /proc/<pid>/container  Though container list
> > will be one place where one can easily get the list of all the contained
> > tasks (and other resources like files).
> 
> In non-container environment, there is _no_ /proc/pid/container, as
> there is no concept of container :). This will be useful for non-
> container scenario.
> 

I'm sure when container support gets in then for the above scenario it
will read -1 ...

-rohit


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWHHRTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWHHRTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWHHRTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:19:05 -0400
Received: from smtp-out.google.com ([216.239.45.12]:26551 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964953AbWHHRTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:19:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=pSkuOo3C9Db2HAyPp+OfQj/3XfWCXxRGI1ZR+To+qhj0Cn5Hw/XSaSFxG5xYimwFX
	PcA/oM+quRmf1pMwCJT+w==
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management
	-	A	cpu controller
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
In-Reply-To: <44D83A7D.80600@sw.ru>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org>
	 <20060803224253.49068b98.akpm@osdl.org>
	 <1154684950.23655.178.camel@localhost.localdomain>
	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
	 <20060804153123.GB32412@in.ibm.com>  <44D36FB5.3050002@sw.ru>
	 <1154716024.7228.32.camel@galaxy.corp.google.com> <44D6E98C.9090208@sw.ru>
	 <1154970846.31962.17.camel@galaxy.corp.google.com>  <44D83A7D.80600@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 08 Aug 2006 10:16:32 -0700
Message-Id: <1155057392.1072.66.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 11:17 +0400, Kirill Korotaev wrote:
> >>>>>Doesnt the ability to move tasks between groups dynamically affect
> >>>>>(atleast) memory controller design (in giving up ownership etc)?
> >>>>
> >>>>we save object owner on the object. So if you change the container,
> >>>>objects are still correctly charged to the creator and are uncharged
> >>>>correctly on free.
> >>>>
> >>>
> >>>
> >>>Seems like the object owner should also change when the object moves
> >>>from one container to another.
> > 
> > 
> >>Consider a file which is opened in 2 processes. one of the processes
> >>wants to move to another container then. How would you decide whether
> >>to change the file owner or not?
> >>
> > 
> > 
> > If a process has sufficient rights to move a file to a new container
> > then it should be okay to assign the file to the new container.  

> there is no such notion as  "rights to move a file to a new container".
> The same file can be opened in processes belonging to other containers.
> And you have no any clue whether to have to change the owner or not.
> 

I think this is where more details on a design will help.  What I'm
thinking is each address_space to have a container pointer.  In this
case, pages belonging to a file will charge against one single container
(irrespective of how many processes are touching those pages).

> > Though the point is, if a resource (like file) is getting migrated to a
> > new container then all the attributes (like owner, #pages in memory
> > etc.) attached to that resource (file) should also migrate to this new
> > container.  Otherwise the semantics of where does the resource belong
> > becomes very difficult.
> The same for many other resources. It is a big mistake thinking that most resources
> belong to the processes and the owner process can be easily determined.
> 

Sure that some resources it wouldn't make sense to move (or find out at
which is the real owner).  And I'm not saying that we have to bind them
hard to a process either...but to a single container if they belong to a
same file (for example).

-rohit


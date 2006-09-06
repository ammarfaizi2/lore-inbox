Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWIFATG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWIFATG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422628AbWIFATG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:19:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21514 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1422634AbWIFATD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:19:03 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=GYHMt04Su/yedNja2rnGDjtoxapvU+vHtamcsiYhPQ/yvrlQe3p+dG11jx/OiyPVp
	a/oBo+vKNuNzRBknwcjKQ==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <1157478392.3186.26.camel@localhost.localdomain>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 05 Sep 2006 17:17:58 -0700
Message-Id: <1157501878.11268.77.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 10:46 -0700, Dave Hansen wrote:
> On Tue, 2006-09-05 at 19:02 +0400, Kirill Korotaev wrote:
> > Core Resource Beancounters (BC) + kernel/user memory control.
> > 
> > BC allows to account and control consumption
> > of kernel resources used by group of processes. 
> 
> Hi Kirill, 
> 
> I've honestly lost track of these discussions along the way, so I hope
> you don't mind summarizing a bit.
> 
> Do these patches help with accounting for anything other than memory?
> Will we need new user/kernel interfaces for cpu, i/o bandwidth, etc...?
> 
> Have you given any thought to the possibility that a task might need to
> move between accounting contexts?  That has certainly been a
> "requirement" pushed on to CKRM for a long time, and the need goes
> something like this:
> 
> 1. A system runs a web server, which services several virtual domains
> 2. that web server receives a request for foo.com
> 3. the web server switches into foo.com's accounting context
> 4. the web server reads things from disk, allocates some memory, and
>    makes a database request.
> 5. the database receives the request, and switches into foo.com's
>    accounting context, and charges foo.com for its resource use
> etc...
> 

I'm wondering why not have different processes to serve different
domains on the same physical server...particularly when they have
different database to work on.  Is the amount of memory that you save by
having a single copy that much useful that you are even okay to
serialize the whole operation (What would happen, while the request for
foo.com is getting worked on, there is another request for
foo_bar.com...does it need to wait for foo.com request to get done
before it can be served).

> So, the goal is to run _one_ copy of an application on a system, but
> account for its resources in a much more fine-grained way than at the
> application level.
> 

What is that fine grained way.  If not process based then can it be
associated with file system location?

-rohit


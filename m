Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWIHRLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWIHRLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWIHRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:11:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:27899 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750705AbWIHRLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:11:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=XkKauxpDdXmRQhqfo455M2ceE6c5O1zN/U9MuqMQGOHwQqX2p+xy72gCTWZSeuL2F
	MTbgBScph8QiAut2TS1Eg==
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
In-Reply-To: <1157729450.26324.44.camel@localhost.localdomain>
References: <44FD918A.7050501@sw.ru>
	 <1157478392.3186.26.camel@localhost.localdomain>
	 <1157501878.11268.77.camel@galaxy.corp.google.com>
	 <1157729450.26324.44.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 08 Sep 2006 10:10:37 -0700
Message-Id: <1157735437.1214.32.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 08:30 -0700, Dave Hansen wrote:
> On Tue, 2006-09-05 at 17:17 -0700, Rohit Seth wrote:
> > I'm wondering why not have different processes to serve different
> > domains on the same physical server...particularly when they have
> > different database to work on.
> 
> This is largely because this is I think how it is done today, and it has
> a lot of disadvantages.

If it has lot of disadvantages then we should try to avoid that
mechanism.  Though I think it is okay to allow processes to be moved
around with the clear expectation that it is a very heavy operation (as
I think at least all the anon pages should be moved too along with task)
and should not be generally done.

>   They also want to be able to account for
> traffic on the same database.  Think of a large web hosting environment
> where you charged everyone (hundreds or thousands of users) by CPU and
> I/O bandwidth used at all levels of a given transaction.
> 
> > Is the amount of memory that you save by
> > having a single copy that much useful that you are even okay to
> > serialize the whole operation (What would happen, while the request for
> > foo.com is getting worked on, there is another request for
> > foo_bar.com...does it need to wait for foo.com request to get done
> > before it can be served).
> 
> Let's put it this way.  Enterprise databases can be memory pigs.  It
> isn't feasible to run hundreds or thousands of copies on each machine.  
> 


The extra cost is probably the stack and private data segment...yes
there could be trade offs there depending on how big these segments are.
Though if there are big shared segments then that can be charged to a
single container.

Thanks,
-rohit


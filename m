Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWIMB0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWIMB0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWIMB0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:26:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:21880 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030475AbWIMB0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:26:51 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=aZ+7P7SHzzymQrVZDS3BO6EbzYXMg1C68KSwv+45Dl7c3UPfUODiQW4zdJCcpDeCx
	NBjr/uuUx+jaG09D/e3OQ==
Subject: Re: [ckrm-tech] [PATCH] BC: resource
	beancounters	(v4)	(added	user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158109818.4800.39.camel@linuxchandra>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <1158003725.6029.60.camel@linuxchandra>
	 <1158019099.12947.102.camel@galaxy.corp.google.com>
	 <1158105253.4800.20.camel@linuxchandra>
	 <1158107948.20211.47.camel@galaxy.corp.google.com>
	 <1158109818.4800.39.camel@linuxchandra>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 12 Sep 2006 18:25:51 -0700
Message-Id: <1158110751.20211.61.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 18:10 -0700, Chandra Seetharaman wrote:
> On Tue, 2006-09-12 at 17:39 -0700, Rohit Seth wrote:
> <snip>
> > > yes, it would be there, but is not heavy, IMO.
> > 
> > I think anything greater than 1% could be a concern for people who are
> > not very interested in containers but would be forced to live with them.
> 
> If they are not interested in resource management and/or containers, i
> do not think they need to pay.
> > 

Think of a single kernel from a vendor that has container support built
in.

> > > > 
> > > > > > 
> > > > > > And anything running outside a container should be limited by default
> > > > > > Linux settings.
> > > > > 
> > > > > note that the resource available to the default RG will be (total system
> > > > > resource - allocated to RGs).
> > > > 
> > > > I think it will be preferable to not change the existing behavior for
> > > > applications that are running outside any container (in your case
> > > > default resource group).
> > > 
> > > hmm, when you provide QoS for a set of apps, you will affect (the
> > > resource availability of) other apps. I don't see any way around it. Any
> > > ideas ?
> > 
> > When I say, existing behavior, I mean not getting impacted by some
> > artificial limits that are imposed by container subsystem.  IOW, if a
> 
> That is what I understood and replied above.
> > sysadmin is okay to have certain apps running outside of container then
> > he is basically forgoing any QoS for any container on that system.
> 
> Not at all. If the container they are interested in is guaranteed, I do
> not see how apps running outside a container would affect them.
> 

Because the kernel (outside the container subsystem) doesn't know of
these guarantees...unless you modify the page allocator to have another
variant of overcommit memory.

> <snip>
> > > > > Not really. 
> > > > >  - Each RG will have a guarantee and limit of each resource. 
> > > > >  - default RG will have (system resource - sum of guarantees)
> > > > >  - Every RG will be guaranteed some amount of resource to provide QoS
> > > > >  - Every RG will be limited at "limit" to prevent DoS attacks.
> > > > >  - Whoever doesn't care either of those set them to don't care values.
> > > > > 
> > > > 
> > > > For the cases that put this don't care, do you depend on existing
> > > > reclaim algorithm (for memory) in kernel?
> > > 
> > > Yes.
> > 
> > So one container with these don't care condition(s) can turn the whole
> > guarantee thing bad.  Because existing kernel reclaimer does not know
> > about memory commitments to other containers.  Right?
> 
> No, the reclaimer would free up pages associated with the don't care RGs
> ( as the user don't care about the resource made available to them).
> 

And how will the kernel reclaimer know which RGs are don't care?

-rohit


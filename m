Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWIKTMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWIKTMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWIKTMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:12:00 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60345 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964936AbWIKTL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:11:59 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=NNpTstLibLPGH7tD8uyWZ9tIiBTFQ+NmoxPx4a+jKuKWmHOmfMByrRFufEwvGOvhT
	7zHBIykyBCKMQg/JA3Bog==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added
	user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1157999107.6029.7.camel@linuxchandra>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 11 Sep 2006 12:10:31 -0700
Message-Id: <1158001831.12947.16.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 11:25 -0700, Chandra Seetharaman wrote:
> On Fri, 2006-09-08 at 14:43 -0700, Rohit Seth wrote:
> <snip>
> 
> > > > Guarantee may be one of
> > > > 
> > > >   1. container will be able to touch that number of pages
> > > >   2. container will be able to sys_mmap() that number of pages
> > > >   3. container will not be killed unless it touches that number of pages
> > > >   4. anything else
> > > 
> > > I would say (1) with slight modification
> > >    "container will be able to touch _at least_ that number of pages"
> > > 
> > 
> > Does this scheme support running of tasks outside of containers on the
> > same platform where you have tasks running inside containers.  If so
> > then how will you ensure processes running out side any container will
> > not leave less than the total guaranteed memory to different containers.
> > 
> 
> There could be a default container which doesn't have any guarantee or
> limit. 

First, I think it is critical that we allow processes to run outside of
any container (unless we know for sure that the penalty of running a
process inside a container is very very minimal).

And anything running outside a container should be limited by default
Linux settings.

> When you create containers and assign guarantees to each of them
> make sure that you leave some amount of resource unassigned. 
                           ^^^^^ This will force the "default" container
with limits (indirectly). IMO, the whole guarantee feature gets defeated
the moment you bring in this fuzziness.

> That
> unassigned resources can be used by the default container or can be used
> by containers that want more than their guarantee (and less than their
> limit). This is how CKRM/RG handles this issue.
> 
>  

It seems that a single notion of limit should suffice, and that limit
should more be treated as something beyond which that resource
consumption in the container will be throttled/not_allowed.

-rohit


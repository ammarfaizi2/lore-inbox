Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWHQRJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWHQRJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWHQRJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:09:44 -0400
Received: from smtp-out.google.com ([216.239.45.12]:14748 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964790AbWHQRJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:09:43 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=upPKE4sBJENhXs2w5Cll8ESBxE/IJlPU0mlmf4WCKrzXDeixk5OJeZLPPy/2hpII0
	bbcfEvUubvxBRCWhPAFfQ==
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E45D6A.8000003@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:08:19 -0700
Message-Id: <1155834499.14617.38.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 16:13 +0400, Kirill Korotaev wrote:
> Rohit Seth wrote:
> > On Wed, 2006-08-16 at 20:04 +0100, Alan Cox wrote:
> > 
> >>Ar Mer, 2006-08-16 am 11:17 -0700, ysgrifennodd Rohit Seth:
> >>
> >>>I think there should be a check here for seeing if the new limits are
> >>>lower than the current usage of a resource.  If so then take appropriate
> >>>action.
> >>
> >>Generally speaking there isn't a sane appropriate action because the
> >>resources can't just be yanked.
> >>
> > 
> > 
> > I was more thinking about (for example) user land physical memory limit
> > for that bean counter.  If the limits are going down, then the system
> > call should try to flush out page cache pages or swap out anonymous
> > memory.  But you are right that it won't be possible in all cases, like
> > for in kernel memory limits.
> Such kind of memory management is less efficient than the one 
> making decisions based on global shortages and global LRU alogrithm.
> 
> The problem here is that doing swap out takes more expensive disk I/O
> influencing other users.
> 
> So throttling algorithms if wanted should be optional, not mandatory.
> Lets postpone it and concentrate on the core.
> 


I'm really interested in seeing what changes you make in alloc_page when
the container limits are hit.  

When a container is throttling then yes it will have some additional
cost to other containers but that is the cost of sharing an underlying
platform.

-rohit


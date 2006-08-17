Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWHQRGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWHQRGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWHQRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:06:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:38042 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965130AbWHQRGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:06:38 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=VW7uTR9mH/MdGGOvkKrzVTDs4x1p9KY/pSdwSOjD5oT7sk+ejx2b8lECgGGt/Cppq
	f/jms/UCqfs1rHTJmKD1g==
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E45B6B.8080800@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com> <44E45B6B.8080800@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:05:19 -0700
Message-Id: <1155834319.14617.33.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 16:04 +0400, Kirill Korotaev wrote:
> >>Add the following system calls for UB management:
> >>  1. sys_getluid    - get current UB id
> >>  2. sys_setluid    - changes exec_ and fork_ UBs on current
> >>  3. sys_setublimit - set limits for resources consumtions
> >>
> > 
> > 
> > Why not have another system call for getting the current limits?
> will add sys_getublimit().
> 
> > But as I said in previous mail, configfs seems like a better choice for
> > user interface.  That way user has to go to one place to read/write
> > limits, see the current usage and other stats.
> Check another email about interfaces. I have arguments against it :/
> 

...and I'm still not convinced that syscall is the right approach.

> > I think there should be a check here for seeing if the new limits are
> > lower than the current usage of a resource.  If so then take appropriate
> > action.
> any idea what exact action to add here?
> Looks like can be added when needed, agree?
> 

When you have the support of user memory, then operations like flush the
extra pages belonging to the container to disk seems reasonable.

-rohit


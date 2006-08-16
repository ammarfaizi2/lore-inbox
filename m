Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWHPT7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWHPT7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHPT7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:59:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47802 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932201AbWHPT7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:59:35 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155755729.22595.101.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 12:59:29 -0700
Message-Id: <1155758369.9274.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 12:15 -0700, Rohit Seth wrote:
> My preference would be to have container (I keep on saying container,
> but resource beancounter) pointer embeded in task, mm(not sure),
> address_space and anon_vma structures. 

Hmm.  If we can embed it in the mm, then we can get there from any given
anon_vma (or any pte for that matter).  Here's a little prototype for
doing just that:

http://www.sr71.net/patches/2.6.18/2.6.18-rc4-mm1-lxc1/broken-out/modify-lru-walk.patch

See file/anon_page_has_naughty_cpuset().  Anybody see any basic problems
with doing it that way?

 One trick with putting it in an mm is that we don't have a direct
relationship between processes and mm's.  We could also potentially have
two different threads of a process in two different accounting contexts.
But, that might be as simple to fix as disallowing things that share mms
from being in different accounting contexts, unless you unshare the mm.

-- Dave


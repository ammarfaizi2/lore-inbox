Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbWIERrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbWIERrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWIERrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:47:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45962 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965228AbWIERrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:47:01 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
	memory)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <44FD918A.7050501@sw.ru>
References: <44FD918A.7050501@sw.ru>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:46:32 -0700
Message-Id: <1157478392.3186.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 19:02 +0400, Kirill Korotaev wrote:
> Core Resource Beancounters (BC) + kernel/user memory control.
> 
> BC allows to account and control consumption
> of kernel resources used by group of processes. 

Hi Kirill, 

I've honestly lost track of these discussions along the way, so I hope
you don't mind summarizing a bit.

Do these patches help with accounting for anything other than memory?
Will we need new user/kernel interfaces for cpu, i/o bandwidth, etc...?

Have you given any thought to the possibility that a task might need to
move between accounting contexts?  That has certainly been a
"requirement" pushed on to CKRM for a long time, and the need goes
something like this:

1. A system runs a web server, which services several virtual domains
2. that web server receives a request for foo.com
3. the web server switches into foo.com's accounting context
4. the web server reads things from disk, allocates some memory, and
   makes a database request.
5. the database receives the request, and switches into foo.com's
   accounting context, and charges foo.com for its resource use
etc...

So, the goal is to run _one_ copy of an application on a system, but
account for its resources in a much more fine-grained way than at the
application level.

I think we can probably use beancounters for this, if we do not worry
about migrating _existing_ charges when we change accounting context.
Does that make sense?

-- Dave


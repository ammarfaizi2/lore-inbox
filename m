Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbWHWWLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbWHWWLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWHWWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:11:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:35713 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965242AbWHWWLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:11:48 -0400
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
From: Matt Helsley <matthltc@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <44EC5CDB.5000505@sw.ru>
References: <44EC31FB.2050002@sw.ru> <44EC35EB.1030000@sw.ru>
	 <20060823133055.GB10449@martell.zuzino.mipt.ru>  <44EC5CDB.5000505@sw.ru>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:05:55 -0700
Message-Id: <1156370755.2510.707.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 17:49 +0400, Kirill Korotaev wrote:
> Alexey Dobriyan wrote:
> > On Wed, Aug 23, 2006 at 03:03:07PM +0400, Kirill Korotaev wrote:
> > 
> > 
> >>--- /dev/null
> >>+++ ./include/bc/beancounter.h
> > 
> > 
> >>+#define BC_RESOURCES	0
> > 
> > 
> > Do you want userspace to see it?
> yep.
> 
> >>+struct bc_resource_parm {
> >>+	unsigned long barrier;	/* A barrier over which resource allocations
> >>+				 * are failed gracefully. e.g. if the amount
> >>+				 * of consumed memory is over the barrier
> >>+				 * further sbrk() or mmap() calls fail, the
> >>+				 * existing processes are not killed.
> >>+				 */
> >>+	unsigned long limit;	/* hard resource limit */
> >>+	unsigned long held;	/* consumed resources */
> >>+	unsigned long maxheld;	/* maximum amount of consumed resources */
> >>+	unsigned long minheld;	/* minumum amount of consumed resources */
> > 
> > 
> > Stupid question: when minimum amount is useful?
> to monitor usage statistics (range of used resources).
> this value will be usefull when ubstat will be added.
> this field probably would be more logical to add later,
> but since it is part of user space interface it is left here
> for not changing API later.

	Then I think it belongs in a separate patch. Add it and the scattered
bits and pieces that use it with the same patch. Then folks can clearly
see what it's for, where it impacts the code, and how it works. Yes,
factoring it out causes the API to evolve over the course of applying
the patch series -- IMHO that evolution is useful information to convey
to reviewers too.

Cheers,
	-Matt Helsley

